PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS EducationLevelMaster
(
    EducationLevelId INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    IsActive INTEGER NOT NULL DEFAULT 1,
    DisplayOrder INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS EducationFieldConfiguration
(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    EducationLevelId INTEGER NOT NULL,
    FieldName TEXT NOT NULL,
    DisplayName TEXT NOT NULL,
    ControlType TEXT NOT NULL,
    IsVisible INTEGER NOT NULL DEFAULT 1,
    IsRequired INTEGER NOT NULL DEFAULT 0,
    IsEditable INTEGER NOT NULL DEFAULT 1,
    DefaultValue TEXT NULL,
    Placeholder TEXT NULL,
    RequiredMessage TEXT NULL,
    RegexPattern TEXT NULL,
    RegexMessage TEXT NULL,
    MinLength INTEGER NULL,
    MinLengthMessage TEXT NULL,
    MaxLength INTEGER NULL,
    MaxLengthMessage TEXT NULL,
    DisplayOrder INTEGER NOT NULL,
    FOREIGN KEY (EducationLevelId) REFERENCES EducationLevelMaster(EducationLevelId) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_EducationLevelMaster_Name
    ON EducationLevelMaster(Name);

CREATE UNIQUE INDEX IF NOT EXISTS UX_EducationFieldConfiguration_Level_Field
    ON EducationFieldConfiguration(EducationLevelId, FieldName);

INSERT OR REPLACE INTO EducationLevelMaster (EducationLevelId, Name, IsActive, DisplayOrder) VALUES
(1, 'High School Diploma, GED or equivalent', 1, 1),
(2, 'Some College (No Degree)', 1, 2),
(3, 'Associate Degree', 1, 3),
(4, 'Bachelor Degree', 1, 4),
(5, 'Master Degree', 1, 5),
(6, 'Doctorate', 1, 6),
(7, 'Vocational Training', 1, 7),
(8, 'Others', 1, 8);

DELETE FROM EducationFieldConfiguration;
DELETE FROM sqlite_sequence WHERE name = 'EducationFieldConfiguration';

INSERT INTO EducationFieldConfiguration (EducationLevelId, FieldName, DisplayName, ControlType, IsVisible, IsRequired, IsEditable, DefaultValue, Placeholder, RequiredMessage, RegexPattern, RegexMessage, MinLength, MinLengthMessage, MaxLength, MaxLengthMessage, DisplayOrder)
VALUES
(1, 'AreaOfStudy', 'Area of Study', 'text', 1, 0, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(1, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 1, 0, 1, 'High School Diploma, GED or equivalent', 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(1, 'SchoolName', 'School Name', 'text', 1, 0, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(1, 'Address', 'Address', 'textarea', 1, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(1, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 0, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(1, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6),
(2, 'AreaOfStudy', 'Area of Study', 'text', 0, 0, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(2, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 0, 0, 1, NULL, 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(2, 'SchoolName', 'School Name', 'text', 1, 0, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(2, 'Address', 'Address', 'textarea', 0, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(2, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 0, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(2, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6),
(3, 'AreaOfStudy', 'Area of Study', 'text', 1, 0, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(3, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 1, 1, 1, 'Associate Degree', 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(3, 'SchoolName', 'School Name', 'text', 1, 1, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(3, 'Address', 'Address', 'textarea', 1, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(3, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 1, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(3, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6),
(4, 'AreaOfStudy', 'Area of Study', 'text', 1, 1, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(4, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 1, 1, 1, 'Bachelor Degree', 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(4, 'SchoolName', 'School Name', 'text', 1, 1, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(4, 'Address', 'Address', 'textarea', 1, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(4, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 1, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(4, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6),
(5, 'AreaOfStudy', 'Area of Study', 'text', 1, 1, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(5, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 1, 1, 1, 'Master Degree', 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(5, 'SchoolName', 'School Name', 'text', 1, 1, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(5, 'Address', 'Address', 'textarea', 1, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(5, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 1, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(5, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6),
(6, 'AreaOfStudy', 'Area of Study', 'text', 1, 1, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(6, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 1, 1, 1, 'Doctorate', 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(6, 'SchoolName', 'School Name', 'text', 1, 1, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(6, 'Address', 'Address', 'textarea', 1, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(6, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 1, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(6, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6),
(7, 'AreaOfStudy', 'Area of Study', 'text', 1, 0, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(7, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 1, 1, 1, NULL, 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(7, 'SchoolName', 'School Name', 'text', 1, 1, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(7, 'Address', 'Address', 'textarea', 1, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(7, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 0, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(7, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6),
(8, 'AreaOfStudy', 'Area of Study', 'text', 1, 0, 1, NULL, 'Example: Computer Science', 'Area of Study is required.', NULL, NULL, NULL, NULL, 150, 'Area of Study cannot exceed 150 characters.', 1),
(8, 'DegreeCertificateLicense', 'Degree / Certificate / License', 'autocomplete', 0, 0, 1, NULL, 'Example: Bachelor Degree', 'Degree / Certificate / License is required.', NULL, NULL, NULL, NULL, 200, 'Degree / Certificate / License cannot exceed 200 characters.', 2),
(8, 'SchoolName', 'School Name', 'text', 1, 0, 1, NULL, 'Example: State University', 'School Name is required.', NULL, NULL, NULL, NULL, 200, 'School Name cannot exceed 200 characters.', 3),
(8, 'Address', 'Address', 'textarea', 1, 0, 1, NULL, 'School address', 'Address is required.', NULL, NULL, NULL, NULL, 500, 'Address cannot exceed 500 characters.', 4),
(8, 'CompletionIssueDate', 'Completion / Issue Date', 'date', 1, 0, 1, NULL, 'Select completion or issue date', 'Completion / Issue Date is required.', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(8, 'Description', 'Description', 'textarea', 1, 0, 1, NULL, 'Additional education details', 'Description is required.', NULL, NULL, NULL, NULL, 1000, 'Description cannot exceed 1000 characters.', 6);

COMMIT;
