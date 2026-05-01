
CREATE TABLE owners (
    owner_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone TEXT,
    address TEXT
);
CREATE TABLE boats (
    boat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT,
    length REAL,
    owner_id INTEGER NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);

CREATE TABLE berths (
    berth_id INTEGER PRIMARY KEY AUTOINCREMENT,
    location TEXT NOT NULL,
    max_length REAL,
    status TEXT CHECK(status IN ('available', 'occupied')) DEFAULT 'available'
);

CREATE TABLE services (
    service_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL
);

INSERT INTO owners (name, email, phone) VALUES
('Carlos Pérez', 'carlos@email.com', '3001111111'),
('Ana Gómez', 'ana@email.com', '3002222222'),
('Luis Torres', 'luis@email.com', '3003333333'),
('María López', 'maria@email.com', '3004444444'),
('Jorge Ramírez', 'jorge@email.com', '3005555555');


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


INSERT INTO berths (location, max_length, status) VALUES
('A1', 35, 'available'),
('A2', 40, 'occupied'),
('B1', 25, 'available'),
('B2', 30, 'occupied'),
('C1', 20, 'available');

INSERT INTO services (name, price) VALUES
('Mantenimiento', 200),
('Limpieza', 100),
('Reparación', 300),
('Inspección', 120),
('Combustible', 150);

SELECT * FROM boats;
SELECT boats.name AS boat, owners.name AS owner
FROM boats
JOIN owners ON boats.owner_id = owners.owner_id;
SELECT name, length
FROM boats
WHERE length > 25;
SELECT * FROM berths
WHERE status = 'available';
SELECT * FROM services
ORDER BY price DESC;
SELECT owners.name, COUNT(boats.boat_id) AS total_boats
FROM owners
LEFT JOIN boats ON owners.owner_id = boats.owner_id
GROUP BY owners.name;
SELECT name, length
FROM boats
ORDER BY length DESC
LIMIT 1;