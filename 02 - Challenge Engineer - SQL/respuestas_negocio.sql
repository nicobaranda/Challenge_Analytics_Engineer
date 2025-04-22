-- 1. Listar los usuarios que cumplan años el día de hoy cuya cantidad de ventas realizadas en enero 2020
-- sea superior a 1500.

SELECT
	 B.Nombre AS Nombre
	,B.Apellido AS Apellido
FROM Orders A
INNER JOIN Customer B
	ON A.Customer_ID = B.Customer_ID

-- Filtrar por año 2020 y mes enero. Tambien por fecha actual como fecha de cumpleaños
WHERE 1=1
    AND YEAR(A.Fecha_Orden) = 2020
    AND MONTH(A.Fecha_Orden) = 1
    AND B.Fecha_Nacimiento = GETDATE()

group by B.Nombre, B.Apellido

-- Filtrar clientes que tengan mas de 1500 ventas
HAVING count(A.Order_ID) > 1500;


-- 2. Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la categoría Celulares.
-- Se requiere el mes y año de análisis, nombre y apellido del vendedor, cantidad de ventas realizadas,
-- cantidad de productos vendidos y el monto total transaccionado.

SELECT
     Ventas_Top.Mes
    ,A.Nombre as Nombre
    ,A.Apellido as Apellido
    ,Ventas_Top.Ventas_Total as Ventas_Total
    ,Ventas_Top.Precio_Total as Precio_Total
FROM Customer A
INNER JOIN
(

-- Seleccionar top 5 por mes durante el año 2020, contar los items vendidos y sumar el precio total
SELECT
	 TOP 5 
  	 MONTH(B.Fecha_Orden) AS Mes
	,A.Customer_ID AS Customer_ID 	 
	,COUNT(B.Order_ID) AS Ventas_Total
    ,SUM(B.Precio) AS Precio_Total
FROM Customer A
INNER JOIN Orders B
	ON A.Customer_ID = B.Customer_ID
INNER JOIN Item C
	ON B.Item_ID = C.Item_ID
INNER JOIN Category D
	ON C.Category_ID = D.Category_ID

-- Filtrar por categoria celulares, el estado de orden y el año 2020
WHERE 1=1
	AND D.Nombre = 'Celulares'
  	AND YEAR(B.Fecha_Orden) = 2020

GROUP BY MONTH(B.Fecha_Orden), A.Customer_ID

-- Ordenar por cantidad de clientes
ORDER BY COUNT(A.Customer_ID) ASC
) Ventas_Top
	ON A.Customer_ID = Ventas_Top.Customer_ID

order by Ventas_Top.Mes, Ventas_Top.Precio_Total;


-- 3. Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día.
-- Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item, vamos a tener únicamente
-- el último estado informado por la PK definida. (Se puede resolver a través de StoredProcedure)

CREATE PROCEDURE dbo.Item_Activo_Carga

-- Ingresar fecha de orden a cargar datos
@Fecha datetime
AS

INSERT INTO Item_Activo

SELECT
	 A.Item_ID as Item_ID
    ,A.Nombre as Nombre
    ,B.Precio as Precio
    ,'Activo' as Estado
from Item A
INNER JOIN Orders B
	on A.Item_ID = B.Item_ID

WHERE 1=1
	AND B.Fecha_Orden = @Fecha

UNION

SELECT
	  A.Item_ID as Item_ID
     ,A.Nombre as Nombre
     ,B.Precio as Precio
     ,'No Activo' AS Estado
FROM Item A
LEFT JOIN Orders B
	ON A.Item_ID = B.Item_ID
LEFT JOIN Item_Activo C
	ON A.Item_ID = C.Item_ID

WHERE 1=1
	AND B.Item_ID IS NULL
	AND C.Item_ID IS NULL;