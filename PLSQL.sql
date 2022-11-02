--Pachet
--compilare interfata pachet
CREATE OR REPLACE PACKAGE pachet_BD IS
--specificatia
/*
interfata utilizator,care contine:
-declaratii de tipuri ?i obiecte publice
-specificatii de subprograme
ºi tipuri private
-corpuri de subprograme
*/
FUNCTION nr_zboruri RETURN NUMBER;
FUNCTION nr_clienti RETURN NUMBER;
PROCEDURE avion_service_aeroport;
PROCEDURE clienti_zbor;
PROCEDURE insert_zbor(id_zbor NUMBER,id_avion NUMBER,z_locatie_plecare VARCHAR2,z_locatie_destinatie VARCHAR2,z_data_plecare DATE,data_intoarcere DATE,tip_zbor VARCHAR2,durata_zbor NUMBER);
PROCEDURE insert_rezervare(cod_rezervare NUMBER,cod_numeric NUMBER,id_agentie NUMBER,nume VARCHAR2,prenume VARCHAR2,status_rezervare VARCHAR2,data_rezervare DATE,r_locatie_plecare VARCHAR2,r_locatie_destinatie VARCHAR2,reducere NUMBER);
PROCEDURE insert_client(cod_numeric NUMBER,id_agentie NUMBER,id_zbor NUMBER,cod_parcare NUMBER,id_document NUMBER,nume VARCHAR2,prenume VARCHAR2,email VARCHAR2,varsta VARCHAR2,sex VARCHAR2,tara VARCHAR2,oras VARCHAR2,strada VARCHAR2,numar NUMBER); 
END pachet_BD;

--compilare corp pachet
CREATE OR REPLACE PACKAGE BODY pachet_BD IS
--corpul
/*
implementarea, care contine:
-declaratii de obiecte ºi tipuri private
-corpuri de subprograme specificate în partea de interfa?ã
*/
FUNCTION nr_zboruri RETURN NUMBER AS
nr NUMBER;
BEGIN
   SELECT  COUNT(id_zbor)
   INTO nr
   FROM ZBOR;
    
RETURN nr;
END nr_zboruri;
FUNCTION nr_clienti RETURN NUMBER AS
nr NUMBER;
BEGIN
   SELECT  COUNT(cod_numeric)
   INTO nr
   FROM CLIENT;
    
RETURN nr;
END nr_clienti;
/*
BEGIN
instructiuni de initializare,executate o singura data cand 
pachetul este invocat prima oara de catre sesiunea utilizatorului
*/
PROCEDURE insert_zbor(id_zbor NUMBER,id_avion NUMBER,z_locatie_plecare VARCHAR2,z_locatie_destinatie VARCHAR2,z_data_plecare DATE,data_intoarcere DATE,tip_zbor VARCHAR2,durata_zbor NUMBER) IS
BEGIN
   INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor) 
   VALUES 
   (id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor);
END insert_zbor;
PROCEDURE insert_rezervare(cod_rezervare NUMBER,cod_numeric NUMBER,id_agentie NUMBER,nume VARCHAR2,prenume VARCHAR2,status_rezervare VARCHAR2,data_rezervare DATE,r_locatie_plecare VARCHAR2,r_locatie_destinatie VARCHAR2,reducere NUMBER) IS
BEGIN
   INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere) 
   VALUES 
   (cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere);
END insert_rezervare;

PROCEDURE insert_client(cod_numeric NUMBER,id_agentie NUMBER,id_zbor NUMBER,cod_parcare NUMBER,id_document NUMBER,nume VARCHAR2,prenume VARCHAR2,email VARCHAR2,varsta VARCHAR2,sex VARCHAR2,tara VARCHAR2,oras VARCHAR2,strada VARCHAR2,numar NUMBER) IS
BEGIN
   INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume,prenume,email,varsta,sex,tara,oras,strada,numar) 
   VALUES 
   (cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume,prenume,email,varsta,sex,tara,oras,strada,numar);
END insert_client;

