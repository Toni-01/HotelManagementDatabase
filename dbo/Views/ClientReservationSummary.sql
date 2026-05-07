CREATE VIEW ClientReservationSummary AS
SELECT 
    c.ClientID,
    c.FirstName + ' ' + c.LastName AS ClientName,
    COUNT(r.ReservationID) AS TotalReservations,
    SUM(DATEDIFF(day, r.ArrivalDate, r.DepartureDate)) AS TotalNightsBooked,
    SUM(r.TotalAmount) AS TotalAmountSpent,
    MAX(r.ArrivalDate) AS LastArrivalDate,
    STUFF((
        SELECT ', ' + s.ServiceName
        FROM ServiceBookings sb
        JOIN Services s ON sb.ServiceID = s.ServiceID
        WHERE sb.ReservationID = r.ReservationID
        FOR XML PATH('')), 1, 2, '') AS ServicesUsed
FROM 
    Clients c
INNER JOIN 
    Reservations r ON c.ClientID = r.ClientID
WHERE 
    r.Status <> 'cancelled'
GROUP BY 
    c.ClientID, c.FirstName, c.LastName, r.ReservationID;