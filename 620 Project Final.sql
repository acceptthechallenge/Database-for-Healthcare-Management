-- Tables

Set serveroutput on; 

drop sequence generate_patient;
create sequence generate_patient start with 306;
drop sequence generate_admission;
create sequence generate_admission start with 406;
drop sequence generate_message;
create sequence generate_message start with 7;

drop table hospital cascade constraints;
drop table doctor cascade constraints;
drop table patient cascade constraints;
drop table nurse cascade constraints;
drop table room cascade constraints;
--drop table shift cascade constraints;
drop table admission cascade constraints;
drop table admission_room cascade constraints;
drop table shift_room cascade constraints;
drop table message cascade constraints;
drop table prescription cascade constraints;
drop table treatment cascade constraints;
drop table admission_treatment cascade constraints;
drop table drug cascade constraints;
drop table drug_allergy cascade constraints;
drop table doctor_hospital cascade constraints;


create table hospital(hid int, hname varchar(20), haddress varchar(50), primary key(hid));
insert into hospital values ( 1, 'Spring Grove', '1220 Martin st, Catonsville, MD');
insert into hospital values ( 2, 'Saint Agnes', '2001 Hilltop Circle,Baltimore, MD');
insert into hospital values ( 3, 'Medstar Union', '100 western blvd, Baltimore, MD');
insert into hospital values ( 4, 'Northwest', '2120 Randallstown, MD');
insert into hospital values ( 5, 'Mercy', '601 Park Street, Downtown, MD');


create table doctor( did int, dname varchar(20),primary key(did));
insert into doctor values ( 200,'Sunil Bansal');
insert into doctor values ( 201,'Vincent Chang');
insert into doctor values ( 202,'Mark Ruffalo');
insert into doctor values ( 203,'Shawn Gomes');
insert into doctor values ( 204,'Marie Dong');

create table doctor_hospital( did int, hid int, primary key(did, hid), foreign key(did) references doctor, foreign key(hid) references hospital);

insert into doctor_hospital values( 200, 1);
insert into doctor_hospital values( 200, 2);
insert into doctor_hospital values( 201, 3);
insert into doctor_hospital values( 202, 4);
insert into doctor_hospital values( 203, 5);
insert into doctor_hospital values(	204, 5);

create table nurse( nid int, nname varchar(20), hid int, primary key(nid), foreign key(hid) references hospital);

insert into nurse values(900,'Ella',1);
insert into nurse values(901,'Julie',2);
insert into nurse values(902,'Sam',1);
insert into nurse values(903,'Angelina',2);
insert into nurse values(904,'Rihanna',3);
insert into nurse values(905,'Sia',5);
insert into nurse values(906,'Madonna',5);
insert into nurse values(907, 'Billy',4);

create table room( rid int, hid int, location varchar(50), rtype varchar(20), primary key(rid), foreign key(hid) references hospital);

insert into room values(101, 1, 'Building A room 101', 'Regular');
insert into room values(102, 1, 'Building B room 102', 'Operation room');
insert into room values(103, 1, 'Building C room 103', 'ICU');
insert into room values(104, 2, 'Tower A room 104', 'Regular');
insert into room values(105, 2, 'Tower B room 105', 'ICU');
insert into room values(106, 2, 'Tower C room 106', 'Operation room');
insert into room values(107, 3, 'Unit A room 107', 'Regular');
insert into room values(108, 4, 'Unit B room 108', 'ICU');
insert into room values(109, 5, 'Unit C room 109', 'Operation room');
insert into room values(110, 5, 'Unit C room 110', 'Regular');
insert into room values(111, 5, 'Unit C room 110', 'ICU');

create table patient(pid int, pname varchar(20), gender int, DOB date, paddress varchar(50), pphone number, email varchar(30), primary key(pid));

insert into patient values ( 300,'David', 1, date'2000-01-01', '1000 hilltop circle, Baltimore, MD', 4101234444, 'david@gmail.com'); 
insert into patient values ( 301,'Carl',  1, date '1993-10-16', '1020 gateway blvd, Halethorpe, MD', 7164445555, 'carl@gmail.com');
insert into patient values ( 302,'Daisy', 2, date '1999-03-14', '2125 eldon green, Balitmore, MD', 9941234567, 'daisy@gmail.com'); 
insert into patient values ( 303,'Karen', 2, date '1996-03-31' ,'4700 maiden choice, Arbutus, MD', 9942345412, 'karen@gmail.com');
insert into patient values ( 304,'Michael', 1, date '1983-05-25', '3001 mount ridge, Baltimore, MD', 2164545454, 'michael@gmail.com');
insert into patient values ( 305,'Dwight', 1, date '1990-05-24', '2019 mount ridge, Baltimore, MD', 2164545459, 'dwight@gmail.com');

create table admission( aid int, pid int, hid int, did int, adm_date date, dis_date date, reason_adm varchar(40), dis_notes varchar(50), status int, primary key(aid), foreign key(pid) references patient, foreign key(hid) references hospital, foreign key(did) references doctor);

insert into admission values( 400, 300, 1, 200, date '2021-01-01', date '2021-01-01', 'High Fever', 'Patient was given anti viral prescription',3);
insert into admission values( 401, 301, 3, 201, date '2021-02-15', date '2021-02-21', 'Ankle Injury', 'Patient went through ankle surgery',3);
insert into admission values( 402, 302, 5, 203, date '2021-03-01', date '2021-03-15', 'Covid', 'Patient tested -ve post intesive care ',3);
insert into admission values( 403, 303, 5, 204, date '2021-04-04', date '2021-04-10', 'Pregnancy', 'Patient successful delivered a baby',3);
insert into admission values( 404, 304, 4, 202, date '2021-05-10', date '2021-05-10', 'Back Pain', 'Patient was given presciptions to cure back pain ',3);
insert into admission values( 405, 302, 5, 203, date '2021-05-11', null, 'Covid', null,1);



