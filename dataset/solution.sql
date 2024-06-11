-- Antes de empezar hacer los ejercicios primero tendriamos que crear la base de datos
use SQL_TEST_DATA;
-- Q1 : Pregunta 01: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre Título, Nombre y Apellido y Fecha de Nacimiento para cada uno de los clientes. No necesitarás hacer nada en Excel para esta
SELECT title,firstname,lastname,DateofBirth
FROM customer
;
-- Q2: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre el número de clientes en cada grupo de clientes (Bronce, Plata y Oro). Puedo ver visualmente que hay 4 Bronce, 3 Plata y 3 Oro pero si hubiera un millón de clientes ¿cómo lo haría en Excel?
SELECT 
	customergroup, 
    COUNT(customergroup) as numero_clientes
FROM 
	customer
GROUP BY 
	customergroup
;

-- Q3: El gerente de CRM me ha pedido que proporcione una lista completa de todos los datos para esos clientes en la tabla de clientes pero necesito añadir el código de moneda de cada jugador para que pueda enviar la oferta correcta en la moneda correcta. Nota que el código de moneda no existe en la tabla de clientes sino en la tabla de cuentas. Por favor, escribe el SQL que facilitaría esto. ¿Cómo lo haría en Excel si tuviera un conjunto de datos mucho más grande?
-- Ponemos el * para que seleccione todas las columnas de una misma tabla.
SELECT 
	a.*,
	b.CurrencyCode
FROM 
	customer as a
JOIN 
	ACCOUNT AS b 
ON 
	a.CustID=b.CustID
;

-- Q4:  Ahora necesito proporcionar a un gerente de producto un informe resumen que muestre, por producto y por día, cuánto dinero se ha apostado en un producto particular. TEN EN CUENTA que las transacciones están almacenadas en la tabla de apuestas y hay un código de producto en esa tabla que se requiere buscar (classid & categoryid) para determinar a qué familia de productos pertenece esto. Por favor, escribe el SQL que proporcionaría el informe. Si imaginas que esto fue un conjunto de datos mucho más grande en Excel, ¿cómo proporcionarías este informe en Excel?
SELECT 
	a.product,
    b.BetDate,
    SUM(b.Bet_Amt) as total_apostado
    
FROM 
	product as a
JOIN
	betting as b 
ON
	a.classID=b.classID 
    and 
    a.categoryID=b.categoryID
GROUP BY 
	a.product,
    b.BetDate
;

-- Q5: Acabas de proporcionar el informe de la pregunta 4 al gerente de producto, ahora él me ha enviado un correo electrónico y quiere que se cambie. ¿Puedes por favor modificar el informe resumen para que solo resuma las transacciones que ocurrieron el 1 de noviembre o después y solo quiere ver transacciones de Sportsbook. Nuevamente, por favor escribe el SQL abajo que hará esto.

SELECT 
	a.product,
    b.BetDate,
    SUM(b.Bet_Amt) as total_apostado
    
FROM 
	product as a
JOIN
	betting as b 
ON
	a.classID=b.classID 
    and 
    a.categoryID=b.categoryID
WHERE 
	b.Betdate >= '01-11-12' and 
    a.product = 'sportsbook'
GROUP BY 
	a.product,
    b.BetDate
;

-- Q6: Como suele suceder, el gerente de producto ha mostrado su nuevo informe a su director y ahora él también quiere una versión diferente de este informe. Esta vez, quiere todos los productos pero divididos por el código de moneda y el grupo de clientes del cliente, en lugar de por día y producto. También le gustaría solo transacciones que ocurrieron después del 1 de diciembre. Por favor, escribe el código SQL que hará esto.
-- El where siempre va después de todos los joins.
SELECT 
	a.product,
    c.CurrencyCode,
    d.CustomerGroup,
    SUM(b.Bet_Amt) as total_apostado
    
FROM 
	product a
JOIN
	betting as b 
ON
	a.classID=b.classID 
    and 
    a.categoryID=b.categoryID
JOIN
	account c 
ON
	b.accountNo=c.accountNo 
JOIN 
	customer d
ON
	c.CustId=d.CustId
WHERE 
	b.Betdate >= '01-12-12' and 
    a.product = 'sportsbook'
GROUP BY 
	a.product,
    c.CurrencyCode,
    d.CustomerGroup
;

-- Q7:  Nuestro equipo VIP ha pedido ver un informe de todos los jugadores independientemente de si han hecho algo en el marco de tiempo completo o no. En nuestro ejemplo, es posible que no todos los jugadores hayan estado activos. Por favor, escribe una consulta SQL que muestre a todos los jugadores Título, Nombre y Apellido y un resumen de su cantidad de apuesta para el período completo de noviembre.
SELECT 
	a.title,
    a.firstname,
    a.lastname,
    SUM(c.Bet_amt)
