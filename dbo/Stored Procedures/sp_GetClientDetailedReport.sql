CREATE PROCEDURE sp_GetClientDetailedReport
    @ClientID INT,                  -- IN parameter (required)
    @TotalAmountSpent DECIMAL(12,2) OUTPUT,  -- OUT parameter
    @AvgDailySpend DECIMAL(10,2) OUTPUT,     -- OUT parameter
    @FavoriteRoomType NVARCHAR(20) OUTPUT    -- OUT parameter
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Initialize variables
    DECLARE @ReservationCount INT = 0;
    DECLARE @TotalNights INT = 0;
    DECLARE @RoomType NVARCHAR(20);
    DECLARE @RoomTypeCount INT;
    DECLARE @MaxCount INT = 0;
    
    -- Cursor to analyze all reservations
    DECLARE client_reservations CURSOR FOR
        SELECT 
            r.RoomID,
            rm.RoomType,
            r.TotalAmount,
            DATEDIFF(DAY, r.ArrivalDate, r.DepartureDate) AS Nights
        FROM Reservations r
        JOIN Rooms rm ON r.RoomID = rm.RoomID
        WHERE r.ClientID = @ClientID
        AND r.Status = 'completed';
    
    OPEN client_reservations;
    
    -- Create temp table to track room type preferences
    CREATE TABLE #RoomPrefs (RoomType NVARCHAR(20), UsageCount INT);
    
    -- Process each reservation
    DECLARE @RoomID INT, @Amount DECIMAL(12,2), @Nights INT;
    FETCH NEXT FROM client_reservations INTO @RoomID, @RoomType, @Amount, @Nights;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @ReservationCount = @ReservationCount + 1;
        SET @TotalAmountSpent = ISNULL(@TotalAmountSpent, 0) + @Amount;
        SET @TotalNights = @TotalNights + @Nights;
        
        -- Track room type usage
        IF EXISTS (SELECT 1 FROM #RoomPrefs WHERE RoomType = @RoomType)
            UPDATE #RoomPrefs SET UsageCount = UsageCount + 1 WHERE RoomType = @RoomType;
        ELSE
            INSERT INTO #RoomPrefs VALUES (@RoomType, 1);
        
        FETCH NEXT FROM client_reservations INTO @RoomID, @RoomType, @Amount, @Nights;
    END;
    
    CLOSE client_reservations;
    DEALLOCATE client_reservations;
    
    -- Calculate averages
    IF @TotalNights > 0
        SET @AvgDailySpend = @TotalAmountSpent / @TotalNights;
    ELSE
        SET @AvgDailySpend = 0;
    
    -- Determine favorite room type
    SELECT TOP 1 
        @FavoriteRoomType = RoomType
    FROM #RoomPrefs
    ORDER BY UsageCount DESC;
    
    -- If no favorite (no stays), set to NULL
    IF @FavoriteRoomType IS NULL
        SET @FavoriteRoomType = 'No completed stays';
    
    -- Clean up
    DROP TABLE #RoomPrefs;
END;
