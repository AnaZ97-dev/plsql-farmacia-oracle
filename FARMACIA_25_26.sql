alter session set nls_date_format = 'DD/MM/YYYY';

-- Tabla de EMPLEADO
CREATE TABLE EMPLEADO (
    cod_empleado NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(100),
    salarioBase DECIMAL(10,2),
    fechaAlta DATE,
    emp_gerente NUMBER(4),
    CONSTRAINT fk_empleado_emp_ger FOREIGN KEY (emp_gerente) REFERENCES EMPLEADO(cod_empleado) ON DELETE CASCADE
);

-- Tabla de CLIENTE
CREATE TABLE CLIENTE (
    Codigo NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(100),
    mutualista CHAR(1)  -- 'S' o 'N'
);

-- Tabla de HABITUAL
CREATE TABLE HABITUAL (
    Codigo NUMBER PRIMARY KEY,
    nif VARCHAR2(20),
    Direccion VARCHAR2(255),
    CONSTRAINT fk_habitual_cliente FOREIGN KEY (Codigo) REFERENCES CLIENTE(Codigo) ON DELETE CASCADE
);

-- Tabla de DE_PASO
CREATE TABLE DE_PASO (
    Codigo NUMBER(5) PRIMARY KEY,
    DeLaUE CHAR(1), -- 'S' o 'N'
    CONSTRAINT fk_depaso_cliente FOREIGN KEY (Codigo) REFERENCES CLIENTE(Codigo) ON DELETE CASCADE 
);

-- Tabla de PROVEEDOR
CREATE TABLE PROVEEDOR (
    cod_proveedor NUMBER(5) PRIMARY KEY,
    CIF VARCHAR2(20),
    nombre VARCHAR2(100),
    Direccion VARCHAR2(255),
    TLFono VARCHAR2(20)
);

-- Tabla de MEDICAMENTO
CREATE TABLE MEDICAMENTO (
    Codigo NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(100),
    tipo VARCHAR2(50),
    posolog�a VARCHAR2(1000),
    stock NUMBER(5),
    precioCompra DECIMAL(10,2),
    pvp DECIMAL(10,2),
    unidades_vendidas NUMBER(5) DEFAULT 0
);

-- Tabla de VENTA
CREATE TABLE VENTA (
    id_venta NUMBER(5) PRIMARY KEY,
    fecha_hora TIMESTAMP,
    cod_empleado NUMBER(5),
    Codigo_cliente NUMBER(5),
    CONSTRAINT fk_venta_empleado FOREIGN KEY (cod_empleado) REFERENCES EMPLEADO(cod_empleado) ON DELETE CASCADE,
    CONSTRAINT fk_venta_cliente FOREIGN KEY (Codigo_cliente) REFERENCES CLIENTE(Codigo) ON DELETE CASCADE
);

-- Tabla de DETALLE
CREATE TABLE DETALLE (
    id_venta NUMBER(5),
    Codigo_medicamento NUMBER(5),
    unidades NUMBER(5),
    CONSTRAINT pk_detalle PRIMARY KEY (id_venta, Codigo_medicamento),
    CONSTRAINT fk_detalle_venta FOREIGN KEY (id_venta) REFERENCES VENTA(id_venta) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_medicamento FOREIGN KEY (Codigo_medicamento) REFERENCES MEDICAMENTO(Codigo) ON DELETE CASCADE
);

-- Tabla de COMPRAR
CREATE TABLE COMPRAR (
    cod_proveedor NUMBER(5),
    Codigo_medicamento NUMBER(5),
    fecha DATE,
    cantidad NUMBER(5),
    CONSTRAINT pk_comprar PRIMARY KEY (cod_proveedor, Codigo_medicamento, fecha),
    CONSTRAINT fk_comprar_proveedor FOREIGN KEY (cod_proveedor) REFERENCES PROVEEDOR(cod_proveedor) ON DELETE CASCADE,
    CONSTRAINT fk_comprar_medicamento FOREIGN KEY (Codigo_medicamento) REFERENCES MEDICAMENTO(Codigo) ON DELETE  CASCADE
);

