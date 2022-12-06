-- Limbajul de definire a datelor ( LDD )
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF

-- Creerea tabelului CLIENT
CREATE TABLE  CLIENT(
cod_numeric NUMBER(13) CONSTRAINT nn_cn_client NOT NULL,
id_agentie NUMBER(9) ,
id_zbor NUMBER(9) CONSTRAINT nn_iz_client NOT NULL,
cod_parcare NUMBER(9) CONSTRAINT nn_cp_client NOT NULL,
id_document NUMBER(9) CONSTRAINT nn_id_client NOT NULL,
nume VARCHAR2(20) CONSTRAINT nn_n_client NOT NULL,
prenume VARCHAR2(20),
email VARCHAR2(20),
varsta VARCHAR2(20) CONSTRAINT ck_varsta check (varsta >0),
sex VARCHAR2(10),
tara VARCHAR2(25),
oras VARCHAR2(20),
strada VARCHAR2(20),
numar NUMBER(4));
--Introducerea contrângerilor de PK asupra tabelului CLIENT
ALTER TABLE CLIENT
ADD CONSTRAINT pk_clienti primary key(cod_numeric);


-- Creerea tabelului TELEFON 
CREATE TABLE TELEFON(
cod_numeric NUMBER(13) CONSTRAINT nn_cn_telefon NOT NULL,
nr_telefon VARCHAR2(20) CONSTRAINT nn_nt_telefon NOT NULL );
--Introducerea contrângerilor de PK asupra tabelului TELEFON
ALTER TABLE TELEFON
ADD CONSTRAINT pk_cod_nr_clienti primary key(cod_numeric,nr_telefon);

-- Creerea tabelului DOCUMENT
CREATE TABLE DOCUMENT(
id_document NUMBER(7) CONSTRAINT nn_id_document NOT NULL,
nume VARCHAR2(50) CONSTRAINT nn_n_document NOT NULL,
serie VARCHAR(15) CONSTRAINT nn_s_document NOT NULL,
valabilitate DATE CONSTRAINT nn_v_document NOT NULL,
institutie_emitenta VARCHAR2(20) );
--Introducerea contrângerilor de PK asupra tabelului DOCUMENT
ALTER TABLE DOCUMENT
ADD CONSTRAINT pk_document primary key(id_document);

-- Creerea tabelului BAGAJ
CREATE TABLE BAGAJ(
id_bagaj NUMBER(9) CONSTRAINT nn_ib_bagaj NOT NULL,
id_zbor NUMBER(9) CONSTRAINT nn_iz_bagaj NOT NULL,
cod_numeric NUMBER(13) CONSTRAINT nn_cn_bagaj NOT NULL,
nume_proprietar VARCHAR2(20),
prenume_proprietar VARCHAR2(20),
greutate NUMBER(3),
culoare VARCHAR2(10),
telefon_proprietar VARCHAR2(20) CONSTRAINT nn_tp_bagaj NOT NULL,
tip_bagaj VARCHAR2(10) );
--Introducerea contrângerilor de PK asupra tabelului BAGAJ
ALTER TABLE BAGAJ
ADD CONSTRAINT pk_bagaj primary key(id_bagaj);


-- Creerea tabelului PARCARE
CREATE TABLE PARCARE(
cod_parcare NUMBER(9) CONSTRAINT nn_cp_parcare NOT NULL,
p_denumire VARCHAR2(50) CONSTRAINT nn_pd_parcare NOT NULL,
tara VARCHAR2(20),
oras VARCHAR2(20),
strada VARCHAR2(20), 
numar NUMBER(3),
p_suprafata NUMBER(3),
dist_arpt NUMBER(3),
locuri_disponibile NUMBER(3) CONSTRAINT nn_ld_parcare NOT NULL) ;
--Introducerea contrângerilor de PK asupra tabelului PARCARE
ALTER TABLE PARCARE
ADD CONSTRAINT pk_parcare primary key(cod_parcare);


