
DROP SCHEMA IF EXISTS test_2904assistenzaGuasti CASCADE;

CREATE SCHEMA test_2904assistenzaGuasti;

SET search_path TO test_2904assistenzaGuasti;

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
    inerente                    integer             NOT NULL,             

    CONSTRAINT richiestaDAssistenza_pkey 
        PRIMARY KEY             (codiceRichiesta),
    CONSTRAINT codiceCliente 
        FOREIGN KEY             (codiceCliente) 
        REFERENCES              cliente(codiceFiscalePartitaIva) 
        ON UPDATE               CASCADE,
    CONSTRAINT fcinerente            
        FOREIGN KEY             (inerente)
        REFERENCES              tipologiaGuasto(codiceGuasto)
        ON UPDATE               CASCADE
        ON DELETE               CASCADE
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
INSERT INTO Tecnico(nome, cognome, codiceFiscale, indirizzo, 
    recapitoTelefonico, dataAssunzione)
VALUES
    ('Fidarma','Solombrino','SOIFIM33U20Q912N','Maniago', '84590315584', '04-07-2020'),-- 1 2 3 4
    ('Portos','Greco','GROPOT28U08E502Y','Cervignano del friuli',  '845590315584', '04-07-2020'),-- 1 2 3 4
    ('Quinzia','Tunwal','TUWQUZ78N29U115A','Travesio',  '845903155584', '04-07-2020'),--1 2 3
    ('Rinda','Arcidiacona','ARRRID59I33E601X','Arzene', '865903155584', '04-07-2020'),-- 1 2 3
    ('Miroslao','Caporale','CALMIA96R30J564F','Capriva del friuli',  '14590315584', '04-07-2020'),-- 1 2 3
    ('Iliana','Diana','DINILA85R07F804T','Udine',  '840315584', '04-07-2020'),-- 1 2
    ('Cosimino','Alarcio','ALOCOI47G38E715T','Udine',  '80590315584', '04-07-2020'),--1
    ('Elfride','Rollo','ROOELR67P13T617P','Porpetto',  '84500315584', '04-07-2020'),--1
    ('Gradita','Anastasio','ANIGRD30N04O833O','Spilimbergo',  '122254315584', '04-07-2020'),--1
    ('Sabina','Ananika','ANNSAN04M30V992Y','Aviano',  '845903145584', '04-07-2020');--1 2

INSERT INTO TipologiaGuasto(descrizione)
VALUES
    ('Riparazione sostituzione tubo'),              -- tutti
    ('Installazione termi'),                        -- 7
    ('Riparazione caldaia'),                        -- 5
    ('Riparazione scheda caldaia'),                 -- 3
    ('Programmazione software caldaia'),            -- 3
    ('Installazione caldaia SMART');                -- 0

INSERT INTO Cliente(tipo, codiceFiscalePartitaIva, nome, cognome, ragioneSociale, codiceFiscaleReferente, indirizzo, recapitoTelefonico) 
VALUES
    ('p', 'PEIDEN21G30J090F', 'Desdemona', 'Pettorino', NULL, NULL, 'Enemonzo', '12345678'),
    ('p', 'TUCREN11F13M752T', 'Remondino','Tucci', NULL, NULL, 'Enemonzo', '12345678'),
    ('p', 'MUOFRS18F35O297W', 'Fruttuoso','Muolo', NULL, NULL, 'Enemonzo', '12345678'),
    ('p', 'THJMOA49L12U876Q', 'Moravio','Thiyagarajah', NULL, NULL, 'Enemonzo', '12345678'),
    ('p', 'OGGAUU93M00S379L', 'Aureo','Ogango', NULL, NULL, 'Enemonzo', '12345678'),
    ('a', '08100750010', NULL, NULL, 'Apple', 'MASUMR65I22M195F', 'Enemonzo', '12345678'),
    ('a', '08100550010', NULL, NULL, 'Microsoft', 'ROAEVN94I11I357H', 'Enemonzo', '12345678'),
    ('a', '08130750010', NULL, NULL, 'Tecnest', 'LARALR42N28Z423Z', 'Enemonzo', '12345678'),
    ('e', '08105655001', NULL, NULL, 'Comune di venezia', 'TAALAA62Z20N678S', 'venezia', '12345678'),
    ('e', '18100550010', NULL, NULL, 'Convitto Tomadini', 'GAAILL96I16V833I', 'udine', '12345678' );

INSERT INTO capaceDiRisolvere(cfTecnico, codiceGuasto)
VALUES
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


INSERT INTO RichiestadAssistenza (
    data, -- yyyy-mm-dd
    seriale  ,
    dataFineAssistenza ,
    codiceCliente,
    inerente 
)
VALUES
( '2021-01-08', 'aa0_mack', null, 'PEIDEN21G30J090F', 1),
( '2021-01-08', 'aa0_mack', null, 'TUCREN11F13M752T', 1),
( '2021-01-11', 'bb0_selll', null, '08100750010', 3),
( '2021-01-12', 'aa0_mack', null, '08100550010', 4),
( '2021-01-13', 'aa12_mack', null, '08130750010', 1),
( '2021-01-14', 'aa0_mack', null, '08100550010', 2),
( '2021-01-14', 'aa0_m12k', null, '18100550010', 3),
( '2021-01-16', 'aa0_mack', null, '08100550010', 5),
( '2021-01-18', 'aa0_mack', null, '18100550010', 1),
( '2021-01-19', 'aa0_mack', null, 'PEIDEN21G30J090F', 2),

