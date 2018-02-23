CREATE PROCEDURE dbo.PR_UpdateClientDetails
  @ClientID INT,
  @Country VARCHAR(20),
  @City VARCHAR(20),
  @Address VARCHAR(30),
  @PostalCode CHAR(5),
  @Phone VARCHAR(15),
  @IsCompany BIT
AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRY

      IF NOT EXISTS(
        SELECT *
        FROM Clients
        WHERE ClientID=@ClientID
      )
        BEGIN
        ;THROW 60000, 'Given ClientID does not exist', 1
      END
      IF @Country IS NOT NULL
        BEGIN
          UPDATE Clients
            SET Country = @Country WHERE ClientID=@ClientID
        END
      IF @City IS NOT NULL
        BEGIN
          UPDATE Clients
            SET City = @City WHERE ClientID=@ClientID
        END
      IF @Address IS NOT NULL
        BEGIN
          UPDATE Clients
            SET Address = @Address WHERE ClientID=@ClientID
        END
      IF @PostalCode IS NOT NULL
        BEGIN
          UPDATE Clients
            SET PostalCode = @PostalCode WHERE ClientID=@ClientID
        END
      IF @Phone IS NOT NULL
        BEGIN
          UPDATE Clients
            SET Phone = @Phone WHERE ClientID=@ClientID
        END
      IF @IsCompany IS NOT NULL
        BEGIN
          UPDATE Clients
            SET IsCompany = @IsCompany WHERE ClientID=@ClientID
        END
    END TRY
    BEGIN CATCH
      DECLARE @errorMsg nvarchar (2048) = 'An error occurred while changing client details : ' + ERROR_MESSAGE ();
      THROW 60000, @errorMsg, 1
    END CATCH
END
GO
