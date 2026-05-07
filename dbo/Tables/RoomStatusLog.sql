CREATE TABLE [dbo].[RoomStatusLog] (
    [LogID]      INT            IDENTITY (1, 1) NOT NULL,
    [RoomID]     INT            NOT NULL,
    [OldStatus]  NVARCHAR (20)  NULL,
    [NewStatus]  NVARCHAR (255) NULL,
    [ChangeDate] DATETIME       DEFAULT (getdate()) NULL,
    [ChangedBy]  NVARCHAR (100) DEFAULT (suser_sname()) NULL,
    PRIMARY KEY CLUSTERED ([LogID] ASC)
);

