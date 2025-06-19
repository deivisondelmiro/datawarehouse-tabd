-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2025-06-06 11:37:09 BRT
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



CREATE TABLESPACE dw_acd
    DATAFILE 'dw_acd.dbf' SIZE 500M REUSE
    AUTOEXTEND ON NEXT 200M MAXSIZE UNLIMITED
NOLOGGING ONLINE DEFAULT COMPRESS NO INMEMORY EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO FLASHBACK OFF ;

CREATE TABLESPACE dw_dim
    DATAFILE 'dw_dim.dbf' SIZE 500M REUSE
    AUTOEXTEND ON NEXT 200M MAXSIZE UNLIMITED
NOLOGGING ONLINE DEFAULT COMPRESS EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO FLASHBACK OFF ;

CREATE TABLESPACE dw_idx
    DATAFILE 'dw_idx.dbf' SIZE 300M REUSE
    AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED
NOLOGGING ONLINE DEFAULT COMPRESS EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO FLASHBACK OFF ;

CREATE USER sch_acd IDENTIFIED BY sch_acd
    DEFAULT TABLESPACE dw_acd
    ACCOUNT UNLOCK;

GRANT
    ALTER ANY INDEX,
    ALTER ANY ROLE,
    ALTER ANY SEQUENCE,
    ALTER ANY TABLE,
    ALTER ANY TRIGGER,
    ALTER DATABASE,
    ALTER PROFILE,
    ALTER SESSION,
    ALTER SYSTEM,
    ALTER TABLESPACE,
    ALTER USER,
    CREATE ANY TABLE,
    CREATE ANY TRIGGER,
    CREATE ANY TYPE,
    CREATE ANY VIEW,
    CREATE PROCEDURE,
    CREATE PROFILE,
    CREATE ROLE,
    CREATE SEQUENCE,
    CREATE SESSION,
    CREATE TABLE,
    CREATE TABLESPACE,
    CREATE TRIGGER,
    CREATE TYPE,
    CREATE USER,
    CREATE VIEW, dba,
    DROP ANY INDEX,
    DROP ANY PROCEDURE,
    DROP ANY SEQUENCE,
    DROP ANY TABLE,
    DROP ANY TRIGGER,
    DROP ANY TYPE,
    DROP PROFILE,
    DROP TABLESPACE,
    DROP USER,
    EXECUTE ANY PROCEDURE,
    INHERIT ANY PRIVILEGES,
    INSERT ANY TABLE,
    SELECT ANY TABLE, sysdba,
    UPDATE ANY TABLE
TO sch_acd WITH ADMIN OPTION;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE sch_acd.dim_causa (
    id_causa_acidente NUMBER(10)
        CONSTRAINT nnc_dm_cas_id_cas NOT NULL,
    causa_acidente    VARCHAR2(250 BYTE)
        CONSTRAINT nnc_dm_cas_cau_acd NOT NULL
)
TABLESPACE dw_dim LOGGING;

GRANT SELECT, DELETE, INSERT, UPDATE ON sch_acd.dim_causa TO sch_acd;

ALTER TABLE sch_acd.dim_causa ADD CONSTRAINT pk_dim_causa PRIMARY KEY ( id_causa_acidente );

CREATE TABLE sch_acd.dim_clima (
    id_clima           NUMBER(10)
        CONSTRAINT nnc_dm_clm_id_clm NOT NULL,
    condicao_climatica VARCHAR2(100 BYTE)
        CONSTRAINT nnc_dm_clm_con_clima NOT NULL
)
TABLESPACE dw_dim LOGGING;

GRANT DELETE, INSERT, SELECT, UPDATE ON sch_acd.dim_clima TO sch_acd;

ALTER TABLE sch_acd.dim_clima ADD CONSTRAINT pk_dim_clima PRIMARY KEY ( id_clima );

CREATE TABLE sch_acd.dim_data (
    id_data   NUMBER(10)
        CONSTRAINT nnc_d_data_id_data NOT NULL,
    data      DATE
        CONSTRAINT nnc_d_data_dat NOT NULL,
    ano       NUMBER(4)
        CONSTRAINT nnc_d_data_ano NOT NULL,
    semestre  NUMBER(1)
        CONSTRAINT nnc_d_data_semestre NOT NULL,
    trimestre NUMBER(1)
        CONSTRAINT nnc_d_data_trimestre NOT NULL,
    mes       NUMBER(2)
        CONSTRAINT nnc_d_data_mes NOT NULL,
    dia       NUMBER(2)
        CONSTRAINT nnc_d_data_dia NOT NULL,
    nom_mes   VARCHAR2(10 BYTE)
        CONSTRAINT nnc_d_data_nom_mes NOT NULL
)
TABLESPACE dw_dim LOGGING;

GRANT DELETE, INSERT, SELECT, UPDATE ON sch_acd.dim_data TO sch_acd;

