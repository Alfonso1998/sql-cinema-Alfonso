/* 1)IL NOME DI TUTTE LE SALE DI MILANO*/
SELECT  sale.nome,sale.citta
FROM sale
WHERE sale.citta='Milano'



/* 2)Il titolo dei film di Quentin Tarantino prodotti dopo il 1960*/
SELECT film.titolo 
FROM film
WHERE film.regista='Quentin Tarantino' and film.annoproduzione>1960



/* 3) IL TITOLO E L'INCASSO DEI FILM DI FANTASCIENZA GIAPPONESI O AMERICANI PRODOTTI DOPO IL 1990*/
SELECT film.titolo, proiezioni.incasso
FROM film join proiezioni on film.codfilm=proiezioni.codfilm 
WHERE  film.nazionalita='francese' or film.nazionalita='Americana' and film.genere='fantascienza' and film.annoproduzione>1990 


/* 4)IL TITOLO DEI FILM DI FANTASCIENZA GIAPPONESI PRODOTTI DOPO IL 1990 OPPURE USA*/
SELECT film.titolo
FROM film
WHERE film.nazionalita='giapponese' and film.genere='fantascienza' and film.annoproduzione>1990 or film.nazionalita='USA'


/*5)IL TITOLO DEL FILM DELLO STESSO REGISTA DI TENET */
SELECT film.titolo
FROM film
WHERE film.regista='Christopher Nolan'

/* 6)IL TITOLO E IL GENERE DEL FILM PROIETTATI IL 24 GENNAIO 2004*/
SELECT distinct film.titolo, film.genere 
FROM film join proiezioni on film.codfilm=proiezioni.codfilm
WHERE proiezioni.dataproiezione= '2004-01-25'


/* 7)IL TITOLO E IL GENERE DEL FILM PROIETTATI a napoli IL GIORNO DI NATALE*/
SELECT distinct film.titolo, film.genere,film.nazionalita, proiezioni.dataproiezione
FROM film join proiezioni on film.codfilm=proiezioni.codfilm
where film.nazionalita='Napoli' and proiezioni.dataproiezione='2004-12-25'


/* 8)I NOMI DELLE SALE A NAPOLI IN CUI IL GIORNO DI NATALE 2004 E' STATO PROIETTATO UN FILM CON S.LOREN*/
SELECT sale.nome 
FROM attori join recita on attori.codattore=recita.codattore join film on film.codfilm=recita.codfilm join proiezioni on film.codfilm=proiezioni.codfilm join sale on proiezioni.codsala=sale.codsala
WHERE sale.citta='Napoli' and proiezioni.dataproiezione='2004-12-25' and attori.nome='S. Loren'


/* 9)I TITOLI DEI FILM IN CUI RECITA M. MASTROIANNI OPPURE S.LOREN*/
SELECT film.titolo,attori.nome
FROM attori join recita on attori.codattore=recita.codattore join film on recita.codfilm=film.codfilm
WHERE  attori.nome='S. Loren' or attori.nome='M. Mastroianni' 



/* 10) TITOLI DEI FILM IN CUI RECITA M. MASTROIANNI E S.LOREN*/
SELECT film.titolo
FROM attori join recita on attori.codattore=recita.codattore join film on recita.codfilm=film.codfilm
WHERE  attori.nome='S. Loren' and attori.nome='M. Mastroianni' 


/* 11)PER OGNI FILM IN CUI RECITA UN ATTORE AMERICANO, IL TITOLO DEL FILM E IL NOME DELL'ATTORE*/
SELECT film.titolo, attori.nome
FROM film join recita on film.codfilm=recita.codfilm join attori on  recita.codattore=attori.codattore
WHERE attori.nazionalita='Americana'


/* 12)PER OGNI FILM PROIETTATO A NAPOLI A NATALE 2004 IL TITLO DEL FILM E IL NOME DELLA SALA*/
SELECT distinct  film.titolo, sale.nome
FROM film join proiezioni on film.codfilm=proiezioni.codfilm join sale on proiezioni.codsala=sale.codsala
WHERE sale.citta='Napoli' and proiezioni.dataproiezione='2004-12-25'


