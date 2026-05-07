CREATE TABLE [dbo].[Payments] (
    [PaymentID]     INT             IDENTITY (1, 1) NOT NULL,
    [ReservationID] INT             NOT NULL,
    [Amount]        DECIMAL (12, 2) NOT NULL,
    [PaymentDate]   DATETIME        DEFAULT (getdate()) NULL,
    [PaymentMethod] NVARCHAR (50)   NOT NULL,
    [Status]        NVARCHAR (20)   NOT NULL,
    PRIMARY KEY CLUSTERED ([PaymentID] ASC),
    CHECK ([PaymentMethod]='bank transfer' OR [PaymentMethod]='credit card' OR [PaymentMethod]='cash'),
    CHECK ([Status]='refunded' OR [Status]='completed' OR [Status]='pending'),
    CONSTRAINT [CHK_PositiveAmount] CHECK ([Amount]>(0)),
    CONSTRAINT [FK_Payment_Reservation] FOREIGN KEY ([ReservationID]) REFERENCES [dbo].[Reservations] ([ReservationID])
);

