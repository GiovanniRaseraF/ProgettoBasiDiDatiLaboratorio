/*Inserimento Operazione 1*/
INSERT INTO cliente
    VALUES(
        $cf_pi, 
        $indirizzo, 
        $recapito_tel, 
        $nome, 
        $cognome, 
        $tipo, 
        $cf_ref
    )

/*Operazione 2*/
INSERT INTO richiestaDAssistenza
    VALUES(
        data, 
        codice_richiesta, 
        data_fine_assistenza, 
        $codice_seriale, 
        $id_codice_guasto,
        $id_cliente_richiedente
    )

/*Operazione 3*/
/*
1 - prendere il codice guasto -> cod_g
2 - da cod_g trovare quali Tecnici sanno risolvere cod_g -> sanno_risolvere_ma_disponibili?
3 - da sanno_risolvere_ma_disponibili? controllare su Intervento se in una data quel tecnico è libero -> tecnici_capaci_e_liberi
4 - da tecnici_capaci_e_liberi trovo quello che in questo ha lavorato meno -> tecnico_scelto
5 - tecnico_scelto lo assegno all'intervento 
    5.1 - aggiornamento delle ore lavorate in tecnico
6 - chiudo la transazione
*/


/*Operazione 4*/
INSERT INTO tecnico
    VALUES(
        ore_lavorate_mensilmente = 0,
        $codice_fiscale,
        $nome,
        $cognome,
        $indirizzo,
        $recap,
        $data_assunzione /*Potrebbe essere now*/
    )

/*Operazione 4.1
Aggionare le skils del tecnico
*/

/*Operazione 5*/
SELECT richiesta_assistenza.codice
FROM richiesta_assistenza, cliente
WHERE cliente = $cliente_da_filtrare


/*Operazione 6*/
SELECT tecnico.ore_lavorate_mensilmente
FROM tecnico
WHERE tecnico.ore_lavorate_mensilmente > 0

/*Operazione 7*/
VIEW ?
SELECT COUNT(è_capace_di) as numero_tecnici 
FROM è_capace_di
WHERE è_capace_di.id_codice_guasto = $id_codice_guasto
FINE

VIEW ?
SELECT COUNT(interventi) as numero_interventi
FROM interventi
WHERE EXISTS(
        SELECT *
        FROM richiesta_assistenza
        WHERE richiesta_assistenza.id_codice_guasto = $id_codice_guasto
    )
FINE

/*la divisione tra i due mi darà il risultato*/

/*Operazione 8*/
SELECT intervento.*
FROM intervento
WHERE intervento.id_richiesta_assistenza = $id_richiesta_assistenza


/*Operazione 9*/
SELECT SUM(intervento.durata) AS totale_ore_cliente
FROM cliente, richiesta_assistenza, intervento
WHERE cliente.codice_fiscale = $cliente AND intervento.data >= $data_inserita
 