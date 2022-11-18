create database suneo;

create table libros_catalogo(id_libro serial primary key, titulo varchar, autor varchar);

create table libros_ejemplares(id_ejemplar serial primary key, id_libro int references libros_catalogo(id_libro), condicion_fisica varchar, pertenece_a varchar);

create table alumnos(matricula , nombre_completo, universidad);
PRESTAMOS: (PK) id_prestamo, (FK) id_ejemplar, (FK) matricula, fecha_prestamo,
fecha_devolucion_asignada, fecha_devolucion_real