-- Creerea tabelului AEROPORT
CREATE TABLE AEROPORT(
id_aeroport NUMBER(9) CONSTRAINT nn_ia_aeroport NOT NULL,
a_denumire VARCHAR2(20),
tara VARCHAR2(20),
oras VARCHAR2(20),
strada VARCHAR2(20),
numar NUMBER(3),
a_suprafata NUMBER(3),
nr_avioane NUMBER(3) ,
rating NUMBER(2) );
--Introducerea contrângerilor de PK asupra tabelului AEROPORT
ALTER TABLE AEROPORT
ADD CONSTRAINT pk_aeroport primary key(id_aeroport);

-- Creerea tabelului REZERVARE
CREATE TABLE REZERVARE(
cod_rezervare NUMBER(9) CONSTRAINT nn_cr_rezervare NOT NULL,
cod_numeric NUMBER(13) CONSTRAINT nn_cn_rezervare NOT NULL,
id_agentie NUMBER(9) CONSTRAINT nn_ia_rezervare NOT NULL,
nume VARCHAR2(20),
prenume VARCHAR2(20),
status_rezervare VARCHAR2(20) CONSTRAINT nn_sr_rezervare NOT NULL,
data_rezervare DATE,
r_locatie_plecare VARCHAR2(20),
r_locatie_destinatie VARCHAR2(20),
reducere NUMBER(2) );
--Introducerea contrângerilor de PK asupra tabelului REZERVARE
ALTER TABLE REZERVARE
ADD CONSTRAINT pk_rezervare primary key(cod_rezervare);

-- Creerea tabelului ZBOR
CREATE TABLE ZBOR(
id_zbor NUMBER(9) CONSTRAINT nn_iz_zbor NOT NULL,
id_avion NUMBER(9) CONSTRAINT nn_ia_zbor NOT NULL,
z_locatie_plecare VARCHAR2(20),
z_locatie_destinatie VARCHAR2(20) ,
z_data_plecare DATE,
data_intoarcere DATE,
tip_zbor VARCHAR2(20),
durata_zbor NUMBER(2) );
--Introducerea contrângerilor de PK asupra tabelului ZBOR
ALTER TABLE ZBOR
ADD CONSTRAINT pk_zbor primary key(id_zbor);

-- Creerea tabelului AVION
CREATE TABLE AVION(
id_avion NUMBER(9) CONSTRAINT nn_iav_avion NOT NULL,
id_aeroport NUMBER(9) CONSTRAINT nn_iae_avion NOT NULL,
id_service NUMBER(9) CONSTRAINT nn_is_avion NOT NULL,
firma VARCHAR2(20),
capacitate NUMBER(3),
model VARCHAR2(20),
culoare VARCHAR2(20),
data_revizie DATE CONSTRAINT nn_dr_avion NOT NULL );
--Introducerea contrângerilor de PK asupra tabelului AVION
ALTER TABLE AVION
ADD CONSTRAINT pk_avion primary key(id_avion);

-- Creerea tabelului FACILITATE
CREATE TABLE FACILITATE(
id_facilitate NUMBER(9) CONSTRAINT nn_if_facilitate NOT NULL,
denumire VARCHAR2(20) CONSTRAINT nn_d_facilitate NOT NULL,
clasa_facilitate VARCHAR2(20),
perioada VARCHAR2(20),
bonusuri VARCHAR2(20) );
--Introducerea contrângerilor de PK asupra tabelului FACILITATE
ALTER TABLE FACILITATE
ADD CONSTRAINT pk_facilitate primary key(id_facilitate);

-- Creerea tabelului APARTINE_DE
CREATE TABLE APARTINE_DE(
id_aeroport NUMBER(9) CONSTRAINT nn_ia_apartine_de NOT NULL,
cod_parcare NUMBER(9) CONSTRAINT nn_cp_apartine_de NOT NULL );
--Introducerea contrângerilor de PK asupra tabelului APARTINE_DE
ALTER TABLE APARTINE_DE
ADD CONSTRAINT pk_id_cod_apartine_de primary key(id_aeroport,cod_parcare);