PROCEDURE avion_service_aeroport IS
TYPE inr IS RECORD (id_service SERVICE.id_service%TYPE, nr_avioane NUMBER);
TYPE tablou IS TABLE OF inr INDEX BY BINARY_INTEGER;
a_s tablou;
TYPE rec_data IS RECORD (id_aeroport AEROPORT.id_aeroport%TYPE, nr_avioane NUMBER);
TYPE table_data IS TABLE OF rec_data INDEX BY BINARY_INTEGER;
a_a table_data;
BEGIN
SELECT id_service,COUNT(*)
BULK COLLECT INTO a_s
FROM AVION 
GROUP BY id_service;
    
SELECT id_aeroport,COUNT(*)
BULK COLLECT INTO a_a
FROM AVION 
GROUP BY id_aeroport;    
    DBMS_OUTPUT.PUT_LINE('            ');
    DBMS_OUTPUT.PUT_LINE('         Grupare pe service-uri');
    DBMS_OUTPUT.PUT_LINE('            ');
FOR j IN a_s.FIRST..a_s.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Service-ul cu id: '||a_s(j).id_service||' contine '||a_s(j).nr_avioane||' avioane');
END LOOP;
    DBMS_OUTPUT.PUT_LINE('            ');
    DBMS_OUTPUT.PUT_LINE('         Grupare pe aeropoarte');
    DBMS_OUTPUT.PUT_LINE('            ');
FOR i IN a_a.FIRST..a_a.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Aeroportul cu id: '||a_a(i).id_aeroport||' contine '||a_a(i).nr_avioane||' avioane');
END LOOP;
END avion_service_aeroport;

PROCEDURE clienti_zbor IS
CURSOR curs_exp IS SELECT nume,COUNT(id_zbor) 
                    FROM CLIENT LEFT JOIN ZBOR USING(id_zbor)
                    GROUP BY nume
                    ORDER BY nume;
nume_client CLIENT.nume%TYPE;
numar NUMBER;
BEGIN
OPEN curs_exp;
LOOP
    FETCH curs_exp INTO nume_client,numar;
    EXIT WHEN curs_exp%NOTFOUND;
    IF numar=1 THEN
     DBMS_output.PUT_LINE('Clientul '||nume_client||' are planificat '||numar|| ' zbor.');
    END IF;
    IF numar>1 THEN
     DBMS_output.PUT_LINE('Clientul '||nume_client||' are planificate '||numar|| ' zboruri');
    END IF;
    
END LOOP;
CLOSE curs_exp;
END clienti_zbor;

END pachet_BD;


--Exercitiul 3. (Trigger)
CREATE OR REPLACE TRIGGER admin_console_client BEFORE INSERT OR UPDATE ON CLIENT
BEGIN
IF (TO_CHAR(SYSDATE, 'dy') NOT IN ('mon','tue','wed','thu','fri')) OR (TO_CHAR(SYSDATE, 'HH24:MI')
NOT BETWEEN '09:00' AND '18:00') THEN
IF INSERTING THEN
RAISE_APPLICATION_ERROR (-20500,'Program neautorizat de inserare a datelor in tabelul CLIENT'); 
ELSIF UPDATING THEN
RAISE_APPLICATION_ERROR (-20501,'Program neautorizat de updatare a datelor in tabelul CLIENT'); 
END IF;
END;
/

CREATE OR REPLACE TRIGGER admin_console_rezervare BEFORE INSERT OR UPDATE ON REZERVARE
BEGIN
IF (TO_CHAR(SYSDATE, 'dy') NOT IN ('mon','tue','wed','thu','fri')) OR (TO_CHAR(SYSDATE, 'HH24:MI')
NOT BETWEEN '09:00' AND '18:00') THEN
IF INSERTING THEN
RAISE_APPLICATION_ERROR (-20500,'Program neautorizat de inserare a datelor in tabelul REZERVARE'); 
ELSIF UPDATING THEN
RAISE_APPLICATION_ERROR (-20501,'Program neautorizat de updatare a datelor in tabelul REZERVARE'); 
END IF;
END;
/

CREATE OR REPLACE TRIGGER admin_console_zbor BEFORE INSERT OR UPDATE ON ZBOR
BEGIN
IF (TO_CHAR(SYSDATE, 'dy') NOT IN ('mon','tue','wed','thu','fri')) OR (TO_CHAR(SYSDATE, 'HH24:MI')
NOT BETWEEN '09:00' AND '18:00') THEN
IF INSERTING THEN
RAISE_APPLICATION_ERROR (-20500,'Program neautorizat de inserare a datelor in tabelul ZBOR'); 
ELSIF UPDATING THEN
RAISE_APPLICATION_ERROR (-20501,'Program neautorizat de updatare a datelor in tabelul ZBOR'); 
END IF;
END;
/

