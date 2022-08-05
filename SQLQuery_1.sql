-- Ejercicio 1: Seleccionar todos los campos de la tabla clientes, ordenado por nombre del
-- contacto de la compañía, alfabéticamente.

SELECT *
FROM Customers
ORDER BY Customers.ContactName

-- Ejercicio 2: Seleccionar todos los campos de la tabla órdenes, ordenados por fecha de
-- la orden, descendentemente.

SELECT *
FROM Orders
ORDER BY Orders.OrderDate DESC

-- Obtener todos los productos, cuyo nombre comienzan con la letra P y
-- tienen un precio unitario comprendido entre 10 y 120.
SELECT *
FROM Products
WHERE    Products.UnitPrice   BETWEEN 10 and 120
      and Products.ProductName LIKE 'P'

-- Seleccionar los productos vigentes cuyos precios unitarios están entre 35
-- y 250, sin stock en almacén. Pertenecientes a las categorías 1, 6, 4, 7 y 8, que son
-- distribuidos por los proveedores 2, 4, 6, 7 y 9.

    -- aplicando producto cartesiado con condicion de reunion

    SELECT o.ProductName, UnitPrice,c.CategoryID,p.SupplierID,o.UnitsInStock
    FROM Products as o , Suppliers as p , Categories as c
    WHERE (o.CategoryID = c.CategoryID and o.SupplierID = p.SupplierID) AND
          (o.UnitPrice BETWEEN 35 and 250 ) and (o.UnitsInStock = 0) AND
          (c.CategoryID = 1 or c.CategoryID = 6 or c.CategoryID = 4 or c.CategoryID = 7 or c.CategoryID = 8 ) AND
          (p.SupplierID = 2 or p.SupplierID = 4 or p.SupplierID = 6 or p.SupplierID = 7 or p.SupplierID = 9)
    GROUP BY    o.ProductName, UnitPrice,c.CategoryID,p.SupplierID,o.UnitsInStock

    -- aplicando inner join

    SELECT o.ProductName, UnitPrice,c.CategoryID,p.SupplierID,o.UnitsInStock
    FROM Products as o
    JOIN Categories as c ON  o.CategoryID = c.CategoryID
    JOIN Suppliers as p ON o.SupplierID = p.SupplierID
    WHERE (o.UnitPrice BETWEEN 35 and 250 ) and (o.UnitsInStock = 0) AND
          (c.CategoryID = 1 or c.CategoryID = 6 or c.CategoryID = 4 or c.CategoryID = 7 or c.CategoryID = 8 ) AND
          (p.SupplierID = 2 or p.SupplierID = 4 or p.SupplierID = 6 or p.SupplierID = 7 or p.SupplierID = 9)
    GROUP BY    o.ProductName, UnitPrice,c.CategoryID,p.SupplierID,o.UnitsInStock

-- funcion DISTINCT

SELECT DISTINCT c.Country
FROM Customers as c
ORDER BY c.Country

-- funcion case
SELECT ProductName, CategoryID
FROM Products

-- USE CASE
SELECT ProductName ,
      CASE CategoryID
            WHEN 1 THEN 'Bebidas'
            WHEN 2 THEN 'Lacteos'
            WHEN 3 THEN 'Condimentos'
            WHEN 4 THEN 'Otros'
            ELSE 'No en venta'
      END as Categoria
FROM Products
ORDER BY ProductName
GO

--XLM
SELECT CompanyName,ContactName,Country
FROM Customers
FOR XML auto
-- diferentes forams de presentar la data para importar
-- auto
-- PATH
-- raw
-- explicit(mas elavorado)

-- ----------------------------------------------------------------------------------
-- join internos
-- inner join 
SELECT *
FROM Products as p 
INNER JOIN  [Order Details] as od ON p.ProductID = od.ProductID
INNER JOIN  Orders as o ON o.OrderID=od.OrderID
INNER JOIN Employees as e ON e.EmployeeID = o.EmployeeID
INNER JOIN Customers as c ON o.CustomerID = c.CustomerID


