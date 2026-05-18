IF OBJECT_ID(N'dbo.EducationFieldConfiguration', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.EducationFieldConfiguration
    (
        Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_EducationFieldConfiguration PRIMARY KEY,
        EducationLevelId INT NOT NULL,
        FieldName NVARCHAR(100) NOT NULL,
        DisplayName NVARCHAR(150) NOT NULL,
        ControlType NVARCHAR(50) NOT NULL,
        IsVisible BIT NOT NULL CONSTRAINT DF_EducationFieldConfiguration_IsVisible DEFAULT (1),
        IsRequired BIT NOT NULL CONSTRAINT DF_EducationFieldConfiguration_IsRequired DEFAULT (0),
        IsEditable BIT NOT NULL CONSTRAINT DF_EducationFieldConfiguration_IsEditable DEFAULT (1),
        DefaultValue NVARCHAR(500) NULL,
        Placeholder NVARCHAR(250) NULL,
        RequiredMessage NVARCHAR(250) NULL,
        RegexPattern NVARCHAR(500) NULL,
        RegexMessage NVARCHAR(250) NULL,
        MinLength INT NULL,
        MinLengthMessage NVARCHAR(250) NULL,
        MaxLength INT NULL,
        MaxLengthMessage NVARCHAR(250) NULL,
        DisplayOrder INT NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.EducationLevelMaster', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.EducationLevelMaster
    (
        EducationLevelId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_EducationLevelMaster PRIMARY KEY,
        Name NVARCHAR(150) NOT NULL,
        IsActive BIT NOT NULL CONSTRAINT DF_EducationLevelMaster_IsActive DEFAULT (1),
        DisplayOrder INT NOT NULL
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_EducationFieldConfiguration_EducationLevelMaster_EducationLevelId')
BEGIN
    ALTER TABLE dbo.EducationFieldConfiguration
    ADD CONSTRAINT FK_EducationFieldConfiguration_EducationLevelMaster_EducationLevelId
        FOREIGN KEY (EducationLevelId) REFERENCES dbo.EducationLevelMaster(EducationLevelId) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UX_EducationLevelMaster_Name' AND object_id = OBJECT_ID(N'dbo.EducationLevelMaster'))
    CREATE UNIQUE INDEX UX_EducationLevelMaster_Name ON dbo.EducationLevelMaster(Name);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UX_EducationFieldConfiguration_Level_Field' AND object_id = OBJECT_ID(N'dbo.EducationFieldConfiguration'))
    CREATE UNIQUE INDEX UX_EducationFieldConfiguration_Level_Field ON dbo.EducationFieldConfiguration(EducationLevelId, FieldName);
GO
SET IDENTITY_INSERT dbo.EducationLevelMaster ON;
MERGE dbo.EducationLevelMaster AS target USING (SELECT 1 AS EducationLevelId, N'High School Diploma, GED or equivalent' AS Name, CAST(1 AS BIT) AS IsActive, 1 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
MERGE dbo.EducationLevelMaster AS target USING (SELECT 2 AS EducationLevelId, N'Some College (No Degree)' AS Name, CAST(1 AS BIT) AS IsActive, 2 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
MERGE dbo.EducationLevelMaster AS target USING (SELECT 3 AS EducationLevelId, N'Associate Degree' AS Name, CAST(1 AS BIT) AS IsActive, 3 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
MERGE dbo.EducationLevelMaster AS target USING (SELECT 4 AS EducationLevelId, N'Bachelor Degree' AS Name, CAST(1 AS BIT) AS IsActive, 4 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
MERGE dbo.EducationLevelMaster AS target USING (SELECT 5 AS EducationLevelId, N'Master Degree' AS Name, CAST(1 AS BIT) AS IsActive, 5 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
MERGE dbo.EducationLevelMaster AS target USING (SELECT 6 AS EducationLevelId, N'Doctorate' AS Name, CAST(1 AS BIT) AS IsActive, 6 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
MERGE dbo.EducationLevelMaster AS target USING (SELECT 7 AS EducationLevelId, N'Vocational Training' AS Name, CAST(1 AS BIT) AS IsActive, 7 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
MERGE dbo.EducationLevelMaster AS target USING (SELECT 8 AS EducationLevelId, N'Others' AS Name, CAST(1 AS BIT) AS IsActive, 8 AS DisplayOrder) AS source ON target.EducationLevelId = source.EducationLevelId WHEN MATCHED THEN UPDATE SET Name = source.Name, IsActive = source.IsActive, DisplayOrder = source.DisplayOrder WHEN NOT MATCHED THEN INSERT (EducationLevelId, Name, IsActive, DisplayOrder) VALUES (source.EducationLevelId, source.Name, source.IsActive, source.DisplayOrder);
SET IDENTITY_INSERT dbo.EducationLevelMaster OFF;
GO

DELETE FROM dbo.EducationFieldConfiguration;
DBCC CHECKIDENT ('dbo.EducationFieldConfiguration', RESEED, 0);
GO
INSERT INTO dbo.EducationFieldConfiguration (EducationLevelId, FieldName, DisplayName, ControlType, IsVisible, IsRequired, IsEditable, DefaultValue, Placeholder, RequiredMessage, RegexPattern, RegexMessage, MinLength, MinLengthMessage, MaxLength, MaxLengthMessage, DisplayOrder)
VALUES
(1, N'AreaOfStudy', N'Area of Study', N'text', 1, 0, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(1, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 1, 0, 1, N'High School Diploma, GED or equivalent', N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(1, N'SchoolName', N'School Name', N'text', 1, 0, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(1, N'Address', N'Address', N'textarea', 1, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(1, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 0, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(1, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6),
(2, N'AreaOfStudy', N'Area of Study', N'text', 0, 0, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(2, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 0, 0, 1, NULL, N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(2, N'SchoolName', N'School Name', N'text', 1, 0, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(2, N'Address', N'Address', N'textarea', 0, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(2, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 0, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(2, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6),
(3, N'AreaOfStudy', N'Area of Study', N'text', 1, 0, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(3, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 1, 1, 1, N'Associate Degree', N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(3, N'SchoolName', N'School Name', N'text', 1, 1, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(3, N'Address', N'Address', N'textarea', 1, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(3, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 1, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(3, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6),
(4, N'AreaOfStudy', N'Area of Study', N'text', 1, 1, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(4, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 1, 1, 1, N'Bachelor Degree', N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(4, N'SchoolName', N'School Name', N'text', 1, 1, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(4, N'Address', N'Address', N'textarea', 1, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(4, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 1, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(4, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6),
(5, N'AreaOfStudy', N'Area of Study', N'text', 1, 1, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(5, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 1, 1, 1, N'Master Degree', N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(5, N'SchoolName', N'School Name', N'text', 1, 1, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(5, N'Address', N'Address', N'textarea', 1, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(5, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 1, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(5, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6),
(6, N'AreaOfStudy', N'Area of Study', N'text', 1, 1, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(6, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 1, 1, 1, N'Doctorate', N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(6, N'SchoolName', N'School Name', N'text', 1, 1, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(6, N'Address', N'Address', N'textarea', 1, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(6, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 1, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(6, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6),
(7, N'AreaOfStudy', N'Area of Study', N'text', 1, 0, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(7, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 1, 1, 1, NULL, N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(7, N'SchoolName', N'School Name', N'text', 1, 1, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(7, N'Address', N'Address', N'textarea', 1, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(7, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 0, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(7, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6),
(8, N'AreaOfStudy', N'Area of Study', N'text', 1, 0, 1, NULL, N'Example: Computer Science', N'Area of Study is required.', NULL, NULL, NULL, NULL, 150, N'Area of Study cannot exceed 150 characters.', 1),
(8, N'DegreeCertificateLicense', N'Degree / Certificate / License', N'autocomplete', 0, 0, 1, NULL, N'Example: Bachelor Degree', N'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, N'Degree / Certificate / License cannot exceed 200 characters.', 2),
(8, N'SchoolName', N'School Name', N'text', 1, 0, 1, NULL, N'Example: State University', N'School Name is required.', NULL, NULL, NULL, NULL, 200, N'School Name cannot exceed 200 characters.', 3),
(8, N'Address', N'Address', N'textarea', 1, 0, 1, NULL, N'School address', N'Address is required.', NULL, NULL, NULL, NULL, 500, N'Address cannot exceed 500 characters.', 4),
(8, N'CompletionIssueDate', N'Completion / Issue Date', N'date', 1, 0, 1, NULL, N'Select completion or issue date', N'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(8, N'Description', N'Description', N'textarea', 1, 0, 1, NULL, N'Additional education details', N'Description is required.', NULL, NULL, NULL, NULL, 1000, N'Description cannot exceed 1000 characters.', 6);
GO
