
PRAGMA foreign_keys = ON;

-- TABLA DE PROPIETARIOS
CREATE TABLE IF NOT EXISTS owners (
    owner_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    created_at DATE DEFAULT CURRENT_DATE
);

-- TABLA DE BARCOS
CREATE TABLE IF NOT EXISTS boats (
    boat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    length REAL NOT NULL CHECK(length > 0),
    owner_id INTEGER NOT NULL,
    status TEXT DEFAULT 'active' CHECK(status IN ('active', 'maintenance')),
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);

-- TABLA DE MUELLES
CREATE TABLE IF NOT EXISTS berths (
    berth_id INTEGER PRIMARY KEY AUTOINCREMENT,
    location TEXT NOT NULL UNIQUE,
    max_length REAL NOT NULL CHECK(max_length > 0),
    status TEXT DEFAULT 'available' CHECK(status IN ('available', 'occupied'))
);

-- TABLA DE SERVICIOS
CREATE TABLE IF NOT EXISTS services (
    service_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL NOT NULL CHECK(price > 0)
);

-- INSERTAR DATOS EN OWNERS
INSERT INTO owners (name, email, phone) VALUES
('Carlos Pérez', 'carlos@email.com', '3001111111'),
('Ana Gómez', 'ana@email.com', '3002222222'),
('Luis Torres', 'luis@email.com', '3003333333'),
('María López', 'maria@email.com', '3004444444'),
('Jorge Ramírez', 'jorge@email.com', '3005555555'),
('Camila Rojas', 'camila@email.com', '3006666666'),
('David Castro', 'david@email.com', '3007777777'),
('Laura Méndez', 'laura@email.com', '3008888888'),
('Andrés Silva', 'andres@email.com', '3009999999'),
('Paula Herrera', 'paula@email.com', '3010000000'),
('Miguel Torres', 'miguel@email.com', '3011111111'),
('Natalia Ruiz', 'natalia@email.com', '3012222222'),
('Sebastián Mora', 'sebastian@email.com', '3013333333'),
('Valentina Cruz', 'valentina@email.com', '3014444444'),
('Ricardo León', 'ricardo@email.com', '3015555555');

-- INSERTAR DATOS EN BOATS
INSERT INTO boats (name, type, length, owner_id) VALUES
('Sea Breeze', 'Yate', 30, 1),
('Ocean Star', 'Lancha', 12, 2),
('Blue Wave', 'Velero', 20, 3),
('Sunset Dream', 'Yate', 28, 1),
('Wind Rider', 'Velero', 18, 4),
('Aqua King', 'Lancha', 10, 5),
('Marine One', 'Yate', 35, 2),
('Silver Fish', 'Lancha', 9, 3),
('Golden Sail', 'Velero', 22, 4),
('Deep Blue', 'Yate', 40, 5),
('Wave Runner', 'Lancha', 11, 6),
('Sea Queen', 'Yate', 32, 7),
('Ocean Pearl', 'Velero', 19, 8),
('Storm Rider', 'Lancha', 13, 9),
('Blue Horizon', 'Yate', 29, 10);

-- INSERTAR DATOS EN BERTHS
INSERT INTO berths (location, max_length, status) VALUES
('A1', 35, 'available'),
('A2', 40, 'occupied'),
('B1', 25, 'available'),
('B2', 30, 'occupied'),
('C1', 20, 'available');

-- INSERTAR DATOS EN SERVICES
INSERT INTO services (name, price) VALUES
('Mantenimiento', 200),
('Limpieza', 100),
('Reparación', 300),
('Inspección', 120),
('Combustible', 150);

-- ACTUALIZAR TELÉFONO DE UN PROPIETARIO
UPDATE owners
SET phone = '3119999999'
WHERE owner_id = 3;

-- ACTUALIZAR ESTADO DE UN BARCO
UPDATE boats
SET status = 'maintenance'
WHERE boat_id = 5;

-- ACTUALIZAR VARIOS MUELLES
UPDATE berths
SET status = 'available'
WHERE status = 'occupied';

-- VERIFICAR BARCO ANTES DE ELIMINAR
SELECT boat_id, name, type, length, owner_id, status
FROM boats
WHERE boat_id = 15;

-- ELIMINAR BARCO
DELETE FROM boats
WHERE boat_id = 15;

