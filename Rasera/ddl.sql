CREATE TABLE clienti(
    codiceFiscalePartitaIva     varchar(16)         NOT NULL,
    indirizzo                   varchar(20)         NOT NULL,
    recapitoTelefonico          varchar(10)         NOT NULL,
    tipo                        character(1)                ,
    codiceFiscaleReferente      varchar(16)                 ,
    nome                        varchar(20)                 ,
    cognome                     varchar(20)                 ,

    CONSTRAINT
        cliente_pkey            PRIMARY KEY (codiceFiscalePartitaIva)
);