FROM 
	customer a
JOIN 
	account b
ON
	a.CustId=b.CustId
JOIN
	betting c
ON
	b.AccountNo=c.AccountNo
WHERE
	c.Betdate >= '01-11-12' and c.Betdate <= '30-11-12'
GROUP BY
	a.title,
    a.firstname,
    a.lastname
ORDER BY 
	a.title,
    a.firstname
;

-- Q8: Nuestros equipos de marketing y CRM quieren medir el número de jugadores que juegan más de un producto. ¿Puedes por favor escribir 2 consultas, una que muestre el número de productos por jugador y otra que muestre jugadores que juegan tanto en Sportsbook como en Vegas?
-- 8.1 Número de productos por jugador.
SELECT 
    a.title, a.firstname, a.lastname, COUNT(DISTINCT d.product) as numero_productos
FROM
    Customer a
        JOIN
    account b ON a.CustId = b.CustId
        JOIN
    betting c ON b.AccountNo = c.AccountNo
        JOIN
    product d ON c.product = d.product
WHERE 
d.product IS NOT NULL
GROUP BY a.title , a.firstname , a.lastname
;

-- 8.2 Jugadores que juegan tanto en Sportsbook como en Vegas?
SELECT 
    a.firstName, a.lastName
FROM
    customer a
        JOIN
    Account b ON a.CustId = b.CustId
        JOIN
    Betting c ON b.AccountNo = c.AccountNo
WHERE
    c.product in ('Sportsbook', 'Vegas')
GROUP BY
    a.firstName, a.lastName, a.CustId
HAVING
    COUNT(DISTINCT c.product) = 2;

-- Pregunta 09: Ahora nuestro equipo de CRM quiere ver a los jugadores que solo juegan un producto, por favor escribe código SQL que muestre a los jugadores que solo juegan en sportsbook, usa bet_amt > 0 como la clave. Muestra cada jugador y la suma de sus apuestas para ambos productos.
SELECT 
    a.firstName, a.lastName,SUM(c.bet_amt)
FROM
    customer a
        JOIN
    Account b ON a.CustId = b.CustId
        JOIN
    Betting c ON b.AccountNo = c.AccountNo
WHERE
    c.product ='Sportsbook' and c.bet_amt>0
GROUP BY
    a.firstName, a.lastName, a.CustId;

-- Pregunta 10: La última pregunta requiere que calculemos y determinemos el producto favorito de un jugador. Esto se puede determinar por la mayor cantidad de dinero apostado. Por favor, escribe una consulta que muestre el producto favorito de cada jugador
--  esta línea de código crea una columna llamada rank que asigna un número de fila a cada fila dentro de cada partición (definida por firstName y lastName), ordenada por la cantidad total apostada (total_bet)
WITH PlayerBets AS (
    SELECT 
        a.firstName, 
        a.lastName,
        c.product,
        SUM(c.bet_amt) AS total_bet
    FROM
        customer a
    JOIN
        Account b ON a.CustId = b.CustId
    JOIN
        Betting c ON b.AccountNo = c.AccountNo
    GROUP BY
        a.firstName, a.lastName, c.product
),
RankedBets AS (
    SELECT 
        firstName, 
        lastName, 
        product, 
        total_bet,
        ROW_NUMBER() OVER (PARTITION BY firstName, lastName ORDER BY total_bet DESC) AS max_apostado
    FROM
        PlayerBets
)
SELECT 
    firstName, 
    lastName, 
    product AS favorite_product 
FROM 
    RankedBets
WHERE 
    max_apostado = 1;

-- Pregunta 11: Escribe una consulta que devuelva a los 5 mejores estudiantes basándose en el GPA
SELECT 
    student_name
FROM
    student
GROUP BY student_name , GPA
ORDER BY GPA DESC
LIMIT 5;

-- Pregunta 12: Escribe una consulta que devuelva el número de estudiantes en cada escuela. (¡una escuela debería estar en la salida incluso si no tiene estudiantes!)

SELECT a.school_name,COUNT(B.school_id)
from school a
JOIN
student b on a.school_id=b.school_id
GROUP BY a.school_name;


-- Pregunta 13: Escribe una consulta que devuelva los nombres de los 3 estudiantes con el GPA más alto de cada universidad.
SELECT 
    b.student_name, a.school_name
FROM
    school a
        JOIN
    student b ON a.school_id = b.school_id
GROUP BY b.student_name , a.school_name , b.GPA;




















;