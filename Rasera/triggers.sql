CREATE OR REPLACE FUNCTION controlloInserisciCliente()
RETURN TRIGGER LANGUAGE PLPGSQL AS 
$$
    DECLARE
        tipo        character(1);
    BEGIN
        -- Triggere di controllo
        tipo := new.tipo;

        -- Verifico il codice fiscale
        if not verificaCodiceFiscale(tipo)  
           or not verificaCodiceFiscale(new.codiceFiscaleReferente) then 
            return NULL;

        -- Verifico che sia stata settata 
        -- una delle possibili tipologie di cliente
        if tipo = 's' or tipo = 'S' then        
            -- Singolo cittadino
            if new.nome = NULL or new.cognome = NULL then 
                return NULL;

            return new;
        else 
        if tipo = 'a' or tipo = 'A' then
            -- Azienda
            if new.codiceFiscaleReferente = NULL then 
                return NULL;

            return new;
        else 
        if tipo = 'e' or tipo = 'E' then
            -- Ente pubblico
            if new.codiceFiscaleReferente = NULL then 
                return NULL;
            
            return new;
        else
            -- Opzione non possibile
            return NULL;
        
    END;
$$

CREATE TRIGGER triggerInserimentoCliente BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW 
    EXECUTE PROCEDURE controlloInserisciCliente();