create table admission_room( aid int, hid int, rid int, room_start timestamp, room_end timestamp, primary key(aid,rid, room_start), foreign key(aid) references admission, foreign key(rid) references room );

insert into admission_room values( 400,1,101, timestamp '2021-01-01 10:00:00.00', timestamp '2021-01-01 16:00:00.00');
insert into admission_room values( 401,3, 107, timestamp '2021-02-15 10:00:00.00', timestamp '2021-02-21 16:00:00.00');
insert into admission_room values( 402,5, 109, timestamp '2021-03-01 10:00:00.00', timestamp '2021-04-01 16:00:00.00');
insert into admission_room values( 403,5, 109, timestamp '2021-04-04 10:00:00.00', timestamp '2021-04-10 16:00:00.00');
insert into admission_room values( 404,4, 108, timestamp '2021-05-10 10:00:00.00', timestamp '2021-05-10 16:00:00.00');
insert into admission_room values( 405,5, 110, timestamp '2021-05-10 10:00:00.00', timestamp '2021-05-10 16:00:00.00');


create table shift( sid int, nid int, rid int, sstime timestamp, setime timestamp, primary key(sid), foreign key(nid) references nurse, foreign key(rid) references room);

insert into shift values(500, 900, 101, timestamp '2021-01-01 08:00:00.00', timestamp '2021-01-01 20:00:00.00');
insert into shift values(501, 904, 107, timestamp '2021-02-15 08:00:00.00', timestamp '2021-02-15 21:00:00.00');
insert into shift values(507, 904, 107, timestamp '2021-02-16 08:00:00.00', timestamp '2021-02-16 21:00:00.00');
insert into shift values(508, 904, 107, timestamp '2021-02-17 08:00:00.00', timestamp '2021-02-17 21:00:00.00');
insert into shift values(509, 904, 107, timestamp '2021-02-18 08:00:00.00', timestamp '2021-02-18 21:00:00.00');
insert into shift values(510, 904, 107, timestamp '2021-02-19 08:00:00.00', timestamp '2021-02-19 21:00:00.00');
insert into shift values(511, 904, 107, timestamp '2021-02-20 08:00:00.00', timestamp '2021-02-20 21:00:00.00');
insert into shift values(512, 904, 107, timestamp '2021-02-21 08:00:00.00', timestamp '2021-02-21 21:00:00.00');
insert into shift values(502, 905, 109, timestamp '2021-03-01 10:00:00.00', timestamp '2021-03-01 22:00:00.00');
insert into shift values(503, 906, 109, timestamp '2021-04-04 09:00:00.00', timestamp '2021-04-04 20:00:00.00');
insert into shift values(504, 907, 108, timestamp '2021-05-10 08:00:00.00', timestamp '2021-05-10 18:00:00.00');
insert into shift values(505, 905, 110, timestamp '2021-05-10 09:30:00.00', timestamp '2021-05-10 21:30:00.00');
insert into shift values(506, 902, 102, timestamp '2021-01-01 11:00:00.00', timestamp '2021-01-01 16:30:00.00');



create table shift_room( sid int, rid int, primary key(sid,rid), foreign key(sid) references shift, foreign key(rid) references room);
insert into shift_room values(500, 101);
insert into shift_room values(501,107);
insert into shift_room values(502,109);
insert into shift_room values(503,109);
insert into shift_room values(504,108);
insert into shift_room values(505,110);
insert into shift_room values(506,102); 
insert into shift_room values(507,107);
insert into shift_room values(508,107);
insert into shift_room values(509,107);
insert into shift_room values(510,107);
insert into shift_room values(511,107);
insert into shift_room values(512,107);



create table treatment( tid int, tdescription varchar(30), primary key(tid));

insert into treatment values(600, 'Genral Checkup');
insert into treatment values(601, 'Orthopaedist');
insert into treatment values(602, 'Covid Treatment');
insert into treatment values(603, 'Obstetrics');
insert into treatment values(604, 'Skin Disease');


create table admission_treatment( tid int, aid int, tdate date, primary key(tid,tdate), foreign key(tid) references treatment, foreign key(aid) references admission);

Insert into admission_treatment values(600,400,date '2021-01-01');
Insert into admission_treatment values(601,401,date '2021-02-15');
Insert into admission_treatment values(602,402,date '2021-03-01');
Insert into admission_treatment values(603,403,date '2021-04-04');
Insert into admission_treatment values(601,404,date '2021-05-10');


create table drug( drid int, drname varchar(20), dose_value int, dose_per_day int, primary key(drid));

insert into drug values(700,'Mucinex',200,1);
insert into drug values(701,'Equate',500,2);
insert into drug values(702,'Advil',200,3);
insert into drug values(703,'Aleve',250,2);
insert into drug values(704,'Tylenol',300,1);


create table drug_allergy( pid int, drid int, primary key(pid, drid), foreign key(pid) references patient, foreign key(drid) references drug);

insert into drug_allergy values(301,701);
insert into drug_allergy values(302,702);
insert into drug_allergy values(303,703);
insert into drug_allergy values(304,704);
insert into drug_allergy values(304,703);

create table prescription(prid int, drid int, aid int, pdate date, no_of_days int, no_of_refills int, primary key(prid), foreign key(drid) references drug, foreign key(aid) references admission);


