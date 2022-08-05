-- Mostrar el segundo producto con el mayor precio
SELECT p.ProductName
    , p.UnitPrice
FROM Products AS p
ORDER BY p.UnitPrice DESC OFFSET 1 ROWS

FETCH NEXT 1 ROW ONLY
GO

-- Ejercicio 1
SELECT *
FROM Customers AS c
ORDER BY c.ContactName ASC
GO

-- Ejercicio 2
SELECT *
FROM Orders AS O
ORDER BY O.OrderDate DESC

-- Ejercicio 3
SELECT *
FROM [Order Details] AS DO
ORDER BY DO.Quantity ASC

-- Ejercicio 4
SELECT *
FROM Products AS P
WHERE P.ProductName LIKE 'p%'
    AND P.UnitPrice BETWEEN 10 AND 20
GO

-- Ejercicio 5
SELECT C.CompanyName
    , C.Country
FROM Customers AS C
WHERE C.Country IN ('France', 'UK', 'USA')
ORDER BY C.Country ASC
GO

-- Ejercicio 6
SELECT P.ProductID
    , P.ProductName
    , P.UnitsInStock
    , P.Discontinued
FROM Products AS P
WHERE P.Discontinued <> 1
    AND P.UnitsInStock = 0
GO

-- Ejercicio 7
SELECT E.EmployeeID, E.FirstName , O.OrderDate
FROM Employees AS E
INNER JOIN Orders AS O
    ON E.EmployeeID = O.EmployeeID
WHERE E.EmployeeID IN (2,5,7) AND YEAR(O.OrderDate) =1996
GO

-- Ejercicio 8
SELECT  C.CompanyName , C.Fax
FROM Customers as C
WHERE c.Fax <> 'Null'
GO

-- Ejercicio 9
SELECT  C.CompanyName , C.Fax , C.Country
FROM Customers as C
WHERE c.Fax is Null AND C.Country='USA'
GO

-- Ejercicio 10
SELECT E.FirstName + '' + E.LastName  as Nombre , E.ReportsTo as JEFE
FROM Employees as E 
WHERE E.ReportsTo  is not Null
GO

-- Ejercicio 11
SELECT *
FROM Customers as C
WHERE C.CompanyName LIKE '%abcdef%'
GO


-- Ejercicio 12
SELECT * 
FROM Customers as C
WHERE C.CompanyName NOT LIKE '[b-g]%' AND C.Country = 'UK'
-- WHERE C.CompanyName NOT LIKE '%%' AND C.Country = 'UK'
GO