-- Insertar empleados
INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente) 
VALUES (1, 'Laura Jim�nez', 2000.00, '15/01/1996', NULL);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente) 
VALUES (2, 'Mar�a', 2000.00, '15/01/1996', 1);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente) 
VALUES (3, 'Antonio', 1500.00, '01/06/1998', 1);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (4, 'Mar�a', 1800.00, '15/03/2000', 2);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (5, 'Luis', 1300.00, '20/11/2002', 2);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (6, 'Carmen', 1750.00, '12/07/2005', 2);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (7, 'Javier', 1200.00, '08/01/2017', 2);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (8, 'Elena', 1600.00, '25/09/2010', 3);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (9, 'Pedro', 2100.00, '30/04/2012', 3);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (10, 'Luc�a', 1400.00, '19/08/2015', 3);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (11, 'Ra�l', 1550.00, '03/12/2017', 3);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (12, 'Beatriz', 1950.00, '27/05/2019', 4);

INSERT INTO EMPLEADO (cod_empleado, nombre, salarioBase, fechaAlta, emp_gerente)
VALUES (13, 'Sergio', 1250.00, '11/10/2021', 4);


-- Insertar clientes
INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1001, 'Ana Morales', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1002, 'DESCONOCIDO', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1003, 'Luc�a Mart�nez', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1004, 'Carlos G�mez', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1005, 'Beatriz Fern�ndez', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1006, 'Ra�l L�pez', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1007, 'Elena Rodr�guez', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1008, 'Javier Torres', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1009, 'Patricia S�nchez', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1010, 'Miguel Castro', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1011, 'Laura Dom�nguez', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1012, 'Diego Navarro', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1013, 'Isabel Romero', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1014, 'Pedro Herrera', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1015, 'Sara Morales', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1016, 'Manuel Vega', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1017, 'Carmen Ruiz', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1018, 'Andr�s Ortega', 'N');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1019, 'Nuria Gil', 'S');

INSERT INTO CLIENTE (Codigo, nombre, mutualista) 
VALUES (1020, 'Tom�s Pe�a', 'N');


-- Insertar clientes habituales
INSERT INTO HABITUAL (Codigo, nif, Direccion) 
VALUES (1001, '12345678A', 'Calle del Sol 12');

INSERT INTO HABITUAL (Codigo, nif, Direccion) 
VALUES (1003, '87654321B', 'Avenida Luna 45');

INSERT INTO HABITUAL (Codigo, nif , Direccion) 
VALUES (1004, '88999111V', 'Avenida Carlos III 23');

-- Insertar clientes de paso
INSERT INTO DE_PASO (Codigo, DeLaUE) VALUES
(1002, 'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1005, 'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1006, 'N');

INSERT INTO DE_PASO (Codigo, DeLaUE)
 VALUES  (1007,  'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1008,  'N');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1009, 'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES  (1010,  'N');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1011,  'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1012, 'N');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1013,  'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1014,  'N');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1015, 'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1016, 'N');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1017,  'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1018, 'N');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1019, 'S');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1020,  'N');

INSERT INTO DE_PASO (Codigo, DeLaUE) 
VALUES (1004,  'N');

-- Insertar proveedores
INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(201, 'A11223344', 'PharmaDistribuciones', 'Pol�gono Industrial 5', '912345678') ;
INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(202, 'B55667788', 'Medicor S.A.', 'Calle Norte 27', '987654321');
INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(203, 'A11223344', 'Farmac�utica del Sur S.L.', 'Avenida del Sol 15', '912345678');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(204, 'B99887766', 'Laboratorios Vida S.A.', 'Calle Mayor 102', '934567890');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(205, 'C44556677', 'Distribuciones M�dicas L�pez', 'Pol�gono Industrial Las Nieves, Nave 12', '956123789');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(206, 'D33445566', 'Salud Integral S.L.', 'Camino de la Salud 45', '982345671');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(207, 'E22334455', 'Equipos Cl�nicos Ram�rez', 'Calle del R�o 23', '913456782');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(208, 'F66778899', 'Proveedora Hospitalaria Central', 'Avenida Andaluc�a 78', '965432187');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(209, 'G77889900', 'Material Quir�rgico Ib�rico', 'Calle Serrano 130', '944555333');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(210, 'H88990011', 'Suministros M�dicos del Norte', 'Paseo de la Castellana 250', '911223344');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(211, 'J99001122', 'Laboratorios Rivera S.A.', 'Calle Esperanza 8', '958741236');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(212, 'K10111213', 'Hospital Supply S.L.', 'Calle Jardines 19', '972664455');

