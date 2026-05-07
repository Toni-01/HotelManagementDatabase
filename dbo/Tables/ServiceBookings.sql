CREATE TABLE [dbo].[ServiceBookings] (
    [BookingID]     INT  IDENTITY (1, 1) NOT NULL,
    [ReservationID] INT  NOT NULL,
    [ServiceID]     INT  NOT NULL,
    [EmployeeID]    INT  NULL,
    [BookingDate]   DATE DEFAULT (getdate()) NOT NULL,
    [Quantity]      INT  DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([BookingID] ASC),
    CONSTRAINT [CHK_PositiveQuantity] CHECK ([Quantity]>(0)),
    CONSTRAINT [FK_ServiceBooking_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_ServiceBooking_Reservation] FOREIGN KEY ([ReservationID]) REFERENCES [dbo].[Reservations] ([ReservationID]),
    CONSTRAINT [FK_ServiceBooking_Service] FOREIGN KEY ([ServiceID]) REFERENCES [dbo].[Services] ([ServiceID]),
    CONSTRAINT [UQ_ReservationService] UNIQUE NONCLUSTERED ([ReservationID] ASC, [ServiceID] ASC, [BookingDate] ASC)
);