insert into prescription values(800,702,400,date '2021-01-01',3,2);
insert into prescription values(801,703,401,date '2021-02-15',7,1);
insert into prescription values(802,702,402,date '2021-03-01',5,2);
insert into prescription values(803,703,403,date '2021-04-04',3,1);
insert into prescription values(804,702,404,date '2021-05-10',5,1);

create table message( mid int, did int, pid int, mtime timestamp, mbody varchar(500), primary key(mid), foreign key(did) references doctor, foreign key(pid) references patient);

insert into message values( 1,200,300, timestamp '2021-01-01 10:15:00.00', 'Dr. Bansal: Patient David has been admitted to hospital Spring Grove');
insert into message values( 2,201,301, timestamp '2021-02-15 10:15:00.00', 'Dr. Bansal: Patient Carl has been admitted to hospital Saint Agnes');
insert into message values( 3,203,302, timestamp '2021-03-01 10:15:00.00', 'Dr. Ruffalo: Patient Daisy has been admitted to hospital Medstart Union');
insert into message values( 4,204,303, timestamp '2021-04-04 10:15:00.00', 'Dr. Ruffalo: Patient Karen has been admitted to hospital Northwest');
insert into message values( 5,202,304, timestamp '2021-05-10 10:15:00.00', 'Dr. Gomes: Patient Michael has been admitted to hospital Mercy');
insert into message values( 6,203,302, timestamp '2021-05-11 10:15:00.00', 'Dr. Gomes: Patient Daisy has been admitted to hospital Mercy');
commit;

-- Procedures

-- ADD_PATIENT

create or replace procedure add_patient( patient_name varchar, patient_gender char, date_of_birth date, address varchar, phone number, patient_email varchar)
as
patient_check integer; -- varible to hold record count for patient
begin
select count(*) into patient_check from patient where pname=patient_name and dob=date_of_birth;-- when o patient doesnt exists
if patient_check>0 then
update patient set paddress=address, pphone=phone,email=patient_email where pname=patient_name; -- updating the values for existing patient
dbms_output.put_line('Patient '||patient_name||' already exists');
else
insert into patient values(generate_patient.nextval,patient_name,patient_gender,date_of_birth,address,phone,patient_email);-- inserting new patient in case patient doesnt exists
dbms_output.put_line('New Patient has been added');
dbms_output.put_line('The newly assigned patient id for '||patient_name||' is: '||generate_patient.currval);
end if;
end;


-- ADMIT_PATIENT

create or replace procedure admit_patient(patient_name varchar, date_of_birth date, hospital_id integer, doctor_id integer, reason_of_visit varchar)
as
patient_check integer; -- varible to hold record count for patient
hospital_check integer; -- variable to hold record count for hospital
doctor_check integer; -- varible to hold record count for doctor
patient_id patient.pid%type; -- variable to hold pid value from patient table
doctor_name doctor.dname%type; -- variable to hold dname value from doctor table
hospital_name hospital.hname%type; -- variable to hold hname value from hospital table
admission_id admission.aid%type;
begin
select count(*) into patient_check from patient where pname=patient_name and dob=date_of_birth; -- when 0 patient doesnt exists
if patient_check=0 then
dbms_output.put_line('Patient '||patient_name||' does not exists. Please enter valid patient name.');
else
select count(*) into hospital_check from hospital where hid=hospital_id; --when 0 hospital doesnt exists
    if hospital_check=0 then
    dbms_output.put_line(' Hospital ID: '||hospital_id||' is not a valid ID. Please enter valid id.');
    else
    select count(*) into doctor_check from doctor_hospital where hid=hospital_id and did=doctor_id; -- when 0 doctor is not affiliated with the given hospital
        if doctor_check=0 then
        dbms_output.put_line(' There is no doctor with id: '||doctor_id||' affiliated with hospital with id: '||hospital_id);
        else
        select pid into patient_id from patient where pname=patient_name; -- storing patient id to the variable
        select dname into doctor_name from doctor where did=doctor_id; -- storing doctor name to the variable
        select hname into hospital_name from hospital where hid=hospital_id; -- storing hospital name to the variable
		select max(aid)+1 into admission_id from admission;
        insert into admission values(admission_id,patient_id,hospital_id,doctor_id,sysdate,NULL,reason_of_visit,NULL,1); -- inserting newly admitted patient
		dbms_output.put_line(' Patient '||patient_name||' has been admitted with admission id: '||admission_id);
        insert into message values(generate_message.nextval,doctor_id,patient_id,systimestamp,'Dr.'||doctor_name||' : Patient '||patient_name||' has been admitted into hospital '||hospital_name); -- inserting message for newly admitted patient
		end if;
	end if;
end if;
end;


-- ASSIGN_ROOM

create or replace procedure assign_room(a_id in integer, ss_time in timestamp, se_time in timestamp, r_type in varchar) is -- Admission id, room start and room end time as input
    
adm_id admission.aid%TYPE;
d_id admission.did%TYPE;
p_id admission.pid%TYPE;
h_id hospital.hid%TYPE;
p_name patient.pname%TYPE;
rm_id room.rid%TYPE;
loc room.location%TYPE;

