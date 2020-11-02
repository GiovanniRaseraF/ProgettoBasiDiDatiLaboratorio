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

# Problemi
- Prendere decisione per la modellazione del problema, per quanto riguarda i guasti legati all'assistenza per i vari problemi:
	- Relazione di grado superiore ?
	- Attributi duplicati ?
- Problema sull'eliminazione completa o parziale di un cliente/dipendente (tramite flag di qualsiasi tipo)
- Chiedere della della sezione Guasto, E' entità debole in collegamento con la relazione Richiede
	- [Schema 1](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Alternativa_1.jpg)
	- [Schema 2](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Alternativa_2.jpg)

# Risolti
- [LA DECISIONE E' STATA QUELLA DI UTILIZZARE LO SCHEMA 2](- Prendere una decisione sul tipo di modellazione da dare alla sezione dello schema che riguarda il punto 2 nel problema
	- modellazione di cliente metodo 1 [Schema 1](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Schema_1.png)
	- modellazione di cliente metodo 2 [Schema 2](https://github.com/GiovanniRaseraF/ProgettoBasiDiDatiLaboratorio/blob/main/Parata/Schema_2.png)
)

