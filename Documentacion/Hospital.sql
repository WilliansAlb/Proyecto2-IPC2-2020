CREATE SCHEMA IF NOT EXISTS Hospital;

USE Hospital;

CREATE TABLE IF NOT EXISTS Usuario(
	id VARCHAR(15) NOT NULL,
	codigo VARCHAR(15) NOT NULL,
   	password VARCHAR(50) NOT NULL,
	tipo VARCHAR(15) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS Administrador(
	codigo VARCHAR(15) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	dpi VARCHAR(13) NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS Consulta(
	codigo INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	costo DECIMAL(12,2) NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS Dia(
	codigo INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(10) NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS Medico(
	codigo VARCHAR(15) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	no_colegiado VARCHAR(10) NOT NULL,
	dpi VARCHAR(13) NOT NULL,
	horario VARCHAR(20) NOT NULL,
	email VARCHAR(50) NULL,
	fecha_inicio DATE NOT NULL,
	telefono VARCHAR(8) NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS Paciente(
	codigo VARCHAR(15) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	sexo VARCHAR(10) NOT NULL,
	peso DECIMAL(10,2) NOT NULL,
	dpi VARCHAR(13) NOT NULL,
	sangre VARCHAR(10) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	email VARCHAR(50) NULL,
	telefono VARCHAR(8) NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS Examen(
	codigo VARCHAR(15) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	orden TINYINT(1) NOT NULL,
	costo DECIMAL(12,2) NOT NULL,
	informe VARCHAR(10) NOT NULL,
	descripcion TEXT NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS Laboratorista(
	codigo VARCHAR(15) NOT NULL,
	examen VARCHAR(15) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	no_registro VARCHAR(15) NOT NULL,
	dpi VARCHAR(13) NOT NULL,
	telefono VARCHAR(8) NOT NULL,
	fecha_inicio DATE NOT NULL,
	email VARCHAR(50) NULL,
	PRIMARY KEY(codigo),
	FOREIGN KEY(examen) REFERENCES Examen(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Especialidad(
	codigo INT NOT NULL AUTO_INCREMENT,
	consulta INT NOT NULL,
	medico VARCHAR(15) NOT NULL,
	PRIMARY KEY(codigo),
	FOREIGN KEY(consulta) REFERENCES Consulta(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(medico) REFERENCES Medico(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Trabajo(
	codigo INT NOT NULL AUTO_INCREMENT,
	laboratorista VARCHAR(15) NOT NULL,
	dia INT NOT NULL,
	PRIMARY KEY(codigo),
	FOREIGN KEY(laboratorista) REFERENCES Laboratorista(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(dia) REFERENCES Dia(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Cita(
	codigo VARCHAR(15) NOT NULL,
	medico VARCHAR(15) NOT NULL,
	paciente VARCHAR(15) NOT NULL,
	fecha DATE NOT NULL,
	consulta INT NULL,
	hora INT NOT NULL,
	realizada TINYINT(1) NULL DEFAULT false,
	PRIMARY KEY(codigo),
	FOREIGN KEY(medico) REFERENCES Medico(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(paciente) REFERENCES Paciente(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Reporte(
	codigo VARCHAR(15) NOT NULL,
	medico VARCHAR(15) NOT NULL,
	paciente VARCHAR(15) NOT NULL,
	fecha DATE NOT NULL,
	informe TEXT NOT NULL,
	hora INT NOT NULL,
	PRIMARY KEY(codigo),
	FOREIGN KEY(medico) REFERENCES Medico(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(paciente) REFERENCES Paciente(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Resultado(
	codigo VARCHAR(15) NOT NULL,
	paciente VARCHAR(15) NOT NULL,
	examen VARCHAR(15) NOT NULL,
	laboratorista VARCHAR(15) NOT NULL,
	fecha DATE NOT NULL,
	orden MEDIUMBLOB NULL,
	hora INT NOT NULL,
	informe MEDIUMBLOB NULL,
	realizado TINYINT(1) NULL DEFAULT false,
	medico VARCHAR(15) NULL,
	PRIMARY KEY(codigo),
	FOREIGN KEY(paciente) REFERENCES Paciente(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(examen) REFERENCES Examen(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(laboratorista) REFERENCES Laboratorista(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Dia(nombre) VALUES('Lunes');
INSERT INTO Dia(nombre) VALUES('Martes');
INSERT INTO Dia(nombre) VALUES('Miercoles');
INSERT INTO Dia(nombre) VALUES('Jueves');
INSERT INTO Dia(nombre) VALUES('Viernes');
INSERT INTO Dia(nombre) VALUES('Sabado');
INSERT INTO Dia(nombre) VALUES('Domingo');

