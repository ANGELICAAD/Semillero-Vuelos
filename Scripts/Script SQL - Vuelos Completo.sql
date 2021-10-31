CREATE TABLE `aerolinea` (
  `idAerolinea` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(70) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idAerolinea`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `aeropuerto` (
  `idAeropuerto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `pais` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `ciudad` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(70) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idAeropuerto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `aeropuerto_avion` (
  `idAeropuerto_Avion` int NOT NULL AUTO_INCREMENT,
  `idAeropuerto` int NOT NULL,
  `idAvion` int NOT NULL,
  PRIMARY KEY (`idAeropuerto_Avion`),
  KEY `fk_AeAvAeropuerto_idx` (`idAeropuerto`),
  KEY `fk_AeAvAvion_idx` (`idAvion`),
  CONSTRAINT `fk_AeAvAeropuerto` FOREIGN KEY (`idAeropuerto`) REFERENCES `aeropuerto` (`idAeropuerto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_AeAvAvion` FOREIGN KEY (`idAvion`) REFERENCES `avion` (`idAvion`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `avion` (
  `idAvion` int NOT NULL AUTO_INCREMENT,
  `modelo` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `capacidad` int NOT NULL,
  `idAerolinea` int NOT NULL,
  PRIMARY KEY (`idAvion`),
  KEY `fk_AvionAerolinea` (`idAerolinea`),
  CONSTRAINT `fk_AvionAerolinea` FOREIGN KEY (`idAerolinea`) REFERENCES `aerolinea` (`idAerolinea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `pasajero` (
  `idPasajero` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `direccion` varchar(70) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idPasajero`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `ruta` (
  `idRuta` int NOT NULL AUTO_INCREMENT,
  `origen` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `destino` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `fechaSalida` date NOT NULL,
  `fechaLlegada` date NOT NULL,
  `horaSalida` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `horaLlegada` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `idAeropuerto` int NOT NULL,
  `idVuelo` int NOT NULL,
  PRIMARY KEY (`idRuta`),
  KEY `fk_RutaAeropuerto_idx` (`idAeropuerto`),
  KEY `fk_RutaVuelo_idx` (`idVuelo`),
  CONSTRAINT `fk_RutaAeropuerto` FOREIGN KEY (`idAeropuerto`) REFERENCES `aeropuerto` (`idAeropuerto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_RutaVuelo` FOREIGN KEY (`idVuelo`) REFERENCES `vuelo` (`idVuelo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `ticket` (
  `idTicket` int NOT NULL AUTO_INCREMENT,
  `costo` double NOT NULL,
  `asiento` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `clase` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `fechaCompra` date NOT NULL,
  `horaCompra` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `idVuelo` int NOT NULL,
  `idPasajero` int NOT NULL,
  PRIMARY KEY (`idTicket`),
  KEY `fk_TicketVuelo_idx` (`idVuelo`),
  KEY `fk_TicketPasajero_idx` (`idPasajero`),
  CONSTRAINT `fk_TicketPasajero` FOREIGN KEY (`idPasajero`) REFERENCES `pasajero` (`idPasajero`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_TicketVuelo` FOREIGN KEY (`idVuelo`) REFERENCES `vuelo` (`idVuelo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `tripulacion` (
  `idTripulacion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `idVuelo` int NOT NULL,
  PRIMARY KEY (`idTripulacion`),
  KEY `fk_TripulacionVuelo_idx` (`idVuelo`),
  CONSTRAINT `fk_TripulacionVuelo` FOREIGN KEY (`idVuelo`) REFERENCES `vuelo` (`idVuelo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

CREATE TABLE `vuelo` (
  `idVuelo` int NOT NULL AUTO_INCREMENT,
  `numeroVuelo` int NOT NULL,
  `fecha` date NOT NULL,
  `idAvion` int NOT NULL,
  PRIMARY KEY (`idVuelo`),
  KEY `fk_VueloAvion_idx` (`idAvion`),
  CONSTRAINT `fk_VueloAvion` FOREIGN KEY (`idAvion`) REFERENCES `avion` (`idAvion`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish_ci;

show columns from aerolinea;
select * from aerolinea;

insert into aerolinea(nombre, direccion, telefono) values ('Avianca','Av. Cl. 26 # 59-15, Bogotá','5877700'), ('Easyfly','Av. El Dorado # 103-08, Bogotá','4148111'), ('LATAM Airlines','Cl. 26 # 103-09, Bogotá','7452020'), ('American Airlines','Cr. 69 # 25-44, Bogotá','4397700'), ('Air Europa','Cl. 92 # 11-51, Bogotá','7433232'), ('Viva Air','Cr. 21 # 8-82, Bogotá','7433999');

show columns from aeropuerto;
select * from aeropuerto;

insert into aeropuerto(nombre, pais, ciudad, direccion) values ('El Dorado','Colombia','Bogotá','Av. Cl. 26 # 103-9'), ('Matecaña','Colombia','Pereira','Km. 4 Vía Cerritos'), ('Olaya Herrera','Colombia','Medellín','Cr. 65 # 13-157'), ('Alfonso Bonilla Aragon','Colombia','Cali','Valle del Cauca');

show columns from avion;
select * from avion;

insert into avion(modelo, capacidad, idAerolinea) values ('Airbus A321-200',220,1), ('Airbus A330-200',252,1), ('Boeing 737-800',189,5), ('Airbus A320-200',180,3), ('Boeing 787-9',290,4), ('ATR 42-500',48,2);

show columns from aeropuerto_avion;
select * from aeropuerto_avion;

insert into aeropuerto_avion(idAeropuerto, idAvion) values (3,1), (1,3), (2,3), (4,4), (1,5), (3,6);

show columns from vuelo;
select * from vuelo;

insert into vuelo(numeroVuelo, fecha, idAvion) values (3652,'2021-11-05',1), (5478,'2021-11-10',2), (4277,'2021-11-21',3), (2347,'2021-11-01',4), (3628,'2021-11-15',5), (1853,'2021-11-24',6);

show columns from pasajero;
select * from pasajero;

insert into pasajero(nombre, identificacion, fechaNacimiento, direccion, telefono, email) values ('Camila Rodrigez','109748822','1997-04-23','Calle 23 # 4','3115836993','crodigez@gmail.com'), ('Hector Fabian Gonzalez','112837893','1995-10-03','Carrera 10 # 23-05','3102482784','hfgonzalez@gmail.com'), ('Jhon Faber Grisales','109374825','1999-09-15','Calle 15 # 56-34','3124743894','jfgrisales@gmail.com'), ('Juliana Hernandez','113859023','1994-11-19','Calle 20 # 65-23','3152874562','jhernandez@gmail.com'), ('Liliana Ramirez','111284773','1996-06-20','Carrera 10 # 34-26','3113732957','lramirez@gmail.com'), ('Natalia Giraldo','102648232','1991-12-08','Carrera 9 # 23-76','3182873943','ngiraldo@gmail.com'), ('Alexander Ramos','113846829','1991-04-26','Carrera 10 # 65-34','3102763794','aramos@gmail.com');

show columns from tripulacion;
select * from tripulacion;

insert into tripulacion(nombre, apellido, identificacion, email, tipo, idVuelo) values ('Andrés','Hernandez','143893752','ahernandez@gmail.com','Piloto',1), ('Juan Camilo','Arias','106370744','jcarias@gmail.com','Copiloto',1), ('María Camila','García','109937483','mcgarcia@gmail.com','Azafata',1), ('Juliana','Montes','113748735','jmontes@gmail.com','Azafata',1), ('Luisa','Herrera','112385638','lherrera@gmail.com','Azafata',2), ('Felipe','Gomez','109378556','fgomez@gmail.com','Azafata',6), ('Mariana','Diaz','109766284','mdiaz@gmail.com','Azafata',3), ('Steven','Quintero','112575992','squintero@gmail.com','Azafata',2);

show columns from ticket;
select * from ticket;

insert into ticket(costo, asiento, clase, fechaCompra, horaCompra, idVuelo, idPasajero) values (117000,'23','Ejecutivo','2021-10-23','14:00',1,1), ('117000','14','Economica','2021-10-03','15:00',1,2), (6300000,'76','Ejecutivo','2021-10-14','14:30',3,5), (6300000,'26','Economica','2021-10-28','08:00',3,4), (420000,'42','Ejecutivo','2021-10-02','10:00',5,3), (360000,'55','Ejecutivo','2021-10-17','16:00',6,6);

show columns from ruta;
select * from ruta;

insert into ruta(origen, destino, fechaSalida, fechaLlegada, horaSalida, horaLlegada, idAeropuerto, idVuelo) values('Medellín','Bogotá','2021-11-05','2021-11-05','10:00','11:10',3,1), ('Bogotá','Manizales','2021-11-10','2021-11-10','14:00','15:00',1,2), ('Pereira','Madrid','2021-11-21','2021-11-22','08:00','01:00',2,3), ('Cali','Armenia','2021-11-01','2021-11-01','17:00','21:00',4,4), ('Bogotá','New York','2021-11-15','2021-11-15','15:30','21:30',1,5), ('Medellín','Pereira','2021-11-24','2021-11-24','09:30','10:20',3,6);