( '2021-01-20', 'aa0_mack', null, 'OGGAUU93M00S379L', 3),
( '2021-01-21', 'aa0_mack', null, 'OGGAUU93M00S379L', 3),
( '2021-01-22', 'bb0_selll', null, '08100750010', 1),
( '2021-01-23', 'aa0_mack', null, '08130750010', 2),
( '2021-01-25', 'aa12_mack', null, '08130750010', 3),
( '2021-01-26', 'aa0_mack', null, '08130750010', 4),
( '2021-01-27', 'aa0_m12k', null, '08105655001', 1),
( '2021-02-01', 'aa0_mack', null, '08130750010', 2),
( '2021-02-02', 'aa0_mack', null, '08105655001', 3),
( '2021-02-03', 'aa0_mack', null, 'PEIDEN21G30J090F', 5),

( '2021-02-04', 'aa0_mack', null, 'MUOFRS18F35O297W', 1),
( '2021-02-05', 'aa0_mack', null, 'MUOFRS18F35O297W', 2),
( '2021-02-06', 'bb0_selll', null, '08100550010', 3),
( '2021-02-08', 'aa0_mack', null, '08100550010', 3),
( '2021-02-09', 'aa12_mack', null, '08130750010', 1),
( '2021-02-10', 'aa0_mack', null, '08100550010', 2),
( '2021-02-11', 'aa0_m12k', null, '18100550010', 3),
( '2021-02-12', 'aa0_mack', null, '08100550010', 4),
( '2021-02-13', 'aa0_mack', null, '18100550010', 1),
( '2021-02-19', 'aa0_mack', null, 'MUOFRS18F35O297W', 2),
( '2021-02-23', 'aa0_mack', null, 'MUOFRS18F35O297W', 6);

insert into Intervento(
    data,
    durata,
    modalita,
    codiceRichiesta,
    cfTecnico)
VALUES
('2021-01-08', 2, 'r', 1, 'SOIFIM33U20Q912N'),
('2021-01-09', 5, 'r', 1, 'GROPOT28U08E502Y'),
('2021-01-08', 6, 's', 2, 'TUWQUZ78N29U115A'),
('2021-01-09', 1, 's', 2, 'TUWQUZ78N29U115A'),

('2021-01-11', 2, 'r', 3, 'CALMIA96R30J564F'),
('2021-01-12', 5, 'r', 3, 'ARRRID59I33E601X'),
('2021-01-12', 6, 's', 4, 'GROPOT28U08E502Y'),
('2021-01-13', 1, 's', 4, 'GROPOT28U08E502Y'),

('2021-01-14', 2, 'r', 5, 'ANNSAN04M30V992Y'),
('2021-01-14', 6, 's', 6, 'DINILA85R07F804T'),
('2021-02-13', 1, 's', 7, 'CALMIA96R30J564F');


-- Test di query
-- Trovare chi sa fare cosa
SELECT nome, cognome, descrizione 
FROM tecnico, capacedirisolvere, tipologiaguasto 
WHERE 
    codiceFiscale = cftecnico 
    AND tipologiaguasto.codiceguasto = capacedirisolvere.codiceguasto;

-- 
-- Conta per ogni richiesta il numero di interventi assegnati
select richiestadassistenza.codiceRichiesta, count(*) 
from richiestadassistenza, intervento 
where 
    richiestadassistenza.codiceRichiesta = intervento.codiceRichiesta 
group by richiestadassistenza.codiceRichiesta 
order by richiestadassistenza.codiceRichiesta;


-- Per ogni guasto il numero di interventi eseguiti
select tipologiaGuasto.descrizione, tipologiaGuasto.codiceGuasto, count(*) 
from tipologiaGuasto, richiestadassistenza, intervento 
where tipologiaGuasto.codiceGuasto = richiestadassistenza.inerente 
    and richiestadassistenza.codiceRichiesta = intervento.codiceRichiesta 
group by tipologiaGuasto.descrizione, tipologiaguasto.codiceGuasto
order by tipologiaGuasto.codiceGuasto;

select tipologiaGuasto.descrizione, tipologiaGuasto.codiceGuasto
from tipologiaGuasto, richiestadassistenza, intervento
where tipologiaGuasto.codiceGuasto = richiestadassistenza.inerente 
    and richiestadassistenza.codiceRichiesta = intervento.codiceRichiesta 
order by descrizione;

select tipologiaGuasto.descrizione, codiceRichiesta
from tipologiaGuasto, richiestadassistenza
where tipologiaGuasto.codiceGuasto = richiestadassistenza.inerente 
 
order by descrizione;
-- Per ogni guasto il numero di ore lavorate su di esso