-- Creerea tabelului DETINE
CREATE TABLE DETINE(
id_facilitate NUMBER(9) CONSTRAINT nn_if_detine NOT NULL,
id_zbor NUMBER(9) CONSTRAINT nn_iz_detine NOT NULL );
--Introducerea contrângerilor de PK asupra tabelului DETINE
ALTER TABLE DETINE
ADD CONSTRAINT pk_id_id_detine primary key(id_facilitate,id_zbor);

-- Creerea tabelului REALIZATA_PENTRU
CREATE TABLE REALIZATA_PENTRU(
cod_rezervare NUMBER(9) CONSTRAINT nn_cr_realizata_pentru NOT NULL,
id_zbor NUMBER(9) CONSTRAINT nn_iz_realizata_pentru NOT NULL );
--Introducerea contrângerilor de PK asupra tabelului REALIZATA_PENTRU
ALTER TABLE REALIZATA_PENTRU
ADD CONSTRAINT pk_cod_id_realizata_pentru primary key(cod_rezervare,id_zbor);

-- Creerea tabelului AGENTIE
CREATE TABLE AGENTIE(
id_agentie NUMBER(9) CONSTRAINT nn_ia_agentie NOT NULL,
denumire VARCHAR2(20),
tara VARCHAR2(20),
oras VARCHAR2(20),
strada VARCHAR2(20),
numar VARCHAR2(3),
rating NUMBER(2);
--Introducerea contrângerilor de PK asupra tabelului AGENTIE
ALTER TABLE AGENTIE
ADD CONSTRAINT pk_agentie primary key(id_agentie);

-- Creerea tabelului SERVICE
CREATE TABLE SERVICE(
id_service NUMBER(9) CONSTRAINT nn_is_service NOT NULL,
denumire VARCHAR2(20),
tara VARCHAR2(20),
oras VARCHAR2(20),
strada VARCHAR2(20),
numar NUMBER(3),
capacitate NUMBER(3),
nr_muncitori NUMBER(3) );
--Introducerea contrângerilor de PK asupra tabelului SERVICE
ALTER TABLE SERVICE
ADD CONSTRAINT pk_service primary key(id_service);

--Introducerea constrângerilor de FK asupra tabelului CLIENT
ALTER TABLE CLIENT
add constraint fk_client_doc  foreign key(id_document) references DOCUMENT(id_document);
ALTER TABLE CLIENT
add constraint fk_client_parc  foreign key(cod_parcare) references PARCARE(cod_parcare);
ALTER TABLE CLIENT
add constraint fk_client_zbor  foreign key(id_zbor) references ZBOR(id_zbor);
ALTER TABLE CLIENT
add constraint fk_client_agentie  foreign key(id_agentie) references AGENTIE(id_agentie);
--Introducerea constrângerilor de FK asupra tabelului BAGAJ
ALTER TABLE BAGAJ
add constraint fk_bagaj_client  foreign key(cod_numeric) references CLIENT(cod_numeric);
ALTER TABLE BAGAJ
add constraint fk_bagaj_zbor  foreign key(id_zbor) references ZBOR(id_zbor);
--Introducerea constrângerilor de FK asupra tabelului REZERVARE
ALTER TABLE REZERVARE
add constraint fk_rezerv_agent  foreign key(id_agentie) references AGENTIE(id_agentie);
ALTER TABLE REZERVARE
add constraint fk_rezerv_client  foreign key(cod_numeric) references CLIENT(cod_numeric);
--Introducerea constrângerilor de FK asupra tabelului TELEFON
ALTER TABLE TELEFON
add constraint fk_tel_client  foreign key(cod_numeric) references CLIENT(cod_numeric);
--Introducerea constrângerilor de FK asupra tabelului REALIZATA_PENTRU
ALTER TABLE REALIZATA_PENTRU
add constraint fk_realiz_pt_rezerv foreign key(cod_rezervare) references REZERVARE(cod_rezervare);
ALTER TABLE REALIZATA_PENTRU
add constraint fk_realiz_pt_zbor  foreign key(id_zbor) references ZBOR(id_zbor);
--Introducerea constrângerilor de FK asupra tabelului ZBOR
ALTER TABLE ZBOR
add constraint fk_zbor_avion foreign key(id_avion) references AVION(id_avion);
--Introducerea constrângerilor de FK asupra tabelului APARTINE_DE
ALTER TABLE APARTINE_DE
add constraint fk_apartine_de_parc foreign key(cod_parcare) references PARCARE(cod_parcare);
ALTER TABLE APARTINE_DE
add constraint fk_apartine_de_arpt foreign key(id_aeroport) references AEROPORT(id_aeroport);
--Introducerea constrângerilor de FK asupra tabelului AVION
ALTER TABLE AVION
add constraint fk_avion_arpt foreign key(id_aeroport) references AEROPORT(id_aeroport);
ALTER TABLE AVION
add constraint fk_avion_serv foreign key(id_service) references SERVICE(id_service);
--Introducerea constrângerilor de FK asupra tabelului DETINE
ALTER TABLE DETINE
add constraint fk_detine_zbor foreign key(id_zbor) references ZBOR(id_zbor);
ALTER TABLE DETINE
add constraint fk_detine_facilitate foreign key(id_facilitate) references FACILITATE(id_facilitate);

-- Limbajul de manipulare a datelor ( LMD )

-- Popularea tabelului DOCUMENT
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)
VALUES ('1','BULETIN','RX632311',to_date('06-06-2022','DD-MM-YYYY'),'S.P.C.E.P.Sector 1');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('2','CARTE NATIONALE DE IDENTITE','X4RTBPFW4',to_date('01-07-2022','DD-MM-YYYY'),'C.S.P. District 2');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('3','PASSPORT','MC220391',to_date('15-03-2022','DD-MM-YYYY'),'LONDON');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('4','PASSPORT','09971421',to_date('23-05-2022','DD-MM-YYYY'),'ROMA');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('5','BULETIN','RX225743',to_date('27-01-2022','DD-MM-YYYY'),'S.P.T. Sector 2');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('6','PASSPORT','07501321',to_date('01-12-2022','DD-MM-YYYY'),'NEW YORK');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('7','CARTE NATIONALE DE IDENTITE','T3FSEAQ5',to_date('23-05-2022','DD-MM-YYYY'),'C.S.P. District 9');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('8','PASSPORT','03931570',to_date('22-07-2022','DD-MM-YYYY'),'RIO DE JANEIRO');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('9','BULETIN','RT730373',to_date('24-02-2022','DD-MM-YYYY'),'S.P.C.E.P.Sector 6');
INSERT INTO DOCUMENT(id_document,nume,serie,valabilitate,institutie_emitenta)    
VALUES ('10','CARTE NATIONALE DE IDENTITE','S7AGRTL3',to_date('27-08-2022','DD-MM-YYYY'),'C.S.T. District 3');

