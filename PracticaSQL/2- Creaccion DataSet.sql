
                                 -- Creacion de tablas

-- Tabla de Alumnos
CREATE TABLE alumno (
    id_alumno SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_inscripcion DATE NOT NULL,
    id_bootcamp INT
    );

-- Tabla de Bootcamps
CREATE TABLE bootcamp (
    id_bootcamp SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion_meses INT CHECK (duracion_meses > 0),
    precio DECIMAL(10,2) CHECK (precio >= 0)
);

-- Tabla de Módulos
CREATE TABLE modulo (
    id_modulo SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_bootcamp INT NOT NULL,
    CONSTRAINT fk_modulo_bootcamp FOREIGN KEY (id_bootcamp) REFERENCES bootcamp(id_bootcamp) ON DELETE CASCADE
);

-- Tabla de Profesores
CREATE TABLE profesor (
    id_profesor SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    especialidad VARCHAR(100)
);

-- Tabla de Clases
CREATE TABLE clase (
    id_clase SERIAL PRIMARY KEY,
    fecha_hora TIMESTAMP NOT NULL,
    id_modulo INT NOT NULL,
    id_profesor INT NOT NULL,
    CONSTRAINT fk_clase_modulo FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo) ON DELETE CASCADE,
    CONSTRAINT fk_clase_profesor FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor) ON DELETE SET NULL
);

-- Tabla de Inscripción (relación muchos a muchos entre Alumnos y Módulos)
CREATE TABLE inscripcion (
    id_inscripcion SERIAL PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_modulo INT NOT NULL,
    fecha_inscripcion DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_inscripcion_alumno FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno) ON DELETE CASCADE,
    CONSTRAINT fk_inscripcion_modulo FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo) ON DELETE CASCADE,
    CONSTRAINT unique_inscripcion UNIQUE (id_alumno, id_modulo) -- Evita inscripciones duplicadas
);

                      --Contenido de tablas

-- Insertar Bootcamps
INSERT INTO bootcamp (nombre, descripcion, duracion_meses, precio) VALUES
('Full Stack Web', 'Desarrollo web con JavaScript, React y Node.js', 6, 5000),
('Big Data & IA', 'Análisis de datos, Machine Learning y más', 8, 7000),
('Ciberseguridad', 'Hacking ético y seguridad informática', 7, 6000);

-- Insertar Alumnos
INSERT INTO alumno (nombre, apellido, email, telefono, fecha_inscripcion, id_bootcamp) VALUES
('Carlos', 'Gómez', 'carlos.gomez@mail.com', '123456789', '2024-01-15', 1),
('María', 'López', 'maria.lopez@mail.com', '987654321', '2024-02-10', 2),
('Pedro', 'Martínez', 'pedro.martinez@mail.com', '567123890', '2024-01-25', 3);

-- Insertar Módulos
INSERT INTO modulo (nombre, descripcion, id_bootcamp) VALUES
('Frontend con React', 'Desarrollo de interfaces web modernas', 1),
('Backend con Node.js', 'Creación de APIs RESTful', 1),
('Big Data con Spark', 'Procesamiento de datos masivos', 2),
('Machine Learning', 'Modelos de IA con Python', 2),
('Pentesting Avanzado', 'Técnicas de hacking ético', 3);

-- Insertar Profesores
INSERT INTO profesor (nombre, apellido, email, especialidad) VALUES
('Laura', 'Fernández', 'laura.fernandez@mail.com', 'Desarrollo Web'),
('Javier', 'Ruiz', 'javier.ruiz@mail.com', 'Big Data & IA'),
('Ana', 'Torres', 'ana.torres@mail.com', 'Ciberseguridad');

-- Insertar Clases
INSERT INTO clase (fecha_hora, id_modulo, id_profesor) VALUES
('2024-03-05 10:00:00', 1, 1),
('2024-03-06 15:00:00', 2, 1),
('2024-03-07 12:00:00', 3, 2),
('2024-03-08 14:00:00', 4, 2),
('2024-03-09 09:00:00', 5, 3);

-- Insertar Inscripciones (relación muchos a muchos entre Alumnos y Módulos)
INSERT INTO inscripcion (id_alumno, id_modulo, fecha_inscripcion) VALUES
(1, 1, '2024-02-01'),
(1, 2, '2024-02-01'),
(2, 3, '2024-02-10'),
(2, 4, '2024-02-11'),
(3, 5, '2024-02-15');