-- ----------------------------------------------------------------------------------

-- join externos outer
      -- LEFT OUTER JOIN
      -- RIGHT OUTER JOIN
      SELECT C.CustomerID,C.CompanyName,C.ContactName,c.ContactName,C.Country,O.OrderID, O.OrderDate
      FROM Customers as C
      LEFT OUTER JOIN Orders as O 
      ON C.CustomerID = O.CustomerID 
      GO


      -- FULL OUTER JOIN != CROSS JOIN
      SELECT C.CustomerID,C.CompanyName,C.ContactName,c.ContactName,C.Country,O.OrderID, O.OrderDate
      FROM Customers as C
      FULL OUTER  JOIN Orders as O 
      ON C.CustomerID = O.CustomerID 
      GO

      -- CROSS JOIN
      SELECT C.CustomerID,C.CompanyName,C.ContactName,c.ContactName,C.Country,O.OrderID, O.OrderDate
      FROM Customers as C
      CROSS  JOIN Orders as O 
      GO

      SELECT C.CustomerID,C.CompanyName,C.ContactName,c.ContactName,C.Country,O.OrderID, O.OrderDate
      FROM Customers as C , Orders as O 
      GO

-- ---------------------------------------------------------------------------------------------------

-- SELF-JOIN (no existe es una consulta que se hace a la misma tabla) es un concepto logico
-- (compara filas de la misma tabla entre sis)
-- serequiere almenos un alias
-- ejemplo: cuando se necesita devolver todos los empleados y el nombre del JEFE del empleado

-- tabla recursiva se vuelve a llamar asi misma
SELECT * FROM Employees

SELECT EmployeeID,FirstName, LastName, ReportsTo
FROM Employees


-- serequiere almenos un alias
-- listar todos los jefes y subalternos
SELECT J.FirstName +' '+ J.LastName AS JEFE 
, S.FirstName +' '+ S.LastName AS SubAlterno
FROM Employees as J
INNER JOIN Employees as S
ON J.EmployeeID = S.ReportsTo

-- listar jefes y de quienes estan ecargados
SELECT J.FirstName +' '+ J.LastName AS JEFE 
, S.FirstName +' '+ S.LastName AS SubAlterno
FROM Employees as J
LEFT OUTER JOIN Employees as S
ON J.EmployeeID = S.ReportsTo


-- listar solo jefes
SELECT DISTINCT J.FirstName +' '+ J.LastName AS JEFE 
FROM Employees as J
LEFT OUTER JOIN Employees as S
ON J.EmployeeID = S.ReportsTo
WHERE S.FirstName is not null
-- ---------------------------------------------------------------------------------------------------

-- Generar nuevas tablas(virtuales) a partir de los datos de Customers y orders
-- INTO
SELECT * 
INTO Ordenes
FROM Orders
GO

SELECT * 
INTO clientes
FROM Customers
GO


SELECT C.CustomerID,C.CompanyName,C.ContactName,c.ContactName,C.Country,O.OrderID, O.OrderDate
      FROM clientes as C
      INNER JOIN Ordenes as O 
      ON C.CustomerID = O.CustomerID 
GO

-- Order by , Offset-fetch , manejo de valores nulos
SELECT P.ProductName, P.UnitPrice
FROM Products as P
ORDER BY UnitPrice DESC OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY
GO

-- FETCH + ciclos (transact sql puede manejar ciclos)
-- conpaginacion de datos
DECLARE @i int = 0
WHILE @i <10
BEGIN 
      SELECT E.LastName + ',' + E.FirstName 
      FROM Employees as E
      ORDER BY E.LastName ASC OFFSET @i ROWS
      FETCH NEXT 2 ROW ONLY
      SET @i +=2

END





SELECT * 
FROM Products

