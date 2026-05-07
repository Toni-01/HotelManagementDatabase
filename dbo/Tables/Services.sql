CREATE TABLE [dbo].[Services] (
    [ServiceID]   INT             IDENTITY (1, 1) NOT NULL,
    [ServiceName] NVARCHAR (50)   NOT NULL,
    [Description] NVARCHAR (200)  NULL,
    [Price]       DECIMAL (10, 2) DEFAULT ((0)) NOT NULL,
    [Department]  NVARCHAR (50)   NOT NULL,
    PRIMARY KEY CLUSTERED ([ServiceID] ASC),
    CONSTRAINT [CHK_ServicePrice] CHECK ([Price]>=(0)),
    CONSTRAINT [UQ_ServiceName] UNIQUE NONCLUSTERED ([ServiceName] ASC)
);

