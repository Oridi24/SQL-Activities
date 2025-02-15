SELECT 
       name,	
       surname,	
       COUNT(res.reservation_id) as total_reservas
FROM customer AS cus
INNER JOIN reservation AS res
ON cus.customer_id = res.customer_id
GROUP BY cus.name, cus.surname
;


SELECT
*,
CAST (price as VARCHAR) as price_varchar
FROM 
apartment

;
                      -- ejercicios --
/*1. Recupera todos los clientes (name y email) ordenados alfabéticamente por nombre*/
SELECT
 name,
 email
FROM customer
ORDER BY name ASC
;

/*2. Encuentra el número total de reservas */
SELECT
MAX(reservation_id)
FROM reservation
;

/*3. Muestra los detalles de las reservas (reservation_id, start_date, end_date) para un 
cliente específico (puedes elegir el customer_id). */
SELECT 
 r.reservation_id,
 r.start_date,
 r.end_date,
 r.customer_id,
 c.name,
 c.surname
FROM reservation r
JOIN customer c 
ON r.customer_id = c.customer_id
WHERE r.customer_id = 10
;

/*4. Encuentra el nombre y apellido de los propietarios que tienen apartamentos. */
SELECT
 name,
 surname
FROM owner 
;

/*5. Recupera el nombre y la ubicación de los apartamentos propiedad de un propietario 
específico (puedes elegir el owner_id).*/
SELECT
 o.name,
 o.owner_id, 
 a.location
FROM owner o 
JOIN apartment a 
ON o.owner_id = a.owner_id
WHERE o.owner_id = 8
;

/*6. Muestra las comodidades asociadas a un apartamento específico (puedes elegir el 
apartment_id).*/ 

SELECT apt_amenity.apartment_id
     , amenity.name
  FROM apt_amenity
  JOIN amenity
    ON amenity.amenity_id = apt_amenity.amenity_id
 WHERE apt_amenity.apartment_id = 9
 ;


/*7. Encuentra los clientes que no han realizado ninguna reserva.*/
SELECT 
 c.name,
 c.surname,
 c.customer_id,
 r.reservation_id,
 r.customer_id
FROM customer c 
LEFT JOIN reservation r  
ON r.customer_id = c.customer_id
WHERE r.reservation_id ISNULL
;

/*8. Obtén el número total de apartamentos en una ubicación específica (puedes elegir la 
ubicación). */
SELECT location
     , COUNT(*) AS total_apartamentos
  FROM apartment
 WHERE location = 'Vigo'
 GROUP BY location
 ;


/*9. Recupera la información completa de las reservas (reservation_id, start_date, 
end_date) para los apartamentos que tienen un precio superior a cierto valor(puedes elegir el valor). */
SELECT
 r.reservation_id,
 r.start_date, 
 r.end_date,
 a.apartment_id,
 a.price
FROM reservation r
JOIN apartment a
ON r.reservation_id = a.apartment_id
WHERE a.price > 150
;
 
/*10. Encuentra el propietario con más apartamentos y muestra sus detalles (name, 
surname, email).*/ 
SELECT
 o.name,
 o.surname,
 o.email,
 o.owner_id,
COUNT(a.owner_id) as owner_max
FROM owner o
JOIN apartment a
ON o.owner_id = a.owner_id
GROUP BY o.owner_id, o.name, o.surname, o.email
ORDER BY owner_max DESC
LIMIT 1
;

/*11. Muestra la ubicación y el número de reservas para cada ubicación, ordenado por 
número de reservas descendente.*/ 

SELECT
 a.location,
 COUNT(r.apartment_id) AS num_reservas 
FROM apartment a 
JOIN reservation r 
ON a.apartment_id = r.apartment_id
GROUP BY a.location
ORDER BY num_reservas DESC
;

