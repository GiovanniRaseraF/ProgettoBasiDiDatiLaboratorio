# Progetto Basi Di Dati Laboratorio
Il progetto riguarda il laboratorio del corso di Basi di dati

# Autori
- Giovanni Rasera (143395) rasera.giovanni@spes.uniud.it
- Matteo Brugnera (137370) brugnera.matteo@spes.uniud.it
- Loris Parata (144338) parata.loris@spes.uniud.it

# Struttura della Repository
- Una cartella per ogni partecipante in cui si può lavorare senza confondere il lavoro di altri
- Nella cartella di ogni partecipante è presente un file .gitignore comodo per non condividere file inutili presenti nelle cartelle di lavoro 
- Cartella Immagini dove sono presenti le foto scattate sulla lavagna o degli screen importanti
- Cartella Utili dovo si possono mettere all'interno file/informazioni utili al progetto
- Cartella Relazione dove saranno presenti tutti i file relativi alla relazione in LaTeX con la corrente versione compilata in pdf
- Cartella OldVers che ha al suo interno tutte le versioni precedenti alla corrente relazione 

# Testo Specifiche
- [TESTO](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Consegna.pdf)

# TODO
- Analisi generale dei requisiti
- Analisi generale delle operazioni
- Traduzione schama ER
- Colloquio con il prof. Montanari per chiarimenti sui problemi sottostanti	-- Giovedì 05/11/2020
- (Per il 04/11/2020)
- Brugnera
	- Sezione tabella requisiti e volumi
- Rasera
	- Vincoli di integrità
- Parata
	- Riscrittura dei requisiti
- IMPORTANTE!!
	- Decidere come scrivere nomi degli attributi relazioni e entità
		- camelizzazione fineDataIntervento
		- underscore fine_data_intervento
		- Lettera maiuscola per Entità (Intervento)
		- Lettera minuscola per relazione (richiede)

# Problemi
- Prendere decisione per la modellazione del problema, per quanto riguarda i guasti legati all'assistenza per i vari problemi:
	- Relazione di grado superiore ?
	- Attributi duplicati ?
- Problema sull'eliminazione completa o parziale di un cliente/dipendente (tramite flag di qualsiasi tipo)
- Chiedere della della sezione Guasto, E' entità debole in collegamento con la relazione Richiede
	- [Schema 1](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Alternativa_1.jpg)
	- [Schema 2](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Alternativa_2.jpg)
- Richiedere la parte relativa ai guasti e alle assistenze collegate con le assistenze
	- la perplessità riguarda il fatto un guasto può metterci più giorni per essere risolto quindi lo schema va bene come è
	- se no fosse così e quindi il guasto deve essere per forza risolto in giornata, allora lo schema non andrebbe bene siccome la 1..N dalla parte di Assistenza verso Internvento non ha senso.
- Come fa un Intervento ad essere aggiunto al database
	- Viene aggiunto nel momento della creazione della richiesta dal parte dell'utente?
	- Viene aggiunto ogni giorno se non ho ancora finito di risolvere il guasto
- Il guasto non è entità debole di assistenza
- La relazione tra Guasto, Assistenza e Cliente non è reificata in modo corretto 
	- sorge infatti il problema di non poter aggiungere un guasto uguale a due Assistenze diverse siccome Guasto compare come una (1,1) nella relazione

# Risolti
- [LA DECISIONE E' STATA QUELLA DI UTILIZZARE LO SCHEMA 2](- Prendere una decisione sul tipo di modellazione da dare alla sezione dello schema che riguarda il punto 2 nel problema
	- modellazione di cliente metodo 1 [Schema 1](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Schema_1.png)
	- modellazione di cliente metodo 2 [Schema 2](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Schema_2.png)
)

