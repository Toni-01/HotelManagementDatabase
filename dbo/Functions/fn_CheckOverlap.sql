
-- Create the function in its own batch
CREATE FUNCTION dbo.fn_CheckOverlap(
    @RoomID INT,
    @ArrivalDate DATE,
    @DepartureDate DATE,
    @ReservationID INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT = 0;
    
    IF EXISTS (
        SELECT 1 
        FROM Reservations r
        WHERE r.RoomID = @RoomID
        AND r.ReservationID <> ISNULL(@ReservationID, -1)
        AND r.Status = 'confirmed'
        AND @ArrivalDate < r.DepartureDate
        AND @DepartureDate > r.ArrivalDate
    ) 
    BEGIN
        SET @Result = 1;
    END
    
    RETURN @Result;
END;