CREATE OR REPLACE TRIGGER cnp_check BEFORE INSERT OR UPDATE OF cod_numeric ON CLIENT FOR EACH ROW
BEGIN
IF( :NEW.cod_numeric < 1000000000000 OR :NEW.cod_numeric > 9999999999999)
THEN
RAISE_APPLICATION_ERROR (-20202, 'Clientul nu poate avea acest CNP '); 
END IF;
END; 
/
  
CREATE OR REPLACE TRIGGER dates_check BEFORE INSERT OR UPDATE OF z_data_plecare ON ZBOR FOR EACH ROW
BEGIN
IF( ROUND(:NEW.data_intoarcere - :NEW.z_data_plecare)< 0  )
THEN
RAISE_APPLICATION_ERROR (-20202, 'Datele cu privire la plecare si la sosirea zborului nu au fost introduse bine'); 
END IF;
END; 
/   

--Apelãri din pachetul creat
SET SERVEROUTPUT ON;
BEGIN
-- FUNCTII AJUTATOARE + APELARI
--pachet_bd.insert_zbor('1','206773413','Bucuresti','Sibiu',to_date('27-01-2022','DD-MM-YYYY'),to_date('31-01-2022','DD-MM-YYYY'),'business','1');
--pachet_bd.insert_rezervare('2','6040512397391','279979204','Popescu','Andrei','ACTIVE',to_date('23-12-2021','DD-MM-YYYY'),'Roma','Barcelona',12);
--pachet_bd.insert_client('7353591379099','929892602','271426838','306915697','3','Procopie','Gabriel','procopiegabi@gmail.com','23','masculin','Romania','Bucuresti','Linistei','27'); 
--DBMS_OUTPUT.PUT_LINE(pachet_bd.nr_zboruri);
--DBMS_OUTPUT.PUT_LINE(pachet_bd.nr_clienti);

--Exercitiul 1. Sa se afiseze numarul de avioane grupate in functie de service-ul si aeroportul de care apartin.(Colectii) 
pachet_bd.avion_service_aeroport;
--Exercitiul 2. Sa se afiseze pentru fiecare client, numarul de zboruri. Se va tine cont de clientii fara zboruri planificate.(Cursor explicit)
pachet_bd.clienti_zbor;
--Exercitiul 3. Creati un trigger pentru introducerea sau updatarea datelor din tabele CLIENT,REZERVARE ?i ZBOR inafara orelor de program. Se va afisa o eroare pentru fiecare tip de actiune.  (Trigger)
pachet_bd.insert_zbor('1','206773413','Bucuresti','Sibiu',to_date('27-01-2022','DD-MM-YYYY'),to_date('31-01-2022','DD-MM-YYYY'),'business','1');
pachet_bd.insert_rezervare('2','6040512397391','279979204','Popescu','Andrei','ACTIVE',to_date('23-12-2021','DD-MM-YYYY'),'Roma','Barcelona',12);
pachet_bd.insert_client('7353591379099','929892602','271426838','306915697','3','Procopie','Gabriel','procopiegabi@gmail.com','23','masculin','Romania','Bucuresti','Linistei','27'); 
--Exercitiul 4. Creati un trigger pentru verificarea codului numeric personal pentru momentul in care se doreste introducerea sau updatarea anumitor date.(Trigger)
pachet_bd.insert_client('100','929892602','271426838','306915697','3','Procopie','Gabriel','procopiegabi@gmail.com','23','masculin','Romania','Bucuresti','Linistei','27'); 
--Exercitiul 5. Creati un trigger pentru verificarea datelor de plecare si de sosire a unui zbor pentru momentul in care se doreste introducerea sau updatarea anumitor date.(Trigger)
pachet_bd.insert_zbor('1','206773413','Bucuresti','Sibiu',to_date('27-01-2022','DD-MM-YYYY'),to_date('21-01-2022','DD-MM-YYYY'),'business','1');

END;
/