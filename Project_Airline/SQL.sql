--Exercitiul 1  Sã se afiseze pentru toþi clienþi ale cãror prenume se terminã cu litera e, codul numeric, numele ºi pozitia din prenume în care apare prima literã e.

--Solutia

SELECT cod_numeric CNP, nume||' '||prenume Client,instr(lower(prenume),'e') "Prima literã e"
FROM CLIENT
WHERE SUBSTR(LOWER(prenume),-1)='e';

--Exercitiul 2   Sã se afiseze id-ul,firma avionului, data reviziei si data scoateri acesteia din  folosintã , care este prima  zi  de  vineri  dupã  10 ani           (120 de luni) de lucru. Etichetati aceastã coloanã "Scos din funcþiune la data de".

--Solutia

SELECT id_avion,firma,data_revizie,NEXT_DAY(ADD_MONTHS(data_revizie,120),'vineri') " Scos din funcþiune la data de "
FROM AVION;

--Exercitiul 3  Pentru fiecare avion sã se afiseze id_ul, firma si numãrul de luni de la data curentã la data de revizie. Etichetaþi coloana aceasta cu „Luni ramase pana la revizie”. Sã se ordoneze rezultatul dupã numãrul de luni rãmase. Se va rotunji numãrul de luni la cel mai apropriat întreg.

--Solutia

SELECT id_avion,firma,data_revizie, ROUND(MONTHS_BETWEEN(data_revizie,SYSDATE),0) "Luni ramase pana la revizie"
FROM AVION
ORDER BY 3;

--Exercitiul 4 Sã se listeze clientii a cãror data de rezervare a fost fãcutã cu 28 de zile în avans fatã de data de 31 ianuarie 2022 si care nu au primit o reducere mai mare de 15%.

--Solutia

SELECT nume,prenume,data_rezervare,reducere
FROM REZERVARE
WHERE round(data_rezervare- to_date('31-01-2022','DD-MM-YYYY'))>28 AND NVL(reducere,0) < 15

--Exercitiul 5  Sã se afiseze id-ul, locatia si tipul de zbor. Sã se adauge o coloanã care sã arate durata de zbor dupã o actualizare în functie de tipul de zbor. Dacã zborurile sunt de tipul low-cost atunci durata de zbor se va mãri cu 30%. Dacã zborurile sunt de tipul charter atunci durata de zbor se va scãdea cu 30%. Dacã zborurile sunt de tipul business atunci durata de zbor se va scãdea cu 50%. Pentru celelalte tipuri de zboruri nu existã actualizãri a duratei de zbor.

--Solutia

SELECT id_zbor,z_locatie_destinatie,tip_zbor,
CASE tip_zbor WHEN 'low-cost' THEN ROUND(durata_zbor*1.3)
              WHEN 'charter' THEN ROUND(durata_zbor - durata_zbor*0.3)
              WHEN 'business' THEN ROUND(durata_zbor - durata_zbor*0.5)
              ELSE durata_zbor
 END "Timp de zbor actualizat"
 FROM ZBOR;

--Exercitiul 6  Sã se afiseze id-ul, firma si capacitatea avioanelor. Sã se adauge o coloanã care sã arate capacitatea dupã revizie. Se stie cã avioanele care au data de revizie '27-01-2026', '01-03-2027', '03-07-2024', '01-12-2027', '09-09-2023' se vã obtine o  mãrire a capacitãtii cu 50%,70%,30%,20% respectiv 60%. Pentru celelalte avioane nu existã buget pentru o mãrire a capacitãtii.

--Solutia

SELECT id_avion,firma,data_revizie,capacitate,DECODE(data_revizie,
                            '27-01-2026',capacitate*1.5,
                            '01-03-2027',capacitate*1.7,
                            '03-07-2024',capacitate*1.3,
                            '01-12-2027',capacitate*1.2,
                            '09-09-2023',capacitate*1.6,
                            capacitate) Capacitate_dupa_revizie
FROM AVION;

--Exercitiul 7 Sã se afiseze numele clientului, codul si destinatia zbor pentru toti clientii.

--Solutia

SELECT nume||' '||prenume Client,cod_numeric CNP,z.id_zbor,z_locatie_destinatie Destinatie
FROM CLIENT c LEFT JOIN ZBOR z ON (c.id_zbor=z.id_zbor);

--Exercitiul 8  Sã se afiseze codul,numele parcãrii ºi numãrul de clienþi care au parcat în parcarea respectivã pentru parcãrile în care au parcat mai mult de un client

--Solutia

