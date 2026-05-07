CREATE FUNCTION dbo.CalculateClientLoyaltyPoints(@ClientID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalPoints INT = 0;
    DECLARE @NightsStayed INT;
    DECLARE @AmountSpent DECIMAL(10,2);
    
    -- Cursor to process each reservation
    DECLARE reservation_cursor CURSOR FOR
        SELECT 
            DATEDIFF(DAY, ArrivalDate, DepartureDate) AS Nights,
            TotalAmount
        FROM Reservations
        WHERE ClientID = @ClientID
        AND Status = 'completed';
    
    OPEN reservation_cursor;
    FETCH NEXT FROM reservation_cursor INTO @NightsStayed, @AmountSpent;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Base points: 10 points per night
        SET @TotalPoints = @TotalPoints + (@NightsStayed * 10);
        
        -- Bonus points for high spending
        IF @AmountSpent > 500
            SET @TotalPoints = @TotalPoints + 50;
        ELSE IF @AmountSpent > 300
            SET @TotalPoints = @TotalPoints + 30;
        ELSE IF @AmountSpent > 100
            SET @TotalPoints = @TotalPoints + 10;
        
        FETCH NEXT FROM reservation_cursor INTO @NightsStayed, @AmountSpent;
    END;
    
    CLOSE reservation_cursor;
    DEALLOCATE reservation_cursor;
    
    RETURN @TotalPoints;
END;