begin

  select count(aid) into adm_id 
  from admission where aid = a_id;  -- Whether admission id is valid or not?
    if adm_id = 0 then
      dbms_output.put_line('Invalid admission id'); -- If not print an error message and stop
    else
      select hid into h_id from admission where aid = a_id; -- Obtaining hid for the given input admission id
        select min(rid) into rm_id 
        from room
        where hid = h_id and rid not in (select rid from admission_room where hid=h_id and room_start <= se_time and room_end >= ss_time) 
        and rtype = r_type; -- First available room with the input type that is not assigned for a time that overlaps with the start and end time 
          if rm_id is not null then
            select location into loc from room where rid=rm_id; -- Obtaining location for room id meeting requirements
              dbms_output.put_line('Room id ' || rm_id || ' for location ' || loc || ' is available.');
                insert into admission_room values(a_id,h_id,rm_id, ss_time,se_time); -- Inserting obtained values/inputs into an admission table
                  select did, admission.pid, pname into d_id, p_id, p_name
                  from admission, patient
                  where admission.pid = patient.pid and aid = a_id;
                    insert into message values(generate_message.nextval, d_id, p_id, systimestamp, 'Room ' || loc || ' has been assigned to Patient ' || p_name || 
                    ' from ' || ss_time || ' to ' || se_time || '.'); -- Inserting a message into the message table
                      update admission set status = 2 where aid = a_id; -- Updating status of an admission to room assigned
          else
            dbms_output.put_line('No rooms are available');     
          end if;    
    end if;  
end;


-- CONTACT_TRACING

create or replace procedure contact_tracing(patient_name in varchar, date_of_birth in date, patient_check_date date)
as

cursor c1 is select rid, room_start, room_end from admission_room ar, admission a, patient p where a.pid=p.pid and a.aid=ar.aid and pname=patient_name and dob=date_of_birth and adm_date <= patient_check_date  and dis_date >=patient_check_date; -- cursor to pull room details that patient was admitted to
patient_check integer; -- varible to hold record count for patient
patient_admission integer; -- variable to hold record count for patient admission on a given day
doctor_name doctor.dname%type; -- variable to hold doctor name
nurse_name nurse.nname%type;-- variable to hold nurse name
shift_start shift.sstime%type;-- variable to hold nurse shift start time
shift_end shift.setime%type;-- variable to hold nurse shift end time

begin

select count(*) into patient_check from patient where pname=patient_name and dob=date_of_birth; --when 0 patient doesnt exists
if patient_check=0 then
dbms_output.put_line('Patient doesnt exists'); 
else
    select count(*)into patient_admission from patient p, admission a where a.pid=p.pid and pname=patient_name and dob=date_of_birth and adm_date <= patient_check_date  and dis_date >=patient_check_date; -- when 0 patient was not under admission on that day
    if patient_admission=0 then
    dbms_output.put_line('This patient is not in hospital on: '||to_char(patient_check_date, 'YYYY-MM-DD'));
    else
        select dname into doctor_name from doctor d, admission a, patient p where a.pid=p.pid and a.did=d.did and pname=patient_name and dob=date_of_birth and adm_date <= patient_check_date  and dis_date >=patient_check_date; -- doctor who treated the patient
        dbms_output.put_line('Doctor '||doctor_name||' was assigned to patient '||patient_name||' during his visit.');
        dbms_output.new_line;
		dbms_output.put_line('During his admission patient '||patient_name||' was admitted to rooms with id: ');
        for r in c1 loop
        dbms_output.put_line('    - '||r.rid||' from '||r.room_start||' to '|| r.room_end);
        end loop;
        dbms_output.new_line;
        dbms_output.put_line('Details of the nurse/nurses along with shift timings are: ');
        for r in c1 loop
        select nname, sstime, setime into nurse_name, shift_start, shift_end from shift_room sr, shift s, nurse n where sr.sid=s.sid and s.nid=n.nid and s.rid=r.rid and sstime <=r.room_end and setime>=r.room_start ; -- nurse details who were working in the room that patient was assigned
        dbms_output.put_line('     - '||nurse_name||' ,'||shift_start||' ,'||shift_end);
        end loop;
    end if;
end if;
exception when no_data_found then
dbms_output.put_line('Shift statistics are not correctly inserted');
end;  


-- DISCHARGE_PATIENT

create or replace procedure discharge_patient(a_id in int, disdate in date, disnote in varchar)
As
    acount int;
    d_did int;
    p_pid int;
    msg message.mbody%type;
    tr_id int;
    trdr treatment.tdescription%type;
    trdate date;
Cursor C1 is select atr.tid, t.tdescription, atr.tdate from admission a, treatment t, admission_treatment atr 
        where a.aid=a_id and a.aid=atr.aid and atr.tid=t.tid;
Cursor C2 is select d.drname,d.dose_value, d.dose_per_day,p.aid,p.no_of_days,p.no_of_refills
       from drug d, prescription p where p.aid=a_id and p.drid=d.drid;

Begin
    select count(*) into acount from admission where aid=a_id;
    if acount = 0 then
        dbms_output.put_line('Invalid Admission ID');
    else
        dbms_output.put_line('Success 1');
        select did, pid into d_did, p_pid from admission where aid=a_id;
        update admission set dis_date=disdate, dis_notes=disnote, status=3 where aid=a_id;
        msg:=('Patient discharged on' || disdate);
        insert into message values(GENERATE_MESSAGE.nextval,d_did,p_pid,CURRENT_TIMESTAMP,msg);
        dbms_output.put_line('List of Treatment as follows:');
        for r in C1 loop
                dbms_output.put_line('Treatment with ID: '||r.tid ||' and description: ' || r.tdescription || ' was recieved on: '|| r.tdate);
        end loop; 
        dbms_output.put_line('List of Presciption as follows:');
        for j in C2 loop
                dbms_output.put_line('During admission patient with admission id: '||a_id||' received drug: '||j.drname ||' having dose value: ' || j.dose_value || ' with dose per day as: '|| j.dose_per_day  || ' for: '|| j.no_of_days || ' days with refill of: '|| j.no_of_refills);
        end Loop;

    end if;  

End;


-- DRUGALLERGY

create or replace Procedure drugAllergy(p_id in int, drugs in phoneListType)
    As
    pcount int;
    dcount int;
    ccount int;