-- para pedir informacion de la columna de la tabla
EXEC sp_columns  Products

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- Modulo 10
-- Subconsultas
--  ( El conjunto resultante del parentesis es vuelto a consultar, este resultado puede ser ecalar,multivaluadas o con valores de tabla(vista)) 
-- la subconsulta siempre debe llevar un alias
-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
      -- Sub consultas Independientes o autonomas

            -- subconsulta de multiples valores
            SELECT T.CompanyName,T.Total FROM
            (SELECT C.CustomerID,C.CompanyName,C.Country,O.OrderID,O.OrderDate
                  ,P.ProductName,D.UnitPrice,D.Quantity
                  ,(D.UnitPrice*D.Quantity)as Total
            FROM Customers as C INNER JOIN Orders as O
            ON c.CustomerID = O.CustomerID INNER JOIN [Order Details] as D 
            ON o.OrderID = D.OrderID INNER JOIN Products as P 
            ON D.ProductID = P.ProductID)as T
            GO

            -- subconsulta escalares
                  --  devuelve un unico valor , y lus puedes usar donde se use una expresion de un solo valor como : SELECT , where ,etc
                  -- utilizar los resultados de la sub consulta como filtro en un where de otra sonsulta
                  -- tener cuidado si la subconsulta devuelve NULL , la colsultageneral devolvera NULL
                  SELECT * FROM Customers as C
                  WHERE C.CustomerID in
                  (SELECT DISTINCT CustomerID FROM Orders)

                  -- Subquery devuelto como un escalar calculando fila por fila y usando en un select
                  SELECT P.ProductName, P.UnitPrice,
                  (SELECT AVG(UnitPrice) FROM Products) as Average,
                  (SELECT AVG(UnitPrice) FROM Products) - UnitPrice as Varianza
                   FROM Products as P
      -- ---------------------------------------------------------------------------
      -- ---------------------------------------------------------------------------
      -- Subconsultas Correalcionadas
            -- ejemplo:devuelveme todas las ordenes donde se pidieron mas de 20 unidades del producto 23
            -- esto va a permitir que cada fila de la consulta interna se filte por cada fila de la consulta interna
            -- ademas vinculandolos por una consicion de reunion JOIN
            SELECT O.CustomerID,O.OrderID,O.OrderDate FROM Orders as O
            WHERE
            ( 
            SELECT D.Quantity FROM [Order Details] as D
            WHERE D.ProductID = 23 AND O.OrderID=D.OrderID
            )>20
            GO

            -- para probar que del productoID = 23 la cantidad >20
            SELECT * FROM [Order Details] as O WHERE  O.OrderID = 10869

            
            -- Subquery con resultados de multiplees valores
            SELECT C.CompanyName, C.Country ,C.CompanyName
            FROM Customers as C WHERE C.CustomerID IN
            (SELECT DISTINCT CustomerID FROM Orders )
            GO
            
            --  existis ( returne TRUE O FALSE) evalua toda la consulta interna del SELECT *
                  -- ..sin condicion de reunion con existis (sin parametro en comun)
                  -- si almenos la consulta interna devuelve un dato se ejecuta la consulta externa, es por eso que me lista los 91 clientes
                  SELECT C.CompanyName, C.Country , C.ContactName
                  FROM Customers as C WHERE EXISTS
                  (SELECT O.CustomerID FROM Orders as O )
                  GO
                  
                  -- con condicion de reunion con existis (con parametro en comun)
                  -- para que aya reunion las tablas tiene que tener un alias
                  -- si la consulta interna no devuleve por lo menos un dato, la consulta externa no muestra nada
                  SELECT C.CompanyName, C.Country , C.ContactName
                  FROM Customers as C WHERE EXISTS
                  (SELECT O.CustomerID FROM Orders as O 
                  WHERE C.CustomerID=O.CustomerID)
                  GO

                  -- quienes nunca han echo una orden
                  SELECT C.CompanyName, C.Country , C.ContactName
                  FROM Customers as C WHERE NOT EXISTS
                  (SELECT O.CustomerID FROM Orders as O 
                  WHERE C.CustomerID=O.CustomerID)
                  GO