-- Popularea tabelului AGENTIE
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('969034184','Vel Travel','Cipru','Nicosia','Olives','34','6');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('650377031','Escape Tour','Portugalia','Lisabona','Paco de Rainha','87','10');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('279979204','Christian Tour','America','Nashville','Spring','4','7');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('399301415','Europa Travel','Uruguay','Montevideo','Canelones','74','8');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('897393953','Eximtur','Lituania','Vilnius','Gedimino','7','5');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('929892602','Lala Tour','Algeria','Algiers','Fernane Hanafi','38','8');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('476393764','Travel Center','Italia','Venetia','Fiubera','16','10');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('338018835','Happy Tour','Spania','Barcelona','Sant Pere Mes Baix','91','9');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)   
VALUES ('216022914','Perfect Tour','Malta','Valleta','Georga Apina','3','7');
INSERT INTO AGENTIE(id_agentie,denumire,tara,oras,strada,numar,rating)
VALUES ('231549169','Fly Travel','Franta','Bordeaux','Frenes Bonie','57','9');

-- Popularea tabelului SERVICE
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('834774371','Airlines Service','Italia','Palermo','Verro','27','30','300');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('132567206','Blackburn Service','Germania','Hamburg','Montmartre','37','45','250');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('816077273','Travel Service','Spania','Matrid','Ribera','76','450','270');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('214355076','Bristol Service','Anglia','Manchester','Fournier','23','150','100');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('758452638','Boeing Service','China','Hong Kong','Nanluogu','53','400','300');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('256487300','Dornier Service','Franta','Ajaccio','Belfort','91','140','50');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('575424105','Corsair Service','Italia','Bologna','Catanzaro','12','130','230');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('727086982','Wildcat Service','Romania','Bucuresti','Niagara','71','160','100');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori) 
VALUES ('974188335','Heinkel Service','Germania','Munchen','Aichach','32','300','150');
INSERT INTO SERVICE(id_service,denumire,tara,oras,strada,numar,capacitate,nr_muncitori)
VALUES ('140768314','Junkers Service','Italia','Ascoli','Modena','104','300','250');

