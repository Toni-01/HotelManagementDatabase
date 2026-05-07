CREATE TABLE [dbo].[Employees] (
    [EmployeeID]   INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]    NVARCHAR (50)  NOT NULL,
    [LastName]     NVARCHAR (50)  NOT NULL,
    [Role]         NVARCHAR (50)  NOT NULL,
    [Department]   NVARCHAR (50)  NOT NULL,
    [WorkSchedule] NVARCHAR (100) NULL,
    [HireDate]     DATE           DEFAULT (getdate()) NULL,
    [Phone]        NVARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CHECK ([Department]='spa' OR [Department]='cleaning' OR [Department]='kitchen' OR [Department]='maintenance' OR [Department]='reception'),
    CONSTRAINT [CHK_ValidHireDate] CHECK ([HireDate]<=getdate()),
    CONSTRAINT [UQ_EmployeePhone] UNIQUE NONCLUSTERED ([Phone] ASC)
);

