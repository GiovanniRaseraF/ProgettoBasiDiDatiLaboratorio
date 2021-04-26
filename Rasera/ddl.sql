
DROP SCHEMA IF EXISTS assistenzaGuasti CASCADE;

CREATE SCHEMA assistenzaGuasti;

SET search_path TO assistenzaGuasti;

CREATE TABLE Cliente(
    tipo                        character(1)                ,
    codiceFiscalePartitaIva     varchar(16)         NOT NULL,
    nome                        varchar(20)                 ,
    cognome                     varchar(20)                 ,
    ragioneSociale              varchar(50)                 ,
    codiceFiscaleReferente      varchar(16)                 ,
    indirizzo                   varchar(20)         NOT NULL,
    recapitoTelefonico          varchar(10)         NOT NULL,

    CONSTRAINT cliente_pkey            
        PRIMARY KEY             (codiceFiscalePartitaIva)
);

CREATE TABLE Tecnico(
    codiceFiscale               character(16)       NOT NULL,
    nome                        varchar(20)         NOT NULL,
    cognome                     varchar(20)         NOT NULL,
    indirizzo                   varchar(50)         NOT NULL,
    recapitoTelefonico          varchar(14)         NOT NULL,
    dataAssunzione              timestamp           NOT NULL,
    oreLavorateMensilmente      integer DEFAULT 0   NOT NULL,
    CONSTRAINT tecnico_pkey 
        PRIMARY KEY             (codiceFiscale) 
);

