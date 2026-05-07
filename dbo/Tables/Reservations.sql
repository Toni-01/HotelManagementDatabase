CREATE TABLE [dbo].[Reservations] (
    [ReservationID]   INT             IDENTITY (1, 1) NOT NULL,
    [ClientID]        INT             NOT NULL,
    [RoomID]          INT             NOT NULL,
    [ArrivalDate]     DATE            NOT NULL,
    [DepartureDate]   DATE            NOT NULL,
    [ReservationDate] DATE            DEFAULT (getdate()) NULL,
    [Status]          NVARCHAR (20)   NOT NULL,
    [TotalAmount]     DECIMAL (12, 2) NULL,
    PRIMARY KEY CLUSTERED ([ReservationID] ASC),
    CHECK ([Status]='completed' OR [Status]='cancelled' OR [Status]='confirmed'),
    CONSTRAINT [CHK_FutureArrival] CHECK ([ArrivalDate]>=CONVERT([date],getdate())),
    CONSTRAINT [CHK_NoOverlappingBookings] CHECK ([dbo].[fn_CheckOverlap]([RoomID],[ArrivalDate],[DepartureDate],[ReservationID])=(0)),
    CONSTRAINT [CHK_ValidDates] CHECK ([DepartureDate]>[ArrivalDate]),
    CONSTRAINT [FK_Reservation_Client] FOREIGN KEY ([ClientID]) REFERENCES [dbo].[Clients] ([ClientID]),
    CONSTRAINT [FK_Reservation_Room] FOREIGN KEY ([RoomID]) REFERENCES [dbo].[Rooms] ([RoomID])
);

