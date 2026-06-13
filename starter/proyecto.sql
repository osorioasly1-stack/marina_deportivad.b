DROP TABLE IF EXISTS boats;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS berths;
DROP TABLE IF EXISTS services;

PRAGMA foreign_keys = ON;
-- TABLA PROPIETARIOS
CREATE TABLE owners (
    owner_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone TEXT,
    address TEXT
);

-- TABLA EMBARCACIONES
CREATE TABLE boats (
    boat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT,
    length REAL CHECK(length > 0),
    owner_id INTEGER NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);

-- TABLA MUELLES
CREATE TABLE berths (
    berth_id INTEGER PRIMARY KEY AUTOINCREMENT,
    location TEXT NOT NULL,
    max_length REAL CHECK(max_length > 0),
    status TEXT CHECK(status IN ('available', 'occupied')) DEFAULT 'available'
);

-- TABLA SERVICIOS
CREATE TABLE services (
    service_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL CHECK(price > 0)
);

-- PROPIETARIOS
INSERT INTO owners (name, email, phone, address) VALUES
('Carlos Pérez', 'carlos@email.com', '3001111111', 'Bogotá'),
('Ana Gómez', 'ana@email.com', '3002222222', 'Medellín'),
('Luis Torres', 'luis@email.com', '3003333333', 'Cali'),
('María López', 'maria@email.com', '3004444444', 'Barranquilla'),
('Jorge Ramírez', 'jorge@email.com', '3005555555', 'Cartagena'),
('Pedro Castro', 'pedro@email.com', NULL, 'Bogotá'),
('Laura Díaz', 'laura@email.com', NULL, 'Medellín'),
('Sofía Ruiz', 'sofia@email.com', NULL, 'Cali');

-- EMBARCACIONES (30 REGISTROS)
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
('Wave Runner', 'Lancha', 11, 1),
('Sea Queen', 'Yate', 32, 2),
('Ocean Pearl', 'Velero', 19, 3),
('Storm Rider', 'Lancha', 13, 4),
('Blue Horizon', 'Yate', 29, 5),
('Coral Sea', 'Yate', 31, 1),
('White Shark', 'Lancha', 14, 2),
('Ocean Wind', 'Velero', 21, 3),
('Blue Sky', 'Yate', 33, 4),
('Sea Master', 'Lancha', 12, 5),
('Golden Ocean', 'Velero', 23, 1),
('Marine Star', 'Yate', 36, 2),
('Silver Wave', 'Lancha', 15, 3),
('Ocean Queen', 'Velero', 24, 4),
('Sea Explorer', 'Yate', 38, 5),
('Wind Master', 'Lancha', 11, 1),
('Blue Dream', 'Yate', 34, 2),
('Atlantic Rider', 'Velero', 20, 3),
('Ocean Spirit', 'Lancha', 13, 4),
('Sea Legend', 'Yate', 37, 5);

-- MUELLES
INSERT INTO berths (location, max_length, status) VALUES
('A1', 35, 'available'),
('A2', 40, 'occupied'),
('B1', 25, 'available'),
('B2', 30, 'occupied'),
('C1', 20, 'available');

-- SERVICIOS
INSERT INTO services (name, description, price) VALUES
('Mantenimiento', 'Mantenimiento general de embarcaciones', 200),
('Limpieza', 'Limpieza interior y exterior', 100),
('Reparación', 'Reparación mecánica', 300),
('Inspección', 'Revisión de seguridad', 120),
('Combustible', 'Recarga de combustible', 150);

-- CONSULTAS DE LA SEMANA 7

-- IS NULL
SELECT *
FROM owners
WHERE phone IS NULL;

-- COALESCE
SELECT
    name,
    COALESCE(phone, 'Sin teléfono registrado') AS telefono
FROM owners;

-- JOIN
SELECT boats.name AS boat,
       owners.name AS owner
FROM boats
JOIN owners ON boats.owner_id = owners.owner_id;

-- Embarcaciones mayores a 25 metros
SELECT name, length
FROM boats
WHERE length > 25;

-- Muelles disponibles
SELECT *
FROM berths
WHERE status = 'available';

-- Servicios por precio
SELECT *
FROM services
ORDER BY price DESC;

-- Cantidad de embarcaciones por propietario
SELECT owners.name,
       COUNT(boats.boat_id) AS total_boats
FROM owners
LEFT JOIN boats
ON owners.owner_id = boats.owner_id
GROUP BY owners.name;

-- Embarcación más larga
SELECT name, length
FROM boats
ORDER BY length DESC
LIMIT 1;