INSERT INTO PROVEEDOR (cod_proveedor, CIF, nombre, Direccion, TLFono) VALUES
(213, 'L01478522', 'Medicatem, S.L', 'Avd. de la Paz, 20', '950852963');

-- Insertar medicamentos
INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(301, 'Ibuprofeno 400mg', 'Analg�sico', 'Tomar 1 cada 8 horas', 100, 0.30, 0.75) ;
INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(302, 'Paracetamol 500mg', 'Antit�rmico', 'Tomar 1 cada 6 horas', 150, 0.25, 0.65) ;
INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(303, 'Omeprazol 20mg', 'Protector g�strico', 'Tomar 1 antes del desayuno', 80, 0.40, 1.00);
INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(304, 'Paracetamol 500mg', 'Analg�sico', 'Tomar 1 cada 8 horas si hay dolor o fiebre', 150, 0.25, 0.80);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(305, 'Ibuprofeno 400mg', 'Antiinflamatorio', 'Tomar 1 cada 8 horas despu�s de las comidas', 200, 0.30, 0.90);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(306, 'Amoxicilina 500mg', 'Antibi�tico', 'Tomar 1 cada 8 horas durante 7 d�as', 120, 0.45, 1.20);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(307, 'Loratadina 10mg', 'Antihistam�nico', 'Tomar 1 al d�a', 90, 0.35, 1.00);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(308, 'Metformina 850mg', 'Antidiab�tico', 'Tomar 1 con el desayuno y la cena', 110, 0.50, 1.30);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(309, 'Simvastatina 20mg', 'Reductor de colesterol', 'Tomar 1 por la noche', 75, 0.60, 1.50);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(310, 'Losart�n 50mg', 'Antihipertensivo', 'Tomar 1 al d�a', 95, 0.55, 1.40);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(311, 'Diazepam 5mg', 'Ansiol�tico', 'Tomar 1 cada 12 horas si es necesario', 65, 0.40, 1.10);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(312, 'Cetirizina 10mg', 'Antial�rgico', 'Tomar 1 al d�a', 100, 0.28, 0.90);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(313, 'Salbutamol Inhalador', 'Broncodilatador', 'Inhalar 1-2 dosis cuando sea necesario', 50, 1.20, 2.50);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(314, 'Clopidogrel 75mg', 'Antiplaquetario', 'Tomar 1 al d�a', 85, 0.70, 1.80);

INSERT INTO MEDICAMENTO (Codigo, nombre, tipo, posolog�a, stock, precioCompra, pvp) VALUES
(315, 'Ranitidina 150mg', 'Anti�cido', 'Tomar 1 cada 12 horas', 70, 0.33, 0.95);


-- Insertar compras (proveedor surte medicamentos)
INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(201, 301, '01/03/2025',3) ;
INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(202, 302, '10/03/2025',2) ;
INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(201, 303, '15/03/2025',6);
INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(201, 311, '09/01/2025',7);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(208, 313, '01/07/2025',4);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(206, 313, '02/10/2025', 10);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(204, 308, '24/01/2025',20);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(212, 305, '01/09/2025',15);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(203, 313, '30/11/2025',25);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(208, 308, '03/12/2024',30);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(210, 310, '23/04/2024',10);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(207, 308, '03/12/2025',15);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(201, 311, '01/05/2025',10);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(204, 311, '22/01/2024',15);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(202, 306, '15/03/2024',20);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(202, 309, '19/01/2025',25);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(205, 304, '12/04/2024',12);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(202, 309, '27/09/2024',10);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(209, 314, '07/01/2025',15);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(207, 308, '03/10/2024',20);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(211, 315, '11/07/2024',23);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(205, 312, '09/11/2024',15);

INSERT INTO COMPRAR (cod_proveedor, Codigo_medicamento, fecha, cantidad) VALUES
(208, 313, '26/03/2025',10);