Begin
    select count(*) into pcount from patient where pid=p_id;
    if pcount=0 then                             --to validate patient ID
        dbms_output.put_line('Please provide a valid patient ID');
    else
        --dbms_output.put_line('Success 1');
        for i in 1..drugs.count loop                -- loop to get all drugs
            --dbms_output.put_line(drugs(i));
            select count(*) into dcount from drug where drid=drugs(i);
            if dcount=0 then                        --to validate drug id
                dbms_output.put_line(drugs(i)|| ' is invalid drug id' );
            else
                --dbms_output.put_line('Success 2 for ' || drugs(i));
                select count(*) into ccount from drug_allergy where drid=drugs(i) and pid=p_id;
                if ccount > 0 then                  --to validate if pair of drug and patient id is available
                    dbms_output.put_line('Pair Already available for ' || drugs(i));
                else
                   dbms_output.put_line('Allergy to ' || drugs(i) || ' recorded');
                   insert into drug_allergy values(p_id,drugs(i));  -- to insert row into drug allergy table
                end if;
            end if;
        end loop; 
    end if;
    Exception WHEN OTHERS THEN
            dbms_output.put_line('Unidentified Error please check logs or Please provide correct input details');
End;


-- NURSE_PATIENT_DETAILS

create or replace procedure nurse_patient_details(n_id in int, curtime in timestamp)
As
    ncount int;
    Cursor C1 is select s.rid, r.location, p.pname from patient p, room r, admission a, shift s, admission_room ar
    where a.aid=ar.aid and ar.rid=r.rid and a.pid=p.pid and r.rid=s.rid and s.nid=n_id 
    and s.setime >=curtime and s.sstime<=curtime;

Begin
    select count(*) into ncount from nurse where nid=n_id;
    if ncount = 0 then
        dbms_output.put_line('Invalid Nurse ID');
    else
        dbms_output.put_line('Success 1');
        select count(*) into ncount from Shift where nid=n_id and setime>=curtime   
        and sstime<=curtime;
        if ncount=0 then
            dbms_output.put_line('The nurse is not working at given time');
        else
            dbms_output.put_line('Success 2');
            for r in C1 loop
                dbms_output.put_line('Room Details:'|| r.rid ||' ^^ '||r.location || ' ^^ ' || r.pname);
            end loop;
        end if;
    end if;
End;


-- PESCRIBE_A_DRUG

create or replace PROCEDURE  Prescribe_a_Drug(Drud_Id in number, Admission_Id in number, 
Date_of_Prescription in date, No_of_Days_take_Drug in number, No_of_Refills in number)
as
--variable declaration
Count_Drug_Id number;  -- varible to hold record count for drugids
Count_Admission_Id number; --  varible to hold record count for admissions
Patient_Name varchar(30);  --  varible to hold record of the patient names
Drug_Name varchar(30);  --  varible to hold record of the drug names
Patient_Id number; --  varible to hold record of the patient id.
message varchar(120); --  varible to hold record of the message content
Doctor_id number; --  varible to hold record of the doctor id
patient_allergy_check number; --  varible to hold record count for patients who are having allergy

begin
select count(*) into Count_Drug_Id from Drug where DRID=Drud_Id; -- Checks whether the drug id is valid or not.

if Count_Drug_Id = 0 then 
dbms_output.put_line('Invalid Drug Id');
else
	dbms_output.put_line('Drug Id is valid');
	select count(*) into Count_Admission_Id from Admission where AID=Admission_Id; -- Checks whether the admission id is valid or not.
	if Count_Admission_Id = 0 then 
	dbms_output.put_line('Invalid Admission Id');
	else
		dbms_output.put_line('Admission Id is valid');

--select patient.pid into Patient_Id from patient, admission where patient.pid = admission.pid and admission.aid = Admission_Id;
        --select patient.pname, drug.drname into Patient_Name, Drug_Name from patient,drug_allergy,drug
           -- where drug_allergy.drid = drug.drid and drug_allergy.pid = patient.pid and drug_allergy.drid = Drud_Id and drug_allergy.pid = Patient_Id; 
        select pname into Patient_Name from admission a, patient p where a.pid=p.pid and a.aid= Admission_Id;
		select count(*) into patient_allergy_check from drug_allergy d, admission a where d.pid=a.pid and d.drid=Drud_Id and a.aid=Admission_Id; --Checks whether the corresponding patient is allergic to this drug.

		if patient_allergy_check <> 0 then
        select drname into Drug_Name from Drug where drid = Drud_Id;
		dbms_output.put_line('Patient '|| Patient_Name || ' is allergic to ' || Drug_Name || '  , choose another drug');
		else 

			dbms_output.put_line('No Allergy');
--dbms_output.put_line('Patient '|| Patient_Name || ' is not allergic to ' || Drug_Name);
--dbms_output.put_line('After If statement');

			insert into prescription values(prid_sequence.nextval, Drud_Id, Admission_Id, Date_of_Prescription, No_of_Days_take_Drug, No_of_Refills); --If no allergy, inserting a row into the prescription table.
            dbms_output.put_line(' Presciption is added for the patient');

			select drname into Drug_Name from Drug where drid = Drud_Id;
			message := 'A new prescription of ' || Drug_Name || ' is created for ' || Patient_Name;

			select pid,did into Patient_Id, Doctor_id  from admission where aid = Admission_Id;

			insert into message values(generate_message.nextval,Doctor_id,Patient_Id,systimestamp,message);--Inserting a row into the message table.
		     dbms_output.put_line('Message is added to the message table');
        end if;
	end if;
end if;
end;

-- READMISSION_STATS

