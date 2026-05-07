CREATE TABLE [dbo].[Rooms] (
    [RoomID]        INT             NOT NULL,
    [RoomType]      NVARCHAR (20)   NOT NULL,
    [Status]        NVARCHAR (20)   NOT NULL,
    [PricePerNight] DECIMAL (10, 2) NOT NULL,
    [Description]   NVARCHAR (200)  NULL,
    PRIMARY KEY CLUSTERED ([RoomID] ASC),
    CHECK ([PricePerNight]>(0)),
    CHECK ([RoomType]='suite' OR [RoomType]='double' OR [RoomType]='single'),
    CHECK ([Status]='maintenance' OR [Status]='booked' OR [Status]='free'),
    CONSTRAINT [CHK_ValidRoomID] CHECK ([RoomID]>=(100) AND [RoomID]<=(999)),
    CONSTRAINT [UQ_RoomID] UNIQUE NONCLUSTERED ([RoomID] ASC)
);