/*13)IL NUMERO DI SALE DI NAPOLI CON PIU' DI 60 POSTI*/
SELECT COUNT(*) as numeroSale
FROM sale
WHERE sale.citta='Napoli' and sale.posti>60
GROUP BY sale


/* 14)IL NUMERO TOTALE DI POSTI NELLE SALE A MILANO*/
SELECT sum(sale.posti) as totPosti
FROM sale
WHERE sale.citta='Milano'


/* 15)PER OGNI CITTA' IL NUMERO DI SALE*/
SELECT sale.citta, count(sale.nome)
FROM sale
GROUP BY sale.citta


/* 16)PER OGNI CITTA' IL NUMERO DI SALE CON PIU' DI 60 POSTI*/
SELECT COUNT(*) as numeroSale
FROM sale
WHERE  sale.posti>60
GROUP BY sale


/* 17)PER OGNI REGISTA IL NUMERO DI FILM DIRETTI DOPO IL 1990*/
SELECT  film.regista, count(film.regista) as filmProdotti
FROM film
WHERE film.annoproduzione>1990
group by film.regista
order by filmProdotti desc

/* 18)PER OGNI REGISTA L'INCASSO TOTALE DI TUTTE LE PROIEZIONI DEI SUOI FILM*/
SELECT film.regista, sum(proiezioni.incasso)
FROM film join proiezioni on film.codfilm=proiezioni.codfilm
GROUP BY film.regista


/* 19)PER OGNI FILM DI Quentin Tarantino, IL TITOLO DEL FILM, IL NUMERO  DI PROIEZIONI a Milano E L'INCASSO TOTALE*/
SELECT film.regista, film.titolo, proiezioni.incasso, count(*) as numProiezioniMilano
FROM film join proiezioni on film.codfilm=proiezioni.codfilm join sale on proiezioni.codsala=sale.codsala
WHERE film.regista='Quentin Tarantino' and sale.citta='Milano'
GROUP BY film.regista, film.titolo, proiezioni.incasso 


/* 20)PER OGNI REGISTA E PER OGNI ATTORE IL NUMERO DI FILM DEL REGISTA CON L'ATTORE*/
SELECT attori.nome,film.regista ,count(film.titolo) as filmInsieme
from attori join recita on attori.codattore=recita.codattore join film on recita.codfilm=film.codfilm
group by attori.nome,film.regista

/*SELECT attori.nome,film.regista,film.titolo 
from attori join recita on attori.codattore=recita.codattore join film on recita.codfilm=film.codfilm
where film.regista='Christopher Nolan'*/



/* 21)IL REGISTA ED IL TITOLO DEI FILM IN CUI RECITANO MENO DI 6 ATTORI*/
SELECT film.regista,film.titolo,count(attori.nome) as numeroAttori
FROM attori join recita on attori.codattore=recita.codattore join film on recita.codfilm=film.codfilm
GROUP BY film.regista,film.titolo 
HAVING count(attori.nome)<6


/*22)PER OGNI FILM PRODOTTO DOPO IL 2000, IL CODICE, IL TITOLO, E L'INCASSO TOTALE DI TUTTE LE SUE PROIEZIONI*/
SELECT distinct film.titolo,film.codfilm, sum(proiezioni.incasso)
FROM film join proiezioni on film.codfilm=proiezioni.codfilm
WHERE film.annoproduzione>2000
GROUP BY film.titolo,film.codfilm


/* 23)IL NUMERO DI ATTORI DEI FILM NATI PRIMA DEL 1970*/
SELECT count(*)
FROM attori 
WHERE attori.annonascita<1970


/* 24)PER OGNI FILM DI FANTASCIENZA CHE NON E' MAI STATO PROIETTATO NEL 1/1/01 IL TITOLO E L'INCASSO TOTALE DI TUTTE LE SUE PROIEZIONI*/
