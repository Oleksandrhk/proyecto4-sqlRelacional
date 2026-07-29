-- 1. Vuelos con status On Time y su identificador
SELECT flight_id, route_no, status
FROM flights
WHERE status = 'On Time';


-- 2. Reservas con importe total mayor a 1.000.000
SELECT *
FROM bookings
WHERE total_amount > 1000000;

-- 3. Datos de los modelos de avion disponibles
SELECT *
FROM airplanes_data;


-- 4. Identificadores de vuelo que han volado con Boeing 737 (codigo 733)
SELECT f.flight_id
FROM flights f
JOIN routes r ON f.route_no = r.route_no
WHERE r.airplane_code = '733';


-- 5. Tickets comprados por personas llamadas Irina
SELECT *
FROM tickets
WHERE passenger_name LIKE 'IRINA %';

-- OPCIONALES --
-- 6. Ciudades con mas de un aeropuerto
SELECT city ->> 'en' AS ciudad, COUNT(*) AS num_aeropuertos
FROM airports_data
GROUP BY city ->> 'en'
HAVING COUNT(*) > 1;




-- 7. Numero de vuelos por modelo de avion
SELECT a.model ->> 'en' AS modelo, COUNT(*) AS num_vuelos
FROM flights f
JOIN routes r ON f.route_no = r.route_no
JOIN airplanes_data a ON r.airplane_code = a.airplane_code
GROUP BY a.model ->> 'en'
ORDER BY num_vuelos DESC;




-- 8. Reservas con mas de un billete (varios pasajeros)
SELECT book_ref, COUNT(*) AS num_billetes
FROM tickets
GROUP BY book_ref
HAVING COUNT(*) > 1
ORDER BY num_billetes DESC;


-- 9. Vuelos con retraso de salida superior a una hora
SELECT flight_id,
       route_no,
       scheduled_departure,
       actual_departure,
       actual_departure - scheduled_departure AS retraso
FROM flights
WHERE actual_departure - scheduled_departure > INTERVAL '1 hour'
ORDER BY retraso DESC;
