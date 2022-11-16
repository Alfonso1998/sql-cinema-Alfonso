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
SELECT film.titolo,film.regista
FROM film
WHERE film.regista='Christopher Nolan'