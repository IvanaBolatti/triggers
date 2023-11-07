CREATE SCHEMA biblioteca;
USE biblioteca;

CREATE TABLE nacionalidad(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(40) NOT NULL
);

INSERT INTO nacionalidad VALUES 
(NULL,"argentino"),
(NULL,"brasilero"),
(NULL,"peruano"),
(NULL,"mexicano");

CREATE TABLE autor(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id),
	fecha_nacim DATE NOT NULL
);

CREATE TABLE NEW_AUTOR(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id),
    fecha_nacim DATE NOT NULL
);

CREATE TABLE NEW_AUTOR_MAYOR(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id)
);

CREATE TRIGGER alta_autor
AFTER INSERT ON autor
FOR EACH ROW
INSERT INTO NEW_AUTOR (id, nombre, id_nacionalidad, fecha_nacim) VALUES (NEW.id, NEW.nombre, NEW.id_nacionalidad, NEW.fecha_nacim);

DELIMITER //
CREATE TRIGGER verificar_edad_autor
BEFORE INSERT ON autor
FOR EACH ROW
BEGIN
if  (YEAR('1987/12/13')< 2000) then
 INSERT INTO NEW_AUTOR_MAYOR (id, nombre, id_nacionalidad) VALUES (NEW.id, NEW.nombre, NEW.id_nacionalidad);
end if;
END //

INSERT INTO autor VALUES 
(NULL,"Juan Carlos", 2, '1987/12/13'),
(NULL,"Pedro Alfonso", 1, '1978/02/17'),
(NULL,"Raúl Perez", 2, '1987/08/06'),
(NULL,"Roberto Segura", 4, '1984/07/30'),
(NULL,"Romina Moyano", 1, '1967/05/13'),
(NULL,"Teresa Perez", 3, '971/09/14');


select * from autor;
select * from NEW_AUTOR;
select * from NEW_AUTOR_MAYOR;