create or replace procedure readmission_stats(readmission in interval day to second)
is

patient1 varchar(20);
admission1 integer;
patient2 varchar(20);
admission2 integer;
p_count integer;
a_count integer;
admit_date1 date;
admit_date2 date;
res_adm1 varchar(50);
res_adm2 varchar(50);
discharge_date1 date;
discharge_date2 date;
total_admission integer;
readmission_rate float;
hos_name varchar(20);

cursor c1 is select p.pname as patient, a1.hid, a1.aid as admission1, a2.aid as admission2 
from admission a1, hospital h, patient p, admission a2 
where h.hid=a1.hid and h.hid=a2.hid and a1.pid = p.pid and a2.pid = p.pid and a1.aid<>a2.aid and a1.dis_date < a2.adm_date and a1.dis_date <  a2.adm_date + readmission;

begin

select count(*) into p_count 
from admission a1, admission a2, hospital h, patient p 
where h.hid=a1.hid and h.hid=a2.hid and a1.pid=p.pid and a2.pid=p.pid and a1.aid<>a2.aid and a1.dis_date < a2.adm_date and a1.dis_date <  a2.adm_date + readmission;
-- selects all those patients with pair of admissions and the gap between previous admission's discharge date and next admission's admit date is less than the input interval
if p_count > 0 then -- if such details are found (if count is greater than 0)
  for r in c1 loop
    select adm_date, dis_date, reason_adm into admit_date1, discharge_date1, res_adm1 from admission where aid=r.admission1 and hid=r.hid;
      select adm_date, dis_date, reason_adm into admit_date2, discharge_date2, res_adm2 from admission where aid=r.admission2 and hid=r.hid;
        if discharge_date1 < admit_date2 then
          dbms_output.put_line('Patient name: '|| r.patient || chr(10) || 'Admit admission id: ' ||r.admission1 || chr(10) || 'Readmit admission id: ' || r.admission2 || chr(10) || 'Admit discharge date: ' || discharge_date1 || chr(10) || 'Readmit admission date: ' ||admit_date2 || chr(10) || 'Admit reason: ' ||res_adm1 || chr(10) || 'Readmit reason: ' ||res_adm2); -- print out discharge date of first admission and admit date of second admission and reasons for each admission along with patient name
        else
          dbms_output.put_line('Patient name: '|| r.patient || chr(10) || 'Admit admission id: ' ||r.admission1 || chr(10) || 'Readmit admission id: ' || r.admission2 || chr(10) || 'Admit discharge date: ' || discharge_date2 || chr(10) || 'Readmit admission date: ' ||admit_date1 || chr(10) || 'Admit reason: ' ||res_adm1 || chr(10) || 'Readmit reason: ' ||res_adm2); -- print out discharge date of first admission and admit date of second admission and reasons for each admission along with patient name
        end if;
if c1%notfound then
  dbms_output.put_line('No data exists');  -- if no data is retrieved
end if;
    select hname, count(aid) into hos_name, total_admission from admission a, hospital h where a.hid=h.hid and a.hid=r.hid group by hname;
      readmission_rate := p_count / total_admission; -- computing readmission rate as fraction of patients identified 
        dbms_output.put_line('Hospital: '||hos_name||' has occupancy rate of: '||readmission_rate || chr(10)); -- Printing out name of hospital and readmission rate
end loop;
end if;
  exception when no_data_found then
    dbms_output.put_line('No data exists');
end;


-- ROOM_STATISTICS

create or replace procedure room_statistics ( start_date in date, end_date in date, hospital_id in integer)
as
hospital_check  integer;
total_days integer;
start_time timestamp;
end_time timestamp;
no_of_admission integer;
room_id integer;
room_location varchar(20);
room_type varchar(20);
loop_start_date date;
occupancy_rate float;
no_of_days_counted integer;
cursor_count integer;
cursor c1 is select r.rid from admission_room ar, room r where ar.rid=r.rid and r.hid=hospital_id;
begin
loop_start_date:=start_date;
no_of_days_counted:= end_date - start_date;
total_days:=0;
--dbms_output.put_line(' No of days between start date and end date: ' ||no_of_days_counted);
select count(*) into hospital_check from hospital where hid=hospital_id; --checks whether the hospital ID is valid or not.
if hospital_check=0 then
dbms_output.put_line('Invalid Hospital Id');
else
    select count(r.rid) into cursor_count from admission_room ar, room r where ar.rid=r.rid and r.hid=hospital_id; --checks whether the room is assigned to at least one patient during that day.
    if cursor_count=0 then
    dbms_output.put_line('No admission room booked for the hospital between: '||start_date||' and '||end_date);
    else
	for r in c1 loop
		while loop_start_date <=end_date loop
		start_time:=to_timestamp(loop_start_date);
		end_time:=to_timestamp(loop_start_date) + interval '0 23:59:00.00' day to second;
		select count(*) into no_of_admission from admission_room where rid=r.rid and room_start<=end_time and room_end>=start_time ; --total number of days the room is assigned to the patient is checked 
			if no_of_admission>0 then
			total_days:=total_days + 1;
			else
                dbms_output.put_line('No admits on: '||to_char(loop_start_date, 'YYYY-MM-DD'));
            end if;
		loop_start_date:=loop_start_date + interval'1'day;
		end loop;
	select rid, location, rtype into room_id, room_location, room_type from room where rid=r.rid;
	occupancy_rate:=(total_days/(end_date-start_date)); --occupancy rate is calculated.
		if occupancy_rate <>0 then
            dbms_output.put_line('The occupancy rate of room '|| room_id|| ' of type '|| room_type||' location ' || room_location||' is: '|| occupancy_rate); --Printing room location, room type, and occupancy rate for each room in that hospital. 
		end if;
   end loop;
  end if;