-- Popularea tabelului FACILITATE
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('875906499','Reduceri Craciun','I','20/12-27/12','Reducere 5%');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('599601229','Reduceri Paste','II','10/04-21/04','Reducere 10%');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('140703641','Reduceri Revelion','III','27/12-3/01','Reducere 15%');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('597578247','Reduceri Primavara','I','01/02-15/03','Reducere 5%');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('459149919','Reduceri batrani','II',NULL,'2xMeniu Cadou');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('416337032','Reduceri copii','II',NULL,'1xMeniu Cadou');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('354873129','Reduceri pers dizab','II',NULL,'1xMeniu Cadou');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('967514106','Reduceri familie','II','25/08-15/09','Reducere 10%');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('839545625','Oferta Dus-Intors','I','01/06-01/07','Reducere 20%');
INSERT INTO FACILITATE(id_facilitate,denumire,clasa_facilitate,perioada,bonusuri)
VALUES ('372791280','Oferta 3 in 2 ','III','01/06-01/07',NULL);


-- Popularea tabelului AEROPORT
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('266458205','Charles de Gaulle','Franta','Paris','Saint-Honore','43','23','500','10');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('739698796','Hartsfield','America','Atlanta','Mitchell','23','15','300','9');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('538689687','Heathrow','Anglia','Londra','Rampayne','67','10','200','7');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('738955369','Schiphol','Olanda','Amsterdam','Veenstraat','71','15','250','8');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('527863999','Baiyun','China','Guangzhou','Yingbinlu','1','10','130','7');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('181684543','Changi','Singapore','Nusajaya','Iskandar','35','19','200','8');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('216875067','Benito Juarez','Mexic','Ciudad de Mexico','Independencia','67','15','300','9');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('250107048','Fiumicino','Italia','Roma','Via Constanzo Cloro','3','16','270','8');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('669563694','Narita','Japonia','Tokyo','Daimaru','105','20','350','9');
INSERT INTO AEROPORT(id_aeroport,a_denumire,tara,oras,strada,numar,a_suprafata,nr_avioane,rating)
VALUES ('664836185','Domodedovo','Rusia','Moscova','Ramenki','10','15','200','9');


-- Popularea tabelului PARCARE

INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('924677972','Saligny Parking Center','Franta','Paris','Saint-Honore','40','2','1','130');
 INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('880111603','Rosier Parking Center','America','Atlanta','Mitchell','25','2','3','150');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('877805994','Holland Parking Lot','Anglia','Londra','Rampayne','63','2','2','100');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('184235981','Janssen Parking Lot','Olanda','Amsterdam','Veenstraat','75','3','2','150');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('601274112','Kimura Parking Center','China','Guangzhou','Yingbinlu','1','4','3','200');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('995639018','Yamada Parking Center','Singapore','Nusajaya','Iskandar','37','3','3','180');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('171456013','Matinez Parking Center','Mexic','Ciudad de Mexico','Independencia','80','4','3','190');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('306915697','Eriksen Parking Lot','Italia','Roma','Via Constanzo Cloro','10','3','7','130');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('669563694','Tanaka Parking Center','Japonia','Tokyo','Daimaru','98','2','1','100');