-- CONSULTAR OWNERS
SELECT owner_id, name, email, phone, created_at
FROM owners;

-- CONSULTAR BOATS
SELECT boat_id, name, type, length, owner_id, status
FROM boats;

-- CONSULTAR BERTHS
SELECT berth_id, location, max_length, status
FROM berths;

-- CONSULTAR SERVICES
SELECT service_id, name, price
FROM services;

-- CONSULTAR BARCOS Y PROPIETARIOS
SELECT boats.name AS boat, owners.name AS owner
FROM boats
JOIN owners ON boats.owner_id = owners.owner_id;

-- CONSULTAR BARCOS MAYORES A 25 PIES
SELECT name, length
FROM boats
WHERE length > 25;

-- CONSULTAR MUELLES DISPONIBLES
SELECT berth_id, location, max_length, status
FROM berths
WHERE status = 'available';

-- CONSULTAR SERVICIOS POR PRECIO
SELECT service_id, name, price
FROM services
ORDER BY price DESC;

-- CONTAR BARCOS POR PROPIETARIO
SELECT owners.name, COUNT(boats.boat_id) AS total_boats
FROM owners
LEFT JOIN boats ON owners.owner_id = boats.owner_id
GROUP BY owners.name;

-- CONSULTAR EL BARCO MÁS LARGO
SELECT name, length
FROM boats
ORDER BY length DESC
LIMIT 1;

-- INSERTAR MÁS PROPIETARIOS
INSERT INTO owners (name, email, phone) VALUES
('Felipe Navarro', 'felipe@email.com', '3021111111'),
('Juliana Castro', 'juliana@email.com', '3022222222'),
('Santiago Pérez', 'santiago@email.com', '3023333333'),
('Daniela Ríos', 'daniela@email.com', '3024444444'),
('Kevin Morales', 'kevin@email.com', '3025555555'),
('Laura Sánchez', 'laura.s@email.com', '3026666666'),
('Mateo Vargas', 'mateo@email.com', '3027777777'),
('Isabella León', 'isabella@email.com', '3028888888'),
('Tomás Herrera', 'tomas@email.com', '3029999999'),
('Gabriela Núñez', 'gabriela@email.com', '3030000000');

-- INSERTAR MÁS BARCOS
INSERT INTO boats (name, type, length, owner_id) VALUES
('Coral Sea', 'Yate', 31, 11),
('Pacific Star', 'Lancha', 14, 12),
('Blue Shark', 'Velero', 21, 13),
('Sea Master', 'Yate', 33, 14),
('Golden Wave', 'Lancha', 15, 15),
('Ocean Light', 'Velero', 24, 16),
('Silver Ocean', 'Yate', 36, 17),
('Wind Master', 'Lancha', 16, 18),
('Atlantic Dream', 'Velero', 23, 19),
('Sea Dragon', 'Yate', 38, 20),
('Marina Queen', 'Lancha', 17, 21),
('Deep Ocean', 'Velero', 26, 22),
('Blue Marine', 'Yate', 34, 23),
('Storm Ocean', 'Lancha', 18, 24),
('Royal Sea', 'Yate', 39, 25);

-- INSERTAR MÁS MUELLES
INSERT INTO berths (location, max_length, status) VALUES
('C2', 22, 'available'),
('D1', 28, 'occupied'),
('D2', 32, 'available'),
('E1', 45, 'occupied'),
('E2', 50, 'available');

-- INSERTAR MÁS SERVICIOS
INSERT INTO services (name, price) VALUES
('Pintura', 250),
('Lavado Premium', 180),
('Cambio de Motor', 500),
('Revisión Técnica', 220),
('Almacenamiento', 350);

PRAGMA foreign_keys = ON;

-- CONSULTAR TODOS LOS PROPIETARIOS
SELECT 
    owner_id AS id_propietario,
    name AS nombre_propietario,
    email AS correo_electronico,
    phone AS telefono
FROM owners;

-- CONSULTAR TODOS LOS BARCOS
SELECT 
    boat_id AS id_barco,
    name AS nombre_barco,
    type AS tipo_barco,
    length AS longitud,
    status AS estado
FROM boats;

-- CONSULTAR TODOS LOS MUELLES
SELECT 
    berth_id AS id_muelle,
    location AS ubicacion,
    max_length AS longitud_maxima,
    status AS estado
FROM berths;