end if;
exception when no_data_found then
dbms_output.put_line('no data exists');
when others then
dbms_output.put_line('!!!!start date and end date should not be the same !!!');
end;


-- SHIFT_STATISTICS

create or replace procedure shift_statistics(hospital_id in integer, start_date in date, end_date in date)
as
h_count integer;
start_time timestamp;
end_time timestamp;
no_of_hrs integer;
nod integer;
avg_hours float;
nurse_name varchar(20);
no_of_nurses integer;
avg_of_all float;
Total_Avg float;
loop_start_date date;
shift_start timestamp;
shift_end timestamp;
no_of_hours integer;
loop_check integer;
cursor C1 is select distinct n.nname from nurse n, shift s  
where s.nid=n.nid and hid=hospital_id and trunc(sstime)<=end_date and trunc(setime)>=start_date;
--cursor C2 is select n.nname, sstime, setime from nurse n, shift s  where s.nid=n.nid 
--and hid=hospital_id and trunc(sstime)<=end_date and trunc(setime)>=start_date order by n.nname asc;
begin
no_of_nurses:=0;
avg_of_all:=0;
no_of_hrs:=0;
no_of_hours:=0;
Total_Avg:=0;
nod:=end_date-start_date; --- no of days
select count(*) into h_count from hospital where hid=hospital_id;
if h_count=0 then
dbms_output.put_line('Invalid Hospital ID');
else

		for r in C1 loop
        avg_hours:=0;
        no_of_hours:=0;
        loop_start_date:=start_date;
		while loop_start_date <=end_date loop
			select count(*) into loop_check from shift s, nurse n 
            where n.nid=s.nid and nname=r.nname and trunc(sstime)=loop_start_date ;
			if loop_check=0 then
			dbms_output.put('');
			else
			select sstime, setime into shift_start , shift_end from shift s, nurse n 
            where n.nid=s.nid and nname=r.nname and trunc(sstime)=loop_start_date ;
			start_time:=to_timestamp(loop_start_date) + interval '0 8:00:00.00' day to second;
			end_time:=to_timestamp(end_date) + interval '0 8:00:00.00' day to second;

			if shift_start <start_time then

				if shift_end >end_time then
					no_of_hrs:=extract(day from(end_time - start_time))*24 + extract(hour from (end_time - start_time)) + extract(minute from(end_time - start_time))/60;
    				else
					no_of_hrs:=extract(day from(shift_end - start_time))*24 + extract(hour from (shift_end - start_time)) + extract(minute from(shift_end - start_time))/60;
                    end if;
			else
				if shift_end >end_time then
					no_of_hrs:=extract(day from(end_time - shift_start))*24 + extract(hour from (end_time - shift_start)) + extract(minute from(end_time - shift_start))/60;
                else
					no_of_hrs:=extract(day from(shift_end - shift_start))*24 + extract(hour from (shift_end - shift_start)) + extract(minute from(shift_end - shift_start))/60;
                end if;
			end if; 
            no_of_hours:=no_of_hours+ no_of_hrs;
        end if;
		loop_start_date:=loop_start_date + interval '1' day;
		end loop;
        avg_hours:=(no_of_hours)/nod;
        no_of_nurses:=no_of_nurses + 1;
        Total_Avg:=total_avg + avg_hours;
        avg_of_all:=total_avg/no_of_nurses;
		dbms_output.put_line('Nurse '||r.nname||' has avg working hours as '||avg_hours||'hrs');
		end loop;
dbms_output.put_line('Total avg is of all nurses is '||avg_of_all||'hrs');
end if;
end;


-- TREATEMENT_TO_PATIENT

create or replace procedure treatmentToPatient(AdmsId in int, TrtmntId in int, TrtmntDate in date)
    As
    AdmsCount int;
    TrtmntCount int;
    pName patient.pname%type;
    tdetail treatment.tdescription%type;
    d_did int;
    p_pid int;
    msg varchar(200);
Begin
    select count(*) into AdmsCount from admission where aid=AdmsId;
    if AdmsCount=0 then                             --to check addmition Id is valid
        dbms_output.put_line('Please provide valid admission ID for Patient');
    else
        --dbms_output.put_line('Success 1');
        select count(*)  into TrtmntCount from treatment where tid=TrtmntId;
        if TrtmntCount = 0 then                     --to check treatment Id is valid
            dbms_output.put_line('Please provide valid treatment ID for patient');
        else
            --dbms_output.put_line('Success 2');
            insert into admission_treatment values(TrtmntId, AdmsId, TrtmntDate); -- to add new row in to addmission_treatment table
            select p.pname, a.did, p.pid into pName, d_did, p_pid from admission a,patient p    
                    where a.pid=p.pid and a.aid=AdmsId;                            -- to get details from addmission and patient table
            select tdescription into tdetail from treatment where tid=TrtmntId;     --to get description details from treatment table
            dbms_output.put_line('Patient '|| pName || ' received treatment ' ||tdetail || ' on ' ||TrtmntDate);
            msg:= 'Patient '|| pName || ' received treatment ' ||tdetail || ' on ' ||TrtmntDate;
            insert into message values(GENERATE_MESSAGE.nextval,d_did,p_pid,CURRENT_TIMESTAMP,msg);     -- to insert row into message table
        end if;
    end if;
    Exception WHEN OTHERS THEN
            dbms_output.put_line('Unidentified Error please check logs or Please provide correct input details');
End;


-- Exec statements

--Feature 1--
-- patient exists, updating personal details
exec add_patient('Dwight',1,date '1990-05-24', '2019 mount ridge, Baltimore, MD',2164545459,'dwight@gmail.com');