INSERT INTO PARCARE(cod_parcare,p_denumire,tara,oras,strada,numar,p_suprafata,dist_arpt,locuri_disponibile)
VALUES ('910944775','Stepanov Parking Lot','Rusia','Moscova','Ramenki','13','5','6','200');

-- Popularea tabelului APARTINE_DE

INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('266458205','924677972');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('739698796','880111603');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('538689687','877805994');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('738955369','184235981');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('527863999','601274112');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('181684543','995639018');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('216875067','171456013');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('250107048','306915697');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('669563694','669563694');
INSERT INTO APARTINE_DE(id_aeroport,cod_parcare)
VALUES ('664836185','910944775');

-- Popularea tabelului AVION

INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('206773413','527863999','834774371','Airbus','200','A300','alb',to_date('01-01-2023','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('845460189','739698796','132567206','Antonov','300','An-30','rosu',to_date('03-07-2024','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('146952677','266458205','816077273','Beriev','230','A-50','neagru',to_date('10-11-2025','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('803226411','664836185','974188335','Bristol','150','Beaufighter','mov',to_date('01-12-2027','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('438742218','538689687','758452638','Boeing','290','707','gri',to_date('27-01-2026','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('662959605','250107048','834774371','Defiant','210','DF3','rosu',to_date('07-10-2023','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('942960930','527863999','727086982','Airbus','250','A380','albastru',to_date('03-05-2022','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('648168516','216875067','974188335','Antonov','320','An-2E','alb',to_date('23-05-2025','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('840685408','738955369','140768314','Dassault Rafale','300','DC-9','alb',to_date('09-09-2023','DD-MM-YYYY'));
INSERT INTO AVION(id_avion,id_aeroport,id_service,firma,capacitate,model,culoare,data_revizie)
VALUES ('201516545','527863999','816077273','Kawasaki','240','Ki-45','verde',to_date('01-03-2027','DD-MM-YYYY'));


-- Popularea tabelului ZBOR
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('685498654','942960930','Guangzhou','Beijing',to_date('03-03-2022','DD-MM-YYYY'),to_date('05-03-2022','DD-MM-YYYY'),'low-cost','2');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('271426838','662959605','Roma','Barcelona',to_date('23-06-2022','DD-MM-YYYY'),to_date('27-06-2022','DD-MM-YYYY'),'business','1');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('591309249','803226411','Moscova','Copenhaga',to_date('09-07-2023','DD-MM-YYYY'),to_date('15-07-2023','DD-MM-YYYY'),'charter','4');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('357700841','206773413','Guangzhou','Tokyo',to_date('07-05-2023','DD-MM-YYYY'),to_date('11-05-2023','DD-MM-YYYY'),'low-cost','4');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('868523972','845460189','Atlanta','Denver',to_date('13-3-2024','DD-MM-YYYY'),to_date('17-03-2024','DD-MM-YYYY'),'business','4');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('422759460','840685408','Amsterdam','Lisabona',to_date('17-10-2023','DD-MM-YYYY'),to_date('20-10-2023','DD-MM-YYYY'),'charter','5');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('180627683','942960930','Guangzhou','Mumbai',to_date('27-06-2022','DD-MM-YYYY'),to_date('30-06-2022','DD-MM-YYYY'),'charter','5');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('511694339','648168516','Ciudad de Mexico','Washington',to_date('09-12-2023','DD-MM-YYYY'),to_date('12-12-2023','DD-MM-YYYY'),'low-cost','7');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('859130199','845460189','Atlanta','Ottawa',to_date('17-05-2024','DD-MM-YYYY'),to_date('20-05-2024','DD-MM-YYYY'),'business','6');
INSERT INTO ZBOR(id_zbor,id_avion,z_locatie_plecare,z_locatie_destinatie,z_data_plecare,data_intoarcere,tip_zbor,durata_zbor)
VALUES ('293200979','146952677','Paris','Bucuresti',to_date('23-12-2023','DD-MM-YYYY'),to_date('27-12-2023','DD-MM-YYYY'),'low-cost','4');


-- Popularea tabelului DETINE

INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('875906499','293200979');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('597578247','685498654');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('967514106','859130199');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('416337032','868523972');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('372791280','357700841');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('354873129','591309249');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('839545625','271426838');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('416337032','422759460');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('967514106','180627683');
INSERT INTO DETINE(id_facilitate,id_zbor)
VALUES ('839545625','859130199');


-- Popularea tabelului CLIENT

INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('6210518407131','279979204','271426838','306915697','1','Popescu','Andrei','pop.and@gmail.com','23','masculin','Romania','Bucuresti','Barajul Rovinari','34');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('5130116409491','476393764','511694339','171456013','2','Martin','Marie','m_ma@yahoo.com','37','feminin','Franta','Paris','Charlemagne','57');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('7130116039411','399301415','180627683','601274112','3','Smith','Andrew','a_smith@ymail.com','53','masculin','Anglia','Liverpool','Mathew','21');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('8130116097579','338018835','293200979','924677972','4','Regazzi','Antonio','ant.regaz@gmail.com','43','masculin','Italia','Roma','Via di Villa Patrizi','53');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('8110913096475','216022914','685498654','924677972','5','Georgescu','Horia','h_george@yahoo.com','33','masculin','Romania','Timisoara','Farului','3');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('3100913116682','897393953','422759460','184235981','6','Anderson','Louie','lo_anders@ymail.com','41','masculin','America','New York','Beaver','113');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('5040512397391','969034184','591309249','910944775','7','Benzimra','Rolan','rolan_ben@gmail.com','47','masculin','Franta','Toulousse','Croix Baragnon','50');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)
VALUES ('6040512397391','338018835','859130199','601274112','8','Rodrigues','Diego','di_rodri@gmail.com','31','masculin','Brazilia','Rio de Janeiro','Assembleia','83');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)   
VALUES ('6121051840713','650377031','180627683','601274112','9','Andrei','Gabriel','andr_gabi@gmail.com','20','masculin','Romania','Bucuresti','Aeromodelului','56');
INSERT INTO CLIENT(cod_numeric,id_agentie,id_zbor,cod_parcare,id_document,nume, prenume,email,varsta,sex,tara,oras,strada,numar)  
VALUES ('9130528397322','897393953','357700841','601274112','10','Rosier','Patrick','patr_ros@ymail.com','25','masculin','Franta','Marseille','Tivoli','37');

-- Popularea tabelului TELEFON

INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('6210518407131','9(99)289-44-46');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('5130116409491','06(76)883-91-24');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('5130116409491','2(3384)745-53-99');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('7130116039411','537(54)937-33-95');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('8130116097579','086(248)130-77-97');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('8110913096475','41(66)551-38-52');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('3100913116682','33(975)605-90-37');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('3100913116682','0(51)183-73-40');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('5040512397391','9(72)023-66-06');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('5040512397391','0(6786)384-56-72 ');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('6040512397391','2(22)052-07-66 ');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('6121051840713','63(7134)943-89-85');
INSERT INTO TELEFON(cod_numeric,nr_telefon)
VALUES ('6121051840713','059(820)729-59-69');
INSERT INTO TELEFON(cod_numeric,nr_telefon) 
VALUES ('9130528397322','06(198)924-82-34');
INSERT INTO TELEFON(cod_numeric,nr_telefon) 
VALUES ('9130528397322','309(8287)174-04-46');


-- Popularea tabelului BAGAJ
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('586882828','271426838','6210518407131','Popescu','Andrei','10','negru','9(99)289-44-46','geamantan');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('544962865','271426838','6210518407131','Popescu','Andrei','3','negru','9(99)289-44-46','ghiozdan');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('170679114','511694339','5130116409491','Martin','Marie','10','rosu','2(3384)745-53-99','troller');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('185814639','180627683','7130116039411','Smith','Andrew','8','galben','537(54)937-33-95','geamantan');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('525210993','293200979','8130116097579','Regazzi','Antonio','5','negru','086(248)130-77-97','troller');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('402918394','685498654','8110913096475','Georgescu','Horia','7','albastru','41(66)551-38-52','geamantan');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('872280621','422759460','3100913116682','Anderson','Louie','11','alb','0(51)183-73-40','geamantan');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('412248153','591309249','5040512397391','Benzimra','Rolan','3','mov','9(72)023-66-06','ghiozdan');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('188395537','859130199','6040512397391','Rodrigues','Diego','7','verde','2(22)052-07-66','troller');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('530774711','859130199','6040512397391','Rodrigues','Diego','3','galben','2(22)052-07-66','ghiozdan');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('325351404','180627683','6121051840713','Andrei','Gabriel','9','maro','059(820)729-59-69','troller');
INSERT INTO BAGAJ(id_bagaj,id_zbor,cod_numeric,nume_proprietar,prenume_proprietar,greutate,culoare,telefon_proprietar,tip_bagaj)
VALUES ('939618994','357700841','9130528397322','Rosier','Patrick','4','negru','06(198)924-82-34','ghiozdan');


-- Popularea tabelului REZERVARE
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('210304972','6210518407131','279979204','Popescu','Andrei','ACTIVE',to_date('23-12-2021','DD-MM-YYYY'),'Roma','Barcelona',12);
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('638612072','5130116409491','476393764','Martin','Marie','ACTIVE',to_date('09-03-2023','DD-MM-YYYY'),'Ciudad de Mexico','Washington','5');  
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('990987512','7130116039411','399301415','Smith','Andrew','ACTIVE',to_date('27-06-2021','DD-MM-YYYY'),'Guangzhou','Mumbai','0');
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('115062563','8130116097579','338018835','Regazzi','Antonio','ACTIVE',to_date('23-06-2023','DD-MM-YYYY'),'Paris','Bucuresti','15');
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('611689020','8110913096475','216022914','Georgescu','Horia','ACTIVE',to_date('03-06-2021','DD-MM-YYYY'),'Guangzhou','Beijing','10');
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('811042150','3100913116682','897393953','Anderson','Louie','ACTIVE',to_date('17-08-2023','DD-MM-YYYY'),'Amsterdam','Lisabona','0');
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('384344313','5040512397391','969034184','Benzimra','Rolan','ACTIVE',to_date('09-03-2023','DD-MM-YYYY'),'Moscova','Copenhaga','10');
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('850298629','6040512397391','338018835','Rodrigues','Diego','ACTIVE',to_date('17-05-2023','DD-MM-YYYY'),'Atlanta','Ottawa','20');
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('261371909','6121051840713','650377031','Andrei','Gabriel','ACTIVE',to_date('27-01-2022','DD-MM-YYYY'),'Guangzhou','Mumbai','5');
INSERT INTO REZERVARE(cod_rezervare,cod_numeric,id_agentie,nume,prenume,status_rezervare,data_rezervare,r_locatie_plecare,r_locatie_destinatie,reducere)
VALUES ('289619518','9130528397322','897393953','Rosier','Patrick','ACTIVE',to_date('07-02-2023','DD-MM-YYYY'),'Guangzhou','Tokyo','10');


-- Popularea tabelului REALIZATA_PENTRU
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('210304972','271426838');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('638612072','511694339'); 
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('990987512','180627683');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('115062563','293200979');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('611689020','685498654');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('811042150','422759460');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('384344313','591309249');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('850298629','859130199');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('261371909','180627683');
INSERT INTO REALIZATA_PENTRU(cod_rezervare,id_zbor)
VALUES ('289619518','357700841');


