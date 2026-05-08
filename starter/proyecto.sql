
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

