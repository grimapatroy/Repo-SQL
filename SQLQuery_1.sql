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
-- y 250, sin stock en almacén. Pertenecientes a las categorías 1, 3, 4, 7 y 8, que son
-- distribuidos por los proveedores 2, 4, 6, 7 y 9.

    -- aplicando producto cartesiado con condicion de reunion 

    SELECT o.ProductName, UnitPrice,c.CategoryID,p.SupplierID
    FROM Products as o , Suppliers as p , Categories as c
    WHERE o.CategoryID = c.CategoryID and o.SupplierID = p.SupplierID
    GROUP BY    o.ProductName, UnitPrice,c.CategoryID,p.SupplierID

    -- aplicando inner join 

    SELECT o.ProductName, UnitPrice,c.CategoryID,p.SupplierID
    FROM Products as o 
    JOIN Categories as c ON  o.CategoryID = c.CategoryID 
    JOIN Suppliers as p ON o.SupplierID = p.SupplierID
    -- WHERE 
    GROUP BY    o.ProductName, UnitPrice,c.CategoryID,p.SupplierID