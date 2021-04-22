-- Bash
sudo -i -u postgres

psql
--

DROP SCHEMA IF EXISTS assistenzaGuasti CASCADE;

CREATE SCHEMA assistenzaGuasti;

SET search_path TO assistenzaGuasti;

CREATE TABLE cliente(
    codiceFiscalePartitaIva     varchar(16)         NOT NULL,
    indirizzo                   varchar(20)         NOT NULL,
    recapitoTelefonico          varchar(10)         NOT NULL,
    tipo                        character(1)                ,
    codiceFiscaleReferente      varchar(16)                 ,
    nome                        varchar(20)                 ,
    cognome                     varchar(20)                 ,

    CONSTRAINT cliente_pkey            
        PRIMARY KEY             (codiceFiscalePartitaIva)
);




CREATE TABLE capaceDiRisolvere(
    codiceGuasto                integer             NOT NULL,
    cfTecnico                   varchar(16)         NOT NULL,

    CONSTRAINT capaceDiRisolvere_pkey  
        PRIMARY KEY             (codiceGuasto, cfTecnico),
    CONSTRAINT cfTecnico               
        FOREIGN KEY             (cfTecnico)
        REFERENCES              tecnico(codiceFiscale)
        ON UPDATE               CASCADE
        ON DELETE               CASCADE,
    CONSTRAINT codiceGuasto            
        FOREIGN KEY             (codiceGuasto)
        REFERENCES              tipologiaGuasto(codiceGuasto)
        ON UPDATE               CASCADE
        ON DELETE               CASCADE
);


CREATE TABLE intervento(
    numeroIntervento            integer             NOT NULL,
    data                        timestamp           NOT NULL,
    durata                      integer             NOT NULL,
    modalita                    character(1)        NOT NULL,
    codiceRichiesta             integer             NOT NULL,
    cfTecnico                   varchar(16)         NOT NULL,

    CONSTRAINT interventi_pkey         
        PRIMARY KEY             (codiceRichiesta, numeroIntervento),
    CONSTRAINT cfTecnico               
        FOREIGN KEY             (cfTecnico)
        REFERENCES              tecnico(codiceFiscale)
        ON UPDATE               CASCADE
        ON DELETE               CASCADE
);

CREATE TABLE tecnico(
    codiceFiscale               character(16)       NOT NULL,
    nome                        varchar(20)         NOT NULL,
    cognome                     varchar(20)         NOT NULL,
    indirizzo                   varchar(50)         NOT NULL,
    recapitoTelefonico          varchar(14)         NOT NULL,
    dataAssunzione              timestamp           NOT NULL,
    oreLavorateMensilmente      integer DEFAULT 0   NOT NULL,

    CONSTRAINT tecnico_pkey 
        PRIMARY KEY             (codiceFiscale),
);

CREATE TABLE tipologiaGuasto(
    codiceGuasto                integer             NOT NULL,
    descrizione                 text                NOT NULL,
    
    CONSTRAINT tipologiaGuasto_pkey 
        PRIMARY KEY             (codiceGuasto),
);
-- Auto Increment
ALTER TABLE tipologieGuasto 
    ALTER COLUMN codiceGuasto ADD GENERATED ALWAYS AS IDENTITY (
        SEQUENCE    NAME    tipologiaGuasto_codiceGuasto_seq
        START       WITH    1
        INCREMENT   BY      1
        NO                  MINVALUE
        NO                  MAXVALUE
        CACHE               1
);

CREATE TABLE richiestaDAssistenza(
    codiceRichiesta             integer             NOT NULL,
    data                        timestamp           NOT NULL,
    seriale                     varchar(10)         NOT NULL,
    dataFineAssistenza          date                        ,
    codiceCliente               varchar(16)         NOT NULL,

    CONSTRAINT richiestaDAssistenza_pkey 
        PRIMARY KEY             (codiceRichiesta),
    CONSTRAINT codiceCliente 
        FOREIGN KEY             (codiceCliente) 
        REFERENCES              cliente(codiceFiscalePartitaIva) 
        ON UPDATE               CASCADE, 
);
-- Auto Increment
ALTER TABLE richiestaDAssistenza 
    ALTER COLUMN codiceRichiesta ADD GENERATED ALWAYS AS IDENTITY (
        SEQUENCE    NAME    richiestaDAssistenza_codiceRichiesta_seq
        START       WITH    1
        INCREMENT   BY      1
        NO                  MINVALUE
        NO                  MAXVALUE
        CACHE               1
);

