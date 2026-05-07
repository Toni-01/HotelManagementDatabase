CREATE TABLE [dbo].[Clients] (
    [ClientID]         INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]        NVARCHAR (50)  NOT NULL,
    [LastName]         NVARCHAR (50)  NOT NULL,
    [Email]            NVARCHAR (100) NOT NULL,
    [Phone]            NVARCHAR (20)  NOT NULL,
    [Address]          NVARCHAR (200) NULL,
    [RegistrationDate] DATE           DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ClientID] ASC),
    CONSTRAINT [CHK_Email] CHECK ([Email] like '%@%.%'),
    CONSTRAINT [CHK_Phone] CHECK ([Phone] like '+[0-9]%'),
    UNIQUE NONCLUSTERED ([Email] ASC)
);

