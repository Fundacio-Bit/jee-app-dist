/* 4.2.0 a 4.3.0 */
--UPDATE CORE_PARAMETRO_CONFIGURACION SET VALOR='4.3.0' WHERE NOMBRE='version.datamodel.scsp'; 

ALTER TABLE CORE_TRANSMISION MODIFY DOCTITULAR  VARCHAR2(30);
ALTER TABLE CORE_TRANSMISION MODIFY EXPEDIENTE  VARCHAR2(65);
 
ALTER TABLE CORE_TRANSMISION ADD ESTADOSECUNDARIO VARCHAR2(16); 

ALTER TABLE CORE_TRANSMISION ADD CODIGOUNIDADTRAMITADORA VARCHAR2(9); 
ALTER TABLE CORE_TRANSMISION ADD SEUDONIMOFUNCIONARIO VARCHAR2(32); 
ALTER TABLE CORE_PETICION_RESPUESTA ADD ERRORSECUNDARIO VARCHAR2(1024); 
ALTER TABLE CORE_PETICION_RESPUESTA ADD ESTADOSECUNDARIO VARCHAR2(16); 

ALTER TABLE CORE_SERVICIO ADD XPATHCODIGOERRORSECUNDARIO VARCHAR2(256) ;

COMMIT;


/* 4.3.0 a 4.4.0 */

ALTER TABLE CORE_TRANSMISION ADD ERROR2 VARCHAR2 (4000);

COMMIT;

DECLARE
   CURSOR c1 is
      SELECT ERROR,IDPETICION,IDTRANSMISION  FROM CORE_TRANSMISION  ; 
		var_var  VARCHAR2(4000);
		long_var LONG;
		sql_stmt0 VARCHAR2(4000);
		sql_stmt VARCHAR2(4000);
		sql_stmt2 VARCHAR2(4000);
		sql_stmt3 VARCHAR2(4000);
		BEGIN   
		 sql_stmt2 := 'ALTER TABLE CORE_TRANSMISION DROP COLUMN error';
		 sql_stmt3 := 'ALTER TABLE CORE_TRANSMISION RENAME COLUMN error2 TO error';
		 
		   FOR TRANSMISION_REC in c1
		   LOOP
		      UPDATE CORE_TRANSMISION SET ERROR2= SUBSTR(TRANSMISION_REC.ERROR,1,4000) WHERE IDPETICION=TRANSMISION_REC.IDPETICION AND IDTRANSMISION=TRANSMISION_REC.IDTRANSMISION;
		 
		   END LOOP;  
		   
		  EXECUTE IMMEDIATE sql_stmt2 ; 
		  EXECUTE IMMEDIATE sql_stmt3 ;  
		 
		END;

/* 4.4.0 a 4.5.0 */
ALTER TABLE CORE_ORGANISMO_CESIONARIO ADD CODIGOUNIDADTRAMITADORA VARCHAR(9);

/* 4.6.0 a 4.7.0 */

/* 4.7.0 a 4.8.0 */
ALTER TABLE CORE_EMISOR_CERTIFICADO ADD FECHAALTA TIMESTAMP (6);

/* 4.8.0 a 4.16.0 */
ALTER TABLE CORE_TRANSMISION MODIFY ESTADO VARCHAR2(10);

/* 4.16.0 a 4.19.0 */
CREATE INDEX CORE_SERVICIO_INDEX_EMISOR  ON CORE_SERVICIO (EMISOR);

/* NO SCSP */
ALTER TABLE EMS_SERVEI ADD XSD_ACTIVA NUMBER(1);
ALTER TABLE EMS_SERVEI ADD XSD_ESQUEMA_BAK VARCHAR2(256);