/*12. Encuentra los clientes que han realizado al menos una reserva y muestra cuántas 
reservas han hecho.*/ 
 SELECT
  c.name,
  c.surname,
  COUNT(r.apartment_id) AS num_reservas
 FROM customer c 
 JOIN reservation r 
 ON c.customer_id = r.customer_id
 GROUP BY c.customer_id
 ORDER BY num_reservas
;


/*13. Obtén el precio promedio de los apartamentos.*/ 
SELECT
 ROUND(AVG(price),2),
 location 
FROM apartment
GROUP BY location 
;


/*14. Recupera el nombre de las comodidades que están asociadas a más de un 
apartamento. */

SELECT amenity.name
  FROM amenity
  JOIN (SELECT amenity_id
             , COUNT(*) AS total_apartamentos
          FROM apt_amenity
         GROUP BY amenity_id
        HAVING COUNT(*) > 1) usual_amenity
    ON amenity.amenity_id = usual_amenity.amenity_id
;


/*15. Encuentra los propietarios que tienen apartamentos en más de una ubicación.*/

SELECT
    o.name,
    o.surname,
    a.location,
    COUNT(a.apartment_id) AS num_apto
FROM owner o 
JOIN apartment a 
ON o.owner_id = a.owner_id
GROUP BY o.name,o.surname,a.location
HAVING COUNT(a.location) > 2 
;

/*16. Muestra las reservas que están programadas desde una fecha futura (puedes elegir 
la fecha).*/ 
SELECT *
  FROM reservation
 WHERE start_date > '2024-01-01'
;    

/*17. Obtén el nombre de los clientes que han realizado reservas en al menos dos 
ubicaciones diferentes. */ 
 SELECT 
    c.name, 
    c.surname, 
    COUNT(DISTINCT a.location) AS num_locations,
    a.location
FROM customer c
JOIN reservation r 
    ON c.customer_id = r.customer_id
JOIN apartment a 
    ON r.apartment_id = a.apartment_id
GROUP BY c.customer_id, c.name, c.surname,a.location
HAVING COUNT(DISTINCT a.location) >= 2
ORDER BY a.location 
;
 
 -------------------
SELECT 
    c.name, 
    c.surname, 
    GROUP_CONCAT(DISTINCT a.location ORDER BY a.location SEPARATOR ', ') AS locations,
    COUNT(DISTINCT a.location) AS num_locations
FROM customer c
JOIN reservation r 
    ON c.customer_id = r.customer_id
JOIN apartment a 
    ON r.apartment_id = a.apartment_id
GROUP BY c.customer_id, c.name, c.surname
HAVING COUNT(DISTINCT a.location) >= 2
;

----varias reservas en misma ubicacion------
SELECT
    c.name,
    c.surname,
    r.apartment_id,
    COUNT(r.reservation_id) AS num_reservas,
    a.location
FROM customer c
JOIN reservation r 
    ON c.customer_id = r.customer_id
JOIN apartment a 
    ON a.apartment_id = r.apartment_id 
GROUP BY c.name, c.surname, r.apartment_id,a.location
HAVING COUNT(a.location) > 2 
;

/*18. Obtén la ubicación con el mayor número de comodidades, mostrando el nombre de 
la ubicación y la cantidad de comodidades.*/ 
SELECT
FROM 
JOIN amenity an 
ON 


/*19. Obtén la cantidad total de reservas realizadas por cada cliente, ordenado de mayor a 
menor.*/
SELECT
  c.name,
  c.surname,
  COUNT(r.reservation_id) AS total_reservas
FROM customer c 
LEFT JOIN reservation r
ON c.customer_id = r.customer_id
GROUP BY c.name, c.surname
ORDER BY total_reservas  DESC
;
/*20. Clientes que han repetido en un mismo apartment */

SELECT
    c.name,
    c.surname,
    r.apartment_id,
    COUNT(r.reservation_id) AS num_reservas
FROM customer c
JOIN reservation r
    ON c.customer_id = r.customer_id
GROUP BY c.name, c.surname, r.apartment_id
HAVING COUNT(r.reservation_id) > 1
;