--new patient, record inserted
exec add_patient('Ron',1,date '1995-10-24', '2019 Hogwarts Ville, Wilkens Ave, MD',1234123412,'ron@gmail.com');

--Feature 2--
-- invalid patient id
exec admit_patient('Rahul',date'2021-01-01',1,1,'general checkup'); 

-- patient exists but hospital id is not valid
exec admit_patient('Ron',date'1995-10-24',10,200,'general checkup');

-- doctor is not affiliated with the given hospital
exec admit_patient('Ron',date'1995-10-24',1,202,'general checkup'); 

-- patient admitted
exec admit_patient('Ron',date'1995-10-24',1,200,'general checkup');


---Feature 3:
dbms_output.put_line('Invalid admission ID use case');
exec assign_room(450, timestamp '2021-05-10 12:00:00.0', timestamp '2021-05-10 07:00:00.0', 'Regular');
select * from admission;
/
dbms_output.put_line('No rooms available');
exec assign_room(401, timestamp '2021-02-15 10:00:00.0', timestamp '2021-05-10 07:00:00.0', 'Operation room');
select * from admission_room;
select * from admission;
select * from room;
/
dbms_output.put_line('Positive Scenario use case');
exec assign_room(405, timestamp '2021-05-10 12:00:00.0', timestamp '2021-05-10 07:00:00.0', 'Regular');
select * from admission_room;
select * from admission;
select * from message;
/

---Feature 4---
dbms_output.put_line('Positive Scenario use case');
exec treatmentToPatient(401, 602, date '2021-11-4');
select * from message;
select * from admission_treatment;
/
dbms_output.put_line('Invalid admission ID use case');
exec treatmentToPatient(300, 602, date '2021-11-1'); 
/
dbms_output.put_line('Invalid treatment ID use case');
exec treatmentToPatient(401, 500, date '2021-11-1'); 


/
---Feature 5--
dbms_output.put_line('--------------------------------------------------------------------------');
dbms_output.put_line('Invalid patient use case');
exec drugAllergy(299,phonelisttype(701,600,18506));
/
dbms_output.put_line('--------------------------------------------------------------------------');
dbms_output.put_line('Positive Scenario use case with one invalid drug id');
exec drugAllergy(303,phonelisttype(701,702,18506));
select * from drug_allergy;
/
dbms_output.put_line('--------------------------------------------------------------------------');
dbms_output.put_line('Positive Scenario use case with one already available pair');
exec drugAllergy(302,phonelisttype(701,702,703));
select * from drug_allergy;

/
-- Feature 6--
dbms_output.put_line('Case 1');
exec Prescribe_a_Drug(710,401,date '2021-11-1',5,2);
dbms_output.put_line('--------------------------------------------------------------------------------------------');
/
dbms_output.put_line('Case 2');
exec Prescribe_a_Drug(700,410,date '2021-11-1',5,2);
dbms_output.put_line('--------------------------------------------------------------------------------------------');
/
dbms_output.put_line('Case 3');
exec Prescribe_a_Drug(701,401,date '2021-11-1',7,1);
dbms_output.put_line('--------------------------------------------------------------------------------------------');
/
dbms_output.put_line('Case 4');
exec Prescribe_a_Drug(704,400,date '2021-11-1',7,1);
select * from prescription;
select * from message;
dbms_output.put_line('--------------------------------------------------------------------------------------------');


--Feature 7--
exec nurse_patient_details(10000,timestamp '2022-10-4 10:00:00.00');
/
exec nurse_patient_details(900,timestamp '2021-01-01 8:00:00.00');
/
exec nurse_patient_details(900,timestamp '2022-01-01 8:00:00.00');

--Feature 8 --
--Invalid admission ID
exec discharge_patient(399,Date '2021-12-13','Patient is well' );
/
-- Positive use case
exec discharge_patient(402,Date '2021-12-13','Patient is well' );

/
---Group feature 9 ---
exec contact_tracing('Mike',date'2000-01-01',date'2021-02-01'); 

exec contact_tracing('David',date'2000-01-01',date'2021-02-01');

exec contact_tracing('David',date'2000-01-01',date'2021-01-01');

--Group feature 10--
dbms_output.put_line('Case 1 invalid hospital id');
exec room_statistics ( date '2021-02-15', date '2021-02-21', 6); 
dbms_output.put_line('--------------------------------------------------------------------------------------------');
dbms_output.put_line('Case 2 no rooms occupied in given duration');
exec room_statistics ( date '2021-02-15', date '2021-02-21', 5);
dbms_output.put_line('--------------------------------------------------------------------------------------------');
dbms_output.put_line('Case 3 Positive');
exec room_statistics ( date '2021-01-01', date '2021-01-10', 1);
dbms_output.put_line('--------------------------------------------------------------------------------------------');
end;

/
--Group Feature 11--

dbms_output.put_line('Invalid Hospital use case');
exec shift_statistics(10, date '2021-03-01', date '2021-03-10');
/
dbms_output.put_line('Positive use case with one shift');
exec shift_statistics(5, date '2021-03-01', date '2021-03-02');
/
dbms_output.put_line('Positive use case with multiple shifts');
exec shift_statistics(3, date '2021-02-15', date '2021-02-24');
/
dbms_output.put_line('Positive use case with multiple shifts');
exec shift_statistics(5, date '2021-03-01', date '2021-03-08');
/

--Group Feature 12:
dbms_output.put_line('Valid interval time');
exec readmission_stats(interval '3 11:09:08.555' day to second);
/
exec readmission_stats(interval '0 00:00:00.000' day to second);