-- CONSULTAR TODOS LOS SERVICIOS
SELECT 
    service_id AS id_servicio,
    name AS nombre_servicio,
    price AS precio
FROM services;

-- CONSULTAR BARCOS Y SUS PROPIETARIOS
SELECT 
    boats.name AS nombre_barco,
    owners.name AS nombre_propietario
FROM boats
JOIN owners 
ON boats.owner_id = owners.owner_id;

-- CONSULTAR BARCOS MAYORES A 25 PIES
SELECT 
    name AS nombre_barco,
    length AS longitud
FROM boats
WHERE length > 25;

-- CONSULTAR BARCOS EN MANTENIMIENTO
SELECT 
    boat_id AS id_barco,
    name AS nombre_barco,
    status AS estado
FROM boats
WHERE status = 'maintenance';

-- CONSULTAR MUELLES DISPONIBLES
SELECT 
    berth_id AS id_muelle,
    location AS ubicacion,
    status AS estado
FROM berths
WHERE status = 'available';

-- CONSULTAR SERVICIOS CON PRECIO MAYOR A 150
SELECT 
    service_id AS id_servicio,
    name AS servicio,
    price AS precio
FROM services
WHERE price > 150;

-- CONSULTAR SERVICIOS ORDENADOS POR PRECIO
SELECT 
    service_id AS id_servicio,
    name AS nombre_servicio,
    price AS precio
FROM services
ORDER BY price DESC;

-- CONSULTAR BARCOS ORDENADOS POR LONGITUD
SELECT 
    boat_id AS id_barco,
    name AS nombre_barco,
    length AS longitud
FROM boats
ORDER BY length ASC;

-- CONTAR BARCOS POR PROPIETARIO
SELECT 
    owners.name AS propietario,
    COUNT(boats.boat_id) AS cantidad_barcos
FROM owners
LEFT JOIN boats 
ON owners.owner_id = boats.owner_id
GROUP BY owners.name;

-- CONSULTAR EL BARCO MÁS LARGO
SELECT 
    name AS nombre_barco,
    length AS longitud
FROM boats
ORDER BY length DESC
LIMIT 1;

-- PAGINACIÓN PRIMERA PÁGINA
SELECT 
    boat_id AS id_barco,
    name AS nombre_barco,
    type AS tipo_barco
FROM boats
LIMIT 5 OFFSET 0;

-- PAGINACIÓN SEGUNDA PÁGINA
SELECT 
    boat_id AS id_barco,
    name AS nombre_barco,
    type AS tipo_barco
FROM boats
LIMIT 5 OFFSET 5;

-- =====================================================
-- SEMANA 5
-- BETWEEN - IN - LIKE
-- =====================================================


-- =========================================
-- BETWEEN
-- Consultar barcos con longitud
-- entre 15 y 35 pies
-- =========================================

SELECT
    boat_id,
    name,
    type,
    length
FROM boats
WHERE length BETWEEN 15 AND 35;



-- =========================================
-- BETWEEN
-- Consultar servicios con precio
-- entre 150 y 350
-- =========================================

SELECT
    service_id,
    name,
    price
FROM services
WHERE price BETWEEN 150 AND 350;



-- =========================================
-- IN
-- Consultar barcos tipo Yate y Velero
-- =========================================

SELECT
    boat_id,
    name,
    type
FROM boats
WHERE type IN ('Yate', 'Velero');



-- =========================================
-- IN
-- Consultar muelles disponibles y ocupados
-- =========================================

SELECT
    berth_id,
    location,
    status
FROM berths
WHERE status IN ('available', 'occupied');



-- =========================================
-- LIKE
-- Buscar barcos cuyo nombre
-- empieza por "Sea"
-- =========================================

SELECT
    boat_id,
    name
FROM boats
WHERE name LIKE 'Sea%';



-- =========================================
-- LIKE
-- Buscar propietarios que contienen
-- la palabra "Torres"
-- =========================================

SELECT
    owner_id,
    name,
    email
FROM owners
WHERE name LIKE '%Torres%';



-- =========================================
-- CONSULTA COMBINADA
-- BETWEEN + IN + LIKE
-- =========================================

SELECT
    boat_id,
    name,
    type,
    length,
    status
FROM boats
WHERE length BETWEEN 20 AND 40
AND type IN ('Yate', 'Velero')
AND name LIKE '%Sea%'
ORDER BY length DESC;

