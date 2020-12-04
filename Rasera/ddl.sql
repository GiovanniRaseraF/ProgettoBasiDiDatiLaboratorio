CREATE TABLE clienti(
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
        REFERENCES              tecnici(codiceFiscale)
        ON UPDATE               CASCADE
        ON DELETE               CASCADE,
    CONSTRAINT codiceGuasto            
        FOREIGN KEY             (codiceGuasto)
        REFERENCES              tipologiaGuasto(codiceGuasto)
        ON UPDATE               CASCADE
        ON DELETE               CASCADE
);


CREATE TABLE interventi(
    numeroIntervento            integer             NOT NULL GENERATED ALWAYS AS IDENTITY(
                                                        START       1
                                                        MINVALUE    1
                                                        MAXVALUE    2147483647
                                                        INCREMENT   1
                                                        CACHE       1),
    data                        timestamp           NOT NULL,
    durata                      integer             NOT NULL,
    modalita                    character(1)        NOT NULL,
    codiceRichiesta             integer             NOT NULL,
    cfTecnico                   varchar(16)         NOT NULL,

    CONSTRAINT interventi_pkey         
        PRIMARY KEY             (codiceRichiesta, numeroIntervento),
    CONSTRAINT cfTecnico               
        FOREIGN KEY             (cfTecnico)
        REFERENCES              tecnici(codiceFiscale)
        ON UPDATE               CASCADE
        ON DELETE               CASCADE
);



