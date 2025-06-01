CREATE OR ALTER PROCEDURE actualizar_precio_platillo_global
    @id INT,
    @precio DECIMAL(10,2)
AS
BEGIN
    SET XACT_ABORT ON;
    
    BEGIN TRANSACTION;
    BEGIN TRY
        
        
        UPDATE menu 
        SET precio_unitario = @precio
        WHERE menu_id = @id;
        
        
        UPDATE x.x.dbo.menu
        SET precio_unitario = @precio
        WHERE menu_id = @id;
        
        COMMIT TRANSACTION;
        PRINT 'Precio actualizado en todas las bases de datos';
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        PRINT 'Ocurrió un error: ' + @ErrorMessage;
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END