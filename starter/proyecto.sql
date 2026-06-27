
-- TABLA DE PROPIETARIOS
CREATE TABLE owners (
    owner_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone TEXT,
    address TEXT
);

-- TABLA DE BARCOS
CREATE TABLE boats (
    boat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT,
    length REAL,
    owner_id INTEGER NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);
-- TABLA DE MUELLES
CREATE TABLE berths (
    berth_id INTEGER PRIMARY KEY AUTOINCREMENT,
    location TEXT NOT NULL,
    max_length REAL,
    status TEXT CHECK(status IN ('available', 'occupied')) DEFAULT 'available'
);
-- TABLA DE SERVICIOS
CREATE TABLE services (
    service_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL
);
-- INSERTAR DATOS EN PROPIETARIOS
INSERT INTO owners (name, email, phone) VALUES
('Carlos Pérez', 'carlos@email.com', '3001111111'),
('Ana Gómez', 'ana@email.com', '3002222222'),
('Luis Torres', 'luis@email.com', '3003333333'),
('María López', 'maria@email.com', '3004444444'),
('Jorge Ramírez', 'jorge@email.com', '3005555555');


-- INSERTAR DATOS EN BARCOS
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
('Blue Horizon', 'Yate', 29, 5);


-- INSERTAR DATOS EN MUELLES
INSERT INTO berths (location, max_length, status) VALUES
('A1', 35, 'available'),
('A2', 40, 'occupied'),
('B1', 25, 'available'),
('B2', 30, 'occupied'),
('C1', 20, 'available');

-- INSERTAR DATOS EN SERVICIOS
INSERT INTO services (name, price) VALUES
('Mantenimiento', 200),
('Limpieza', 100),
('Reparación', 300),
('Inspección', 120),
('Combustible', 150);

-- Mostrar todos los registros de la tabla Barcos
SELECT * FROM boats;

-- Mostrar el nombre de cada embarcación junto con el nombre de su propietario
SELECT boats.name AS boat, owners.name AS owner
FROM boats
JOIN owners ON boats.owner_id = owners.owner_id;

-- Consultar las embarcaciones con una longitud mayor a 25 metros
SELECT name, length
FROM boats
WHERE length > 25;

-- Mostrar los amarres que se encuentran disponibles
SELECT * FROM berths
WHERE status = 'available';

-- Listar los servicios ordenados de mayor a menor precio
SELECT * FROM services
ORDER BY price DESC;

-- Contar la cantidad de embarcaciones que tiene cada propietario
SELECT owners.name, COUNT(boats.boat_id) AS total_boats
FROM owners
LEFT JOIN boats ON owners.owner_id = boats.owner_id
GROUP BY owners.name;

-- Mostrar la embarcación con la mayor longitud
SELECT name, length
FROM boats
ORDER BY length DESC
LIMIT 1;