ALTER TABLE sch_acd.dim_data ADD CONSTRAINT pk_dim_data PRIMARY KEY ( id_data );

CREATE TABLE sch_acd.dim_local (
    id_local    NUMBER(10)
        CONSTRAINT nnc_dm_loc_id_loc NOT NULL,
    regiao      VARCHAR2(50 BYTE)
        CONSTRAINT nnc_dm_loc_regiao NOT NULL,
    estado      VARCHAR2(50 BYTE)
        CONSTRAINT nnc_dm_loc_estado NOT NULL,
    municipio   VARCHAR2(100 BYTE)
        CONSTRAINT nnc_dm_loc_municipio NOT NULL,
    num_rodovia NUMBER(10)
        CONSTRAINT nnc_dm_loc_num_rodovia NOT NULL,
    num_km      NUMBER(10, 2) NOT NULL,
    longitude   NUMBER(15, 10) NOT NULL,
    latitude    NUMBER(15, 10) NOT NULL
)
TABLESPACE dw_dim LOGGING;

GRANT DELETE, INSERT, SELECT, UPDATE ON sch_acd.dim_local TO sch_acd;

ALTER TABLE sch_acd.dim_local ADD CONSTRAINT pk_dim_local PRIMARY KEY ( id_local );

CREATE TABLE sch_acd.dim_periodo (
    id_periodo  NUMBER(10)
        CONSTRAINT nnc_d_prd_id_per NOT NULL,
    periodo_dia VARCHAR2(100 BYTE)
        CONSTRAINT nnc_d_prd_per_dia NOT NULL
)
TABLESPACE dw_dim LOGGING;

GRANT DELETE, INSERT, SELECT, UPDATE ON sch_acd.dim_periodo TO sch_acd;

ALTER TABLE sch_acd.dim_periodo ADD CONSTRAINT pk_dim_periodo PRIMARY KEY ( id_periodo );

CREATE TABLE sch_acd.dim_tipo (
    id_tipo_acidente NUMBER(10)
        CONSTRAINT nnc_dm_tip_id_tip NOT NULL,
    tipo_acidente    VARCHAR2(250 BYTE)
        CONSTRAINT nnc_dm_tip_tip_acd NOT NULL
)
TABLESPACE dw_dim LOGGING;

GRANT DELETE, INSERT, SELECT, UPDATE ON sch_acd.dim_tipo TO sch_acd;

ALTER TABLE sch_acd.dim_tipo ADD CONSTRAINT pk_dim_tipo PRIMARY KEY ( id_tipo_acidente );

CREATE TABLE sch_acd.fato_acidente (
    dim_local          NUMBER(10)
        CONSTRAINT nnc_ft_acd_dim_local NOT NULL,
    dim_tipo           NUMBER(10)
        CONSTRAINT nnc_ft_acd_dim_tipo NOT NULL,
    dim_causa          NUMBER(10)
        CONSTRAINT nnc_ft_acd_dim_causa NOT NULL,
    dim_data           NUMBER(10)
        CONSTRAINT nnc_ft_acd_dim_data NOT NULL,
    dim_periodo        NUMBER(10)
        CONSTRAINT nnc_ft_acd_dim_periodo NOT NULL,
    dim_clima          NUMBER(10)
        CONSTRAINT nnc_ft_acd_dim_clima NOT NULL,
    qtd_acidentes      NUMBER(10)
        CONSTRAINT nnc_ft_acd_qtd_acd NOT NULL,
    tot_feridos        NUMBER(10)
        CONSTRAINT nnc_ft_acd_tot_fer NOT NULL,
    qtd_feridos_leves  NUMBER(10)
        CONSTRAINT nnc_ft_acd_qtd_fer_lev NOT NULL,
    qtd_feridos_graves NUMBER(10)
        CONSTRAINT nnc_ft_acd_qtd_fer_gra NOT NULL,
    qtd_mortos         NUMBER(10)
        CONSTRAINT nnc_ft_acd_qtd_mortos NOT NULL
)
TABLESPACE dw_acd LOGGING;

CREATE INDEX sch_acd.idx_ft_acd_dim_data_1 ON
    sch_acd.fato_acidente (
        dim_data
    ASC )
        TABLESPACE dw_idx LOGGING;

CREATE INDEX sch_acd.idx_ft_acd_dim_tipo_2 ON
    sch_acd.fato_acidente (
        dim_tipo
    ASC )
        TABLESPACE dw_idx LOGGING;

CREATE INDEX sch_acd.idx_ft_acd_dim_local_3 ON
    sch_acd.fato_acidente (
        dim_local
    ASC )
        TABLESPACE dw_idx LOGGING;

CREATE INDEX sch_acd.idx_ft_acd_dim_causa_4 ON
    sch_acd.fato_acidente (
        dim_causa
    ASC )
        TABLESPACE dw_idx LOGGING;