SELECT cod_parcare,p_denumire,count(cod_numeric)
from CLIENT RIGHT JOIN PARCARE USING (cod_parcare)
group by cod_parcare,p_denumire
having count(cod_numeric)>0


--Exercitiul 9  Sã se listeze numele tuturor clientilor si tuturor rezervãrilor.  

--Solutia

SELECT c.nume||' '||c.prenume Client,c.oras||'('||c.tara||'),'||c.strada||' '||c.numar Adresa, r.cod_rezervare Cod,r.status_rezervare,r.r_locatie_destinatie
FROM REZERVARE r FULL OUTER JOIN CLIENT c ON r.cod_numeric=c.cod_numeric
ORDER BY r.cod_rezervare;

--Exercitiul 10 Sã se afiseze parcãrile care au o suprafatã mai mare de 2 km2  si care are au mai mult de 100 de locuri disponibile, dar care au o distanta pana la aeroportul de care apartin mai micã de 2 km.

--Solutia

SELECT p_denumire Nume, oras||'('||tara||'),Strada '||strada||' nr. '||numar Localizare
FROM PARCARE
WHERE p_suprafata > 2
UNION
SELECT p_denumire Nume, oras||'('||tara||'),Strada '||strada||' nr. '||numar Localizare
FROM PARCARE
WHERE locuri_disponibile > 100
MINUS
SELECT p_denumire Nume, oras||'('||tara||'),Strada '||strada||' nr. '||numar Localizare
FROM PARCARE
WHERE dist_arpt > 2;

--Exercitiul 11  Sã se afiseze agentiile de voiaj care au în componenta numelui sirul Travel sau Tour si care au clienti cu vârsta cuprinsã între 18 si 40  de ani.

--Solutia

SELECT id_agentie,denumire,rating
FROM AGENTIE
WHERE denumire like ('%Travel%') OR denumire like ('%Tour%')
INTERSECT
SELECT id_agentie,denumire,rating
FROM AGENTIE JOIN CLIENT USING (id_agentie)
WHERE varsta BETWEEN 18 AND 40;

--Exercitiul 12 Sã se afiseze pentru fiecare tipurile de zbor business si charter, data plecãrii împreunã cu durata medie estimatã de zbor pentru fiecare voiaj în parte.  

--Solutia

SELECT tip_zbor,TO_CHAR(z_data_plecare,'yyyy'),ROUND(AVG(durata_zbor))
FROM ZBOR
WHERE tip_zbor IN ('business','charter')
GROUP BY ROLLUP(tip_zbor,TO_CHAR(z_data_plecare,'yyyy'));

--Exercitiul 13  Sã se afiseze id-ul bagajului, greutatea bagajului si codul numeric al posesorului împreunã cu greutatea minimã, maximã si totalã a tuturor bagajelor detinute de client.

--Solutia

SELECT id_bagaj,greutate,cod_numeric,Gr_minima,Gr_maxima,Gr_totala,nr_bagaje
FROM BAGAJ JOIN
( SELECT MIN(greutate) Gr_minima,MAX(greutate) Gr_maxima, SUM(greutate) Gr_totala,cod_numeric,count(cod_numeric) nr_bagaje
  FROM BAGAJ
  GROUP BY cod_numeric) USING(cod_numeric);

--Exercitiul 14  Sã se afiseze informatii despre avioanele ale cãror capacitate depãseste valoarea medie a capacitãti avioanelor din acelasi aeroport.

--Solutia

SELECT id_avion,firma,capacitate,e.id_aeroport,a_denumire,
           (SELECT ROUND(AVG(capacitate)) 
            FROM AVION 
            WHERE e.id_aeroport=id_aeroport) Capacitate_medie, 
           (SELECT COUNT(*)
            FROM AVION
            WHERE e.id_aeroport=id_aeroport) Numar
FROM AVION e JOIN AEROPORT d on (e.id_aeroport =d.id_aeroport)
WHERE capacitate >= (SELECT AVG(capacitate)
                     FROM AVION
                     WHERE e.id_aeroport=id_aeroport);
                                                       
--Exercitiul 15  Sã se afiseze codurile parcãrilor care aparþin tuturor aeropoartelor din Paris care au un rating egal  cu 10.

--Solutia   
                SELECT cod_parcare
                FROM APARTINE_DE
                WHERE id_aeroport IN
                               ( SELECT id_aeroport
                                 FROM AEROPORT
                                 WHERE rating=10 AND oras='Paris')
                GROUP BY cod_parcare
                HAVING COUNT(id_aeroport) = ( SELECT COUNT(*)
                                                                           FROM AEROPORT
                                                                           WHERE rating=10 AND oras='Paris');                                                              