-- Insertar ventas
INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(401, TO_DATE ('27/04/2025 10:15', 'DD-MM-YYYY HH24:MI'), 2, 1001);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(402, TO_DATE ('27/04/2025 11:30', 'DD-MM-YYYY HH24:MI'), 2, 1002) ;

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(403, TO_DATE ('25/05/2025 19:30', 'DD-MM-YYYY HH24:MI'), 5, 1002);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(404, TO_DATE ('25/11/2025 20:45', 'DD-MM-YYYY HH24:MI'), 6, 1001);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(405, TO_DATE ('04/10/2025 18:15', 'DD-MM-YYYY HH24:MI'), 8, 1019);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(406, TO_DATE ('26/07/2025 20:30', 'DD-MM-YYYY HH24:MI'), 13, 1007);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(407, TO_DATE ('08/01/2025 10:30', 'DD-MM-YYYY HH24:MI'), 5, 1015);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(408, TO_DATE ('28/01/2025 09:15', 'DD-MM-YYYY HH24:MI'), 9, 1004);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(409, TO_DATE ('01/01/2025 11:15', 'DD-MM-YYYY HH24:MI'), 3, 1002);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(410, TO_DATE ('07/09/2025 10:15', 'DD-MM-YYYY HH24:MI'), 4, 1009);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(411, TO_DATE ('11/04/2025 19:15', 'DD-MM-YYYY HH24:MI'), 10, 1013);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(412, TO_DATE ('18/07/2025 13:30', 'DD-MM-YYYY HH24:MI'), 7, 1019);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(413, TO_DATE ('28/01/2025 12:30', 'DD-MM-YYYY HH24:MI'), 13, 1018);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(414, TO_DATE ('20/08/2025 17:30', 'DD-MM-YYYY HH24:MI'), 7, 1020);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(415, TO_DATE ('20/04/2025 15:00', 'DD-MM-YYYY HH24:MI'), 8, 1008);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(416, TO_DATE ('28/05/2025 13:15', 'DD-MM-YYYY HH24:MI'), 7, 1001);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(417, TO_DATE ('10/11/2025 19:45', 'DD-MM-YYYY HH24:MI'), 6, 1009);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(418, TO_DATE ('25/09/2025 20:30', 'DD-MM-YYYY HH24:MI'), 9, 1009);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(419, TO_DATE ('08/09/2025 18:00', 'DD-MM-YYYY HH24:MI'), 10, 1008);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(420, TO_DATE ('05/10/2025 13:30', 'DD-MM-YYYY HH24:MI'), 13, 1018);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(421, TO_DATE ('28/07/2025 11:00', 'DD-MM-YYYY HH24:MI'), 7, 1010);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(422, TO_DATE ('18/05/2025 17:15', 'DD-MM-YYYY HH24:MI'), 12, 1016);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(423, TO_DATE ('13/04/2025 10:00', 'DD-MM-YYYY HH24:MI'), 7, 1005);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(424, TO_DATE ('14/11/2025 11:00', 'DD-MM-YYYY HH24:MI'), 5, 1011);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(425, TO_DATE ('18/05/2025 10:00', 'DD-MM-YYYY HH24:MI'), 11, 1003);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(426, TO_DATE ('05/04/2025 14:45', 'DD-MM-YYYY HH24:MI'), 12, 1007);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(427, TO_DATE ('18/06/2025 17:00', 'DD-MM-YYYY HH24:MI'), 7, 1014);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(428, TO_DATE ('23/06/2025 08:15', 'DD-MM-YYYY HH24:MI'), 5, 1008);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(429, TO_DATE ('24/04/2025 16:30', 'DD-MM-YYYY HH24:MI'), 10, 1002);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(430, TO_DATE ('26/01/2025 14:30', 'DD-MM-YYYY HH24:MI'), 5, 1014);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(431, TO_DATE ('31/05/2025 18:30', 'DD-MM-YYYY HH24:MI'), 4, 1004);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(432, TO_DATE ('07/06/2025 13:45', 'DD-MM-YYYY HH24:MI'), 10, 1015);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(433, TO_DATE ('18/11/2025 09:45', 'DD-MM-YYYY HH24:MI'), 9, 1010);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(434, TO_DATE ('03/11/2025 13:00', 'DD-MM-YYYY HH24:MI'), 4, 1004);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(435, TO_DATE ('17/08/2025 10:30', 'DD-MM-YYYY HH24:MI'), 12, 1015);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(436, TO_DATE ('24/02/2025 17:45', 'DD-MM-YYYY HH24:MI'), 5, 1010);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(437, TO_DATE ('01/05/2025 13:30', 'DD-MM-YYYY HH24:MI'), 12, 1006);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(438, TO_DATE ('28/11/2025 13:30', 'DD-MM-YYYY HH24:MI'), 8, 1016);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(439, TO_DATE ('11/06/2025 19:30', 'DD-MM-YYYY HH24:MI'), 6, 1013);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(440, TO_DATE ('16/06/2025 20:00', 'DD-MM-YYYY HH24:MI'), 10, 1008);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(441, TO_DATE ('15/10/2025 18:30', 'DD-MM-YYYY HH24:MI'), 13, 1007);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(442, TO_DATE ('30/05/2025 08:15', 'DD-MM-YYYY HH24:MI'), 7, 1012);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(443, TO_DATE ('03/09/2025 14:45', 'DD-MM-YYYY HH24:MI'), 7, 1015);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(444, TO_DATE ('02/07/2025 09:45', 'DD-MM-YYYY HH24:MI'), 8, 1011);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(445, TO_DATE ('26/02/2025 20:30', 'DD-MM-YYYY HH24:MI'), 10, 1009);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(446, TO_DATE ('18/02/2025 18:30', 'DD-MM-YYYY HH24:MI'), 10, 1011);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(447, TO_DATE ('19/06/2025 13:30', 'DD-MM-YYYY HH24:MI'), 4, 1008);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(448, TO_DATE ('18/03/2025 09:15', 'DD-MM-YYYY HH24:MI'), 8, 1009);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(449, TO_DATE ('05/04/2025 8:30', 'DD-MM-YYYY HH24:MI'), 11, 1005);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(450, TO_DATE ('11/12/2025 12:00', 'DD-MM-YYYY HH24:MI'), 11, 1003);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(451, TO_DATE ('18/04/2025 16:00', 'DD-MM-YYYY HH24:MI'), 5, 1016);

INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) VALUES
(452, TO_DATE ('12/05/2025 08:15', 'DD-MM-YYYY HH24:MI'), 11, 1015);

-- Insertar detalles de ventas (qu� medicamentos vendieron en cada venta)
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES
(401, 301, 2) ;
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES
(401, 302, 1) ;
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES
(402, 302, 3) ;
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES
(403, 303, 1);

INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (403, 304, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (403, 308, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (404, 305, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (404, 312, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (405, 309, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (405, 307, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (406, 303, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (406, 311, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (407, 306, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (407, 313, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (408, 310, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (408, 312, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (409, 315, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (409, 308, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (410, 307, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (410, 304, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (411, 311, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (411, 306, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (412, 309, 5);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (412, 314, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (413, 303, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (413, 305, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (414, 307, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (414, 312, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (415, 308, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (415, 310, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (416, 306, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (416, 315, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (417, 311, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (417, 304, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (418, 305, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (418, 309, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (419, 308, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (419, 312, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (420, 307, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (420, 313, 5);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (421, 303, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (421, 310, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (422, 315, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (422, 304, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (423, 306, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (423, 311, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (424, 308, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (424, 307, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (425, 309, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (425, 312, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (426, 303, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (426, 314, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (427, 310, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (427, 305, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (428, 311, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (428, 308, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (429, 307, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (429, 306, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (430, 309, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (430, 312, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (431, 303, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (431, 315, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (432, 310, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (432, 304, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (433, 305, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (433, 308, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (434, 307, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (434, 311, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (435, 306, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (435, 309, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (436, 312, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (436, 314, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (437, 303, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (437, 310, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (438, 311, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (438, 308, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (439, 307, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (439, 306, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (440, 309, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (440, 312, 5);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (441, 303, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (441, 314, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (442, 310, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (442, 305, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (443, 311, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (443, 308, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (444, 307, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (444, 306, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (445, 309, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (445, 312, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (446, 303, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (446, 315, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (447, 310, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (447, 304, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (448, 305, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (448, 308, 4);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (449, 307, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (449, 311, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (450, 306, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (450, 309, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (451, 312, 1);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (451, 314, 2);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (452, 303, 3);
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) VALUES (452, 310, 2);