CREATE INDEX sch_acd.idx_ft_acd_dim_periodo_5 ON
    sch_acd.fato_acidente (
        dim_periodo
    ASC )
        TABLESPACE dw_idx LOGGING;

CREATE INDEX sch_acd.idx_ft_acd_dim_clima_6 ON
    sch_acd.fato_acidente (
        dim_clima
    ASC )
        TABLESPACE dw_idx LOGGING;

GRANT DELETE, INSERT, SELECT, UPDATE ON sch_acd.fato_acidente TO sch_acd;

ALTER TABLE sch_acd.fato_acidente
    ADD CONSTRAINT pk_fato_acidente PRIMARY KEY ( dim_data,
                                                  dim_local,
                                                  dim_causa,
                                                  dim_tipo,
                                                  dim_periodo,
                                                  dim_clima );

ALTER TABLE sch_acd.fato_acidente
    ADD CONSTRAINT fk_d_data_ft_acd FOREIGN KEY ( dim_data )
        REFERENCES sch_acd.dim_data ( id_data )
    NOT DEFERRABLE;

ALTER TABLE sch_acd.fato_acidente
    ADD CONSTRAINT fk_d_prd_ft_acd FOREIGN KEY ( dim_periodo )
        REFERENCES sch_acd.dim_periodo ( id_periodo )
    NOT DEFERRABLE;

ALTER TABLE sch_acd.fato_acidente
    ADD CONSTRAINT fk_dm_cas_ft_acd FOREIGN KEY ( dim_causa )
        REFERENCES sch_acd.dim_causa ( id_causa_acidente )
    NOT DEFERRABLE;

ALTER TABLE sch_acd.fato_acidente
    ADD CONSTRAINT fk_dm_clm_ft_acd FOREIGN KEY ( dim_clima )
        REFERENCES sch_acd.dim_clima ( id_clima )
    NOT DEFERRABLE;

ALTER TABLE sch_acd.fato_acidente
    ADD CONSTRAINT fk_dm_loc_ft_acd FOREIGN KEY ( dim_local )
        REFERENCES sch_acd.dim_local ( id_local )
    NOT DEFERRABLE;

ALTER TABLE sch_acd.fato_acidente
    ADD CONSTRAINT fk_dm_tip_ft_acd FOREIGN KEY ( dim_tipo )
        REFERENCES sch_acd.dim_tipo ( id_tipo_acidente )
    NOT DEFERRABLE;

CREATE SEQUENCE sch_acd.dm_cas_id_causa_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sch_acd.dm_cas_id_causa_trg BEFORE
    INSERT ON sch_acd.dim_causa
    FOR EACH ROW
    WHEN ( new.id_causa_acidente IS NULL )
BEGIN
    :new.id_causa_acidente := sch_acd.dm_cas_id_causa_seq.nextval;
END;
/

CREATE SEQUENCE sch_acd.dm_clm_id_clm_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sch_acd.dm_clm_id_clm_trg BEFORE
    INSERT ON sch_acd.dim_clima
    FOR EACH ROW
    WHEN ( new.id_clima IS NULL )
BEGIN
    :new.id_clima := sch_acd.dm_clm_id_clm_seq.nextval;
END;
/

CREATE SEQUENCE sch_acd.d_data_id_data_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sch_acd.d_data_id_data_trg BEFORE
    INSERT ON sch_acd.dim_data
    FOR EACH ROW
    WHEN ( new.id_data IS NULL )
BEGIN
    :new.id_data := sch_acd.d_data_id_data_seq.nextval;
END;
/

CREATE SEQUENCE sch_acd.dm_loc_id_loc_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sch_acd.dm_loc_id_loc_trg BEFORE
    INSERT ON sch_acd.dim_local
    FOR EACH ROW
    WHEN ( new.id_local IS NULL )
BEGIN
    :new.id_local := sch_acd.dm_loc_id_loc_seq.nextval;
END;
/

CREATE SEQUENCE sch_acd.d_prd_id_per_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sch_acd.d_prd_id_per_trg BEFORE
    INSERT ON sch_acd.dim_periodo
    FOR EACH ROW
    WHEN ( new.id_periodo IS NULL )
BEGIN
    :new.id_periodo := sch_acd.d_prd_id_per_seq.nextval;
END;
/

CREATE SEQUENCE sch_acd.dm_tip_id_tip_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sch_acd.dm_tip_id_tip_trg BEFORE
    INSERT ON sch_acd.dim_tipo
    FOR EACH ROW
    WHEN ( new.id_tipo_acidente IS NULL )
BEGIN
    :new.id_tipo_acidente := sch_acd.dm_tip_id_tip_seq.nextval;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             6
-- ALTER TABLE                             13
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           6
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          6
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        3
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
