#  Módulo de SQL Avanzado, ETL y Data Warehouse  

## 📌 Descripción  
Este módulo está diseñado para proporcionar un conocimiento avanzado en bases de datos relacionales, modelado de datos y arquitecturas de almacenamiento, con un enfoque en la implementación de procesos ETL y la construcción de Data Warehouses optimizados para análisis de datos.  

Durante el curso, se han abordado las mejores prácticas en SQL utilizando herramientas como **PostgreSQL, BigQuery y TablePlus**, aplicando estrategias para optimización de consultas y modelado de datos eficiente.  

---  

##  Tecnologías y Conceptos Clave  

### 📌 **Modelado y Arquitectura de Datos**  
- **Diagrama Entidad-Relación (ERD):** Representación estructurada de las relaciones entre entidades de la base de datos.  
- **Data Warehouse:** Sistema de almacenamiento centralizado para la consolidación y análisis de datos históricos.  
- **Data Lake:** Almacén de datos en su formato original, diseñado para escalabilidad y procesamiento masivo.  
- **Data Mart:** Subconjunto de un Data Warehouse, optimizado para departamentos o áreas específicas del negocio.  

### 📌 **Estructura del Lenguaje SQL**  
- **Criterios de Modelado Relacional**  
  - `PRIMARY KEY`: Identificación única de registros en una tabla.  
  - `FOREIGN KEY`: Establecimiento de relaciones entre entidades.  
  - **Tipos de Datos:** `INTEGER`, `VARCHAR`, `DATE`, `BOOLEAN`, `DECIMAL`, entre otros.  
  - **Operadores:** `=`, `<>`, `LIKE`, `BETWEEN`, `IN`, `AND`, `OR`, `NOT`.  

- **Comandos y Cláusulas Fundamentales**  
  - **JOINS:** (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`) para combinar datos de múltiples tablas.  
  - **CAST:** Conversión explícita de tipos de datos (`CAST(column AS datatype)`).  
  - **CASE:** Evaluación condicional en consultas (`CASE WHEN THEN ELSE END`).  
  - **Funciones Agregadas:** `SUM()`, `AVG()`, `COUNT()`, `MAX()`, `MIN()`.  
  - **Orden de Ejecución SQL:** `FROM` → `JOIN` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `ORDER BY`.  

### 📌 **Buenas Prácticas en SQL y Data Management**  
✔️ **Normalización**: Diseño eficiente de bases de datos para reducir la redundancia y mejorar la integridad.  
✔️ **Índices**: Uso estratégico de índices para mejorar la velocidad de consulta.  
✔️ **Optimización de Consultas**: Aplicación de `EXPLAIN ANALYZE` en PostgreSQL para evaluar desempeño.  
✔️ **Procesos ETL (Extract, Transform, Load)**: Implementación de pipelines de datos para integración y transformación.  

---

## 🛠️ Herramientas Utilizadas  
✅ **PostgreSQL**: Sistema de gestión de bases de datos relacionales.  
✅ **BigQuery**: Plataforma de análisis de datos en la nube con SQL optimizado para Big Data.  
✅ **TablePlus**: Herramienta GUI para administración de bases de datos.  

---

##  Implementaciones Destacadas  

✔️ **Desarrollo de la tabla `ivr_detail`** con información detallada de llamadas.  
✔️ **Generación de indicadores clave:**  
   - `masiva_lg`: Identificación de llamadas relacionadas con averías masivas.  
   - `info_by_phone_lg`: Detección de clientes identificados por número telefónico.  
   - `repeated_phone_24H`: Identificación de llamadas repetidas en 24 horas.  
✔️ **Construcción de la tabla `ivr_summary`** consolidando métricas clave de llamadas.  
✔️ **Optimización de consultas avanzadas con `JOIN`, `CASE`, `CAST` y estrategias de indexación.**  
✔️ **Implementación de funciones SQL para limpieza y estandarización de datos (`clean_integer()`).**  
 
