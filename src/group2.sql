create table Customers (customer_id number(10) primary key, customer_name varchar2(20), gender char(1), phone_number number(12), address varchar2(30), email varchar(35));
alter table Customers add constraint gender_constraint check(gender in ('M', 'F', 'O'));
alter table Customers modify gender char(1) not null;

create table Loan (loan_id number(10) primary key, loan_type varchar2(15));

create table Loan_Application (Application_number number(10) primary key, customer_id number(10) references Customers(customer_id), l_id number(10) references Loan(loan_id), amount number(10), status varchar2(12),
constraint status_constraint check(status in ('Approved', 'Not Approved')));
alter table loan_application add constraint stat_constraint check(status in ('Approved', 'Not Approved','Waiting'));
alter table loan_application modify app_date date default sysdate;
alter table loan_application modify  date default sysdate;
alter table loan_application add constraint verification_status_constraint check(verification_status in ('verified','not verified'));
alter table loan_application modify verification_status varchar2(20) default 'not verified';


create table Documents (application_number number(10) references Loan_Application(Application_number), docs BLOB);

desc Customers;

alter table loan_application modify status varchar2(12) default 'Not Approved';

insert into Loan values(1, 'Car Loan');
insert into Loan values(2, 'Gold Loan');
insert into Loan values(3, 'Home Loan');
insert into Loan values(4, 'Vehicle Loan');
insert into Loan values(5, 'Property Loan');




select * from loan;

delete loan where loan_id=5;
create sequence c_sq1pk;
------------------------------------------------------------------------------------
create or replace procedure insert_customers(
p_c_name CUSTOMERS.CUSTOMER_NAME%type,
p_gender CUSTOMERS.GENDER%type,
p_pno CUSTOMERS.PHONE_NUMBER%type,
p_addr CUSTOMERS.ADDRESS%type,
p_email CUSTOMERS.EMAIL%type
)
as 
begin
insert into customers
values (c_sq1pk.nextval,upper(p_c_name) ,upper(p_gender) ,p_pno ,upper(p_addr) ,p_email );
end;
----------------------------------------------------------------------------------
create sequence app_num_sq1pk;

create sequence app_num
start with 1000000
increment by 1;
-----------------------------------------------------------------------------------
create or replace procedure insert_app(
p_cid LOAN_APPLICATION.CUSTOMER_ID%type,
p_lid LOAN_APPLICATION.L_ID%type,
p_amnt LOAN_APPLICATION.AMOUNT%type)
--p_stat LOAN_APPLICATION.STATUS%type,
--p_adate date)
as 
begin
insert into LOAN_APPLICATION(application_number,customer_id,l_id,amount)
values (app_numpk.nextval,p_cid,p_lid, p_amnt) ;
end;
---------------------------------------------------------------------------
create sequence app_numpk
start with 1000000
increment by 1;

---------------------------------------------------------------------------
create or replace procedure display(
v_appno loan_application%rowtype
)
as 
begin
select * from loan_application into v_appno where status='Not Approved';
end;
----------------------------------------------------------------------------------
----3
select * from loan_application where status='Not Approved';

select * from loan_application where status='Approved';

select * from loan_application where status='Waiting';

create view manager as 
select application_number,status,verification_status
from loan_application;

select application_number,status,verification_status
from loan_application;

update loan_application 
set verification_status='verified';

update loan_application 
set verification_status='not verified', status='Not Approved'
where application_number=2;
 
select *
from customers natural join loan_application;

select *
from loan natural join loan_application;


insert into documents values(2,'pan card');
insert into documents values(1000000,'pan card');
insert into documents values(1000001,'aadhaar');

select l.customer_id, l.verification_status from loan_application l, documents d where d.application_number=l.application_number; 
