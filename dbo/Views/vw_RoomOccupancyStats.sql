CREATE VIEW vw_RoomOccupancyStats AS  
SELECT  
    r.RoomType,  
    COUNT(res.ReservationID) AS TotalBookings,  
    AVG(DATEDIFF(day, res.ArrivalDate, res.DepartureDate)) AS AvgStayDuration,  
    SUM(res.TotalAmount) AS TotalRevenue,  
    COUNT(res.ReservationID) * 100.0 / (SELECT COUNT(*) FROM Reservations) AS BookingPercentage  
FROM Rooms r  
LEFT JOIN Reservations res ON r.RoomID = res.RoomID  
GROUP BY r.RoomType;  