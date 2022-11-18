drop table if exists student cascade;
create table student(id serial primary key, name varchar);

drop table if exists book cascade;
create table book(id serial primary key, title varchar);

drop table if exists booksample cascade;
create table booksample(id serial primary key, state varchar, lendable varchar, location varchar, book_id int references book(id));

drop table if exists lend cascade;
create table lend(student_id int references student(id), booksample_id int references booksample(id), at date,returned_at date);

--Servidor Paris--
drop table if exists booksample_paris cascade;
create table booksample_paris(check(location='paris')) inherits(booksample);

drop table if exists lend_paris cascade;
create table if not exists lend_paris() inherits(lend);	

--Servidor Lagos--
drop table if exists booksample_lagos cascade;
create table booksample_lagos(id int, state varchar, lendable bool default false, location varchar, book_id int);

drop table if exists lend_lagos cascade;
create table lend_lagos(student_id int, booksample_id int, at date, returned_at date);

--Servidor Mexico--
drop table if exists booksample_mexico cascade;
create table booksample_lagos(id int, state varchar, lendable bool default false, location varchar, book_id int);

drop table if exists lend_mexico cascade;
create table lend_lagos(student_id int, booksample_id int, at date, returned_at date);
















insert into student values(default,'Juan'),(default, 'Maria'),(default,'Pedro'),
			  (default,'Marta'),(default,'Jaime'),(default,'Priscila'),
			  (default,'Jorge'),(default,'Elena'),(default,'Luis'),(default,'Laura');
	
insert into book values(default,' Romeo y Julieta'),(default, 'Don Quijote de la Mancha'),
		       (default,'Cien años de soledad'),(default,'El laberinto de la soledad'),
		       (default,'De animales a dioses'),(default,'Vida inteligente en el universo'),
		       (default,'Las trampas de la fe'),(default,'La evolución de las especies'),
		       (default,'Principia Mathematica'), (default,'Crítica de la razón pura');
		       
insert into booksample values(default,'new','true','paris',1),(default,'used','false','lagos',2),
		       (default,'used','false','paris',3),(default,'used','false','lagos',4),
		       (default,'new','true','paris',5),(default,'new','true','lagos',6),
		       (default,'used','false','paris',7),(default,'used','true','lagos',8),
		       (default,'used','true','paris',9), (default,'used','false','lagos',10);		       
			  
insert into lend values(1,1,'14/02/20','02/03/20'),
		       (2,1,'17/05/21','27/05/21'),
		       (3,1,'12/05/20','22/05/20'),
		       (4,2,'27/10/22','13/11/22'),
		       (5,2,'17/06/19','03/07/19'),
		       (6,3,'23/08/22','06/09/22'),
		       (7,3,'11/11/21','24/11/21'),
		       (8,4,'27/09/21','08/10/21'),
		       (9,4,'02/06/21','17/06/21'),
		       (10,4,'31/03/21','07/04/21'),
		       (1,4,'25/12/20','05/01/21'),
		       (2,5,'20/09/22','01/10/22'),
		       (3,5,'11/01/19','30/01/19'),
		       (4,6,'06/06/21','26/06/21'),
		       (5,6,'12/10/20','02/11/20'),
		       (6,7,'18/05/20','08/06/20'),
		       (7,7,'03/09/20','11/09/20'),
		       (8,8,'08/12/20','20/12/20'),
		       (9,8,'27/11/22','14/12/22'),
		       (10,9,'02/09/21','11/09/21'),
		       (8,9,'07/10/20','18/10/20'),
		       (4,10,'02/08/19','24/08/19'),
		       (2,10,'07/11/20','30/11/20'),
		       (7,10,'11/03/22','31/03/22'),
		       (9,10,'16/04/22','07/05/22'),
		       (3,10,'09/05/22','19/05/22'),
		       (2,10,'19/10/20','06/11/20');
		



create extension postgres_fdw;

create server master_server foreign data wrapper postgres_fdw options (host '132.18.53.24', port '5432' , dbname 'dd_test');

create user mapping for postgres server master_server options (user 'postgres', password 'fany');

alter server master_server owner to master_user;


-- Servidor Paris--

--lagos--
drop foreign table if exists booksample_lagos cascade;
create foreign table booksample_lagos (check(location='lagos')) inherits(booksample) server master_server;
drop foreign table if exists lend_lagos cascade;
create foreign table lend_lagos () inherits(lend) server master_server;
--mexico--

-- trigger on insert booksample
create or replace function booksample_trigger_fn() returns trigger as
$$
begin

    if new.location = 'paris' then
       insert into booksample_paris values(new.*);
    else if new.location = 'lagos' then
              insert into booksample_lagos values(new.*);
         else if new.location = 'mexico' then
         	insert into booksample_mexico values(new.*);
    end if;

    return null;
end
$$
language plpgsql;

drop trigger if exists booksample_trigger on booksample;  
create trigger booksample_trigger before insert on booksample for each row execute procedure booksample_trigger_fn(); 



create or replace function lend_trigger_fn() returns trigger as 
$$
declare
    vbooksample booksample%rowtype;
begin
    -- select the booksample referenced by the booksample_id
    select * into vbooksample from booksample where id=new.booksample_id;

    -- get the location to use and save the row
    if vbooksample.location = 'paris' then
        insert into lend_paris values(new.*);
    else if vbooksample.location = 'lagos' then
        insert into lend_lagos values(new.*);
        else if vbooksample.location = 'mexico' then
         	insert into booksample_mexico values(new.*);
    end if;

    return null;
end
$$
language plpgsql;

drop trigger if exists lend_trigger on lend;  
create trigger lend_trigger before insert on lend for each row execute procedure lend_trigger_fn();