CREATE TABLE TipologiaGuasto(
    codiceGuasto                integer             NOT NULL,
    descrizione                 text                NOT NULL,
    
    CONSTRAINT tipologiaGuasto_pkey 
        PRIMARY KEY             (codiceGuasto)
);
-- Auto Increment
ALTER TABLE TipologiaGuasto 
    ALTER COLUMN codiceGuasto ADD GENERATED ALWAYS AS IDENTITY (
        SEQUENCE    NAME    tipologiaGuasto_codiceGuasto_seq
        START       WITH    1
        INCREMENT   BY      1
        NO                  MINVALUE
        NO                  MAXVALUE
        CACHE               1
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

CREATE TABLE Intervento(
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
-- Auto Increment
ALTER TABLE Intervento 
    ALTER COLUMN numeroIntervento ADD GENERATED ALWAYS AS IDENTITY (
        SEQUENCE    NAME    intervento_numeroIntervento_seq
        START       WITH    1
        INCREMENT   BY      1
        NO                  MINVALUE
        NO                  MAXVALUE
        CACHE               1
);

CREATE TABLE RichiestadAssistenza(
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
        ON UPDATE               CASCADE
);
-- Auto Increment
ALTER TABLE RichiestadAssistenza 
    ALTER COLUMN codiceRichiesta ADD GENERATED ALWAYS AS IDENTITY (
        SEQUENCE    NAME    richiestaDAssistenza_codiceRichiesta_seq
        START       WITH    1
        INCREMENT   BY      1
        NO                  MINVALUE
        NO                  MAXVALUE
        CACHE               1
);



-- Valori
insert into Tecnico(nome, cognome, codiceFiscale, indirizzo, 
    recapitoTelefonico, dataAssunzione)
values
    ('Fidarma','Solombrino','SOIFIM33U20Q912N','Maniago', '84590315584', '04-07-2020'),
    ('Portos','Greco','GROPOT28U08E502Y','Cervignano del friuli',  '845590315584', '04-07-2020'),
    ('Quinzia','Tunwal','TUWQUZ78N29U115A','Travesio',  '845903155584', '04-07-2020'),
    ('Rinda','Arcidiacona','ARRRID59I33E601X','Arzene', '865903155584', '04-07-2020'),
    ('Miroslao','Caporale','CALMIA96R30J564F','Capriva del friuli',  '14590315584', '04-07-2020'),
    ('Iliana','Diana','DINILA85R07F804T','Udine',  '840315584', '04-07-2020'),
    ('Cosimino','Alarcio','ALOCOI47G38E715T','Udine',  '80590315584', '04-07-2020'),
    ('Elfride','Rollo','ROOELR67P13T617P','Porpetto',  '84500315584', '04-07-2020'),
    ('Gradita','Anastasio','ANIGRD30N04O833O','Spilimbergo',  '122254315584', '04-07-2020'),
    ('Sabina','Ananika','ANNSAN04M30V992Y','Aviano',  '845903145584', '04-07-2020');

insert into TipologiaGuasto(descrizione)
values
    ('Riparazione sostituzione tubo'),              -- tutti
    ('Installazione termi'),                        -- 7
    ('Riparazione caldaia'),                        -- 5
    ('Riparazione scheda caldaia'),                 -- 3
    ('Programmazione software caldaia'),            -- 3
    ('Installazione caldaia SMART');                -- 0

INSERT INTO Cliente(tipo, codiceFiscalePartitaIva, nome, cognome, ragioneSociale, codiceFiscaleReferente, indirizzo, recapitoTelefonico) 
VALUES
    ('p', 'PEIDEN21G30J090F', 'Desdemona', 'Pettorino', null, null, 'Enemonzo', '12345678'),
    ('p', 'TUCREN11F13M752T', 'Remondino','Tucci', null, null, 'Enemonzo', '12345678'),
    ('p', 'MUOFRS18F35O297W', 'Fruttuoso','Muolo', null, null, 'Enemonzo', '12345678'),
    ('p', 'THJMOA49L12U876Q', 'Moravio','Thiyagarajah', null, null, 'Enemonzo', '12345678'),
    ('p', 'OGGAUU93M00S379L', 'Aureo','Ogango', null, null, 'Enemonzo', '12345678'),
    ('a', '08100750010', null, null, 'Apple', 'MASUMR65I22M195F', 'Enemonzo', '12345678'),
    ('a', '08100550010', null, null, 'Microsoft', 'ROAEVN94I11I357H', 'Enemonzo', '12345678'),
    ('a', '08130750010', null, null, 'Tecnest', 'LARALR42N28Z423Z', 'Enemonzo', '12345678'),
    ('e', '08105655001', null, null, 'Comune di venezia', 'TAALAA62Z20N678S', 'venezia', '12345678'),
    ('e', '18100550010', null, null, 'Convitto Tomadini', 'GAAILL96I16V833I', 'udine', '12345678' );

insert into capaceDiRisolvere(cfTecnico, codiceGuasto)
values
    ('SOIFIM33U20Q912N', 1),
    ('GROPOT28U08E502Y',1),
    ('TUWQUZ78N29U115A',1),
    ('ARRRID59I33E601X',1),
    ('CALMIA96R30J564F',1),
    ('DINILA85R07F804T',1),
    ('ALOCOI47G38E715T',1),
    ('ROOELR67P13T617P',1),
    ('ANIGRD30N04O833O',1),
    ('ANNSAN04M30V992Y',1),

    ('SOIFIM33U20Q912N', 2),
    ('GROPOT28U08E502Y',2),
    ('TUWQUZ78N29U115A',2),
    ('ARRRID59I33E601X',2),
    ('CALMIA96R30J564F',2),
    ('DINILA85R07F804T',2),
    ('ANNSAN04M30V992Y',2),

    ('SOIFIM33U20Q912N', 3),
    ('TUWQUZ78N29U115A',3),
    ('ARRRID59I33E601X',3),
    
    ('SOIFIM33U20Q912N', 4),
    ('GROPOT28U08E502Y',4),
    ('CALMIA96R30J564F',4);


-- Test di query
-- Trovare chi sa fare cosa
select nome, cognome, descrizione 
from tecnico, capacedirisolvere, tipologiaguasto 
where 
    codiceFiscale = cftecnico 
    and tipologiaguasto.codiceguasto = capacedirisolvere.codiceguasto;

-- 