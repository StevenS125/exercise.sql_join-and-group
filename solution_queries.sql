-- Part 1
-- Write a query to display each customer’s name (asCustomer Name) alongside the name of the employee who is responsible for that customer’s orders.
-- The employee name should be in a single Sales Rep column formatted as lastName, firstName. The output should be sorted alphabetically by customer name.

SELECT customers.customerName, CONCAT(employees.lastName,", ", employees.firstName) AS Sales_Rep
FROM CUSTOMERS 
LEFT JOIN EMPLOYEES ON CUSTOMERS.salesRepEmployeeNumber=employees.employeeNumber 
ORDER BY customers.customerName ASC;


-- Part 2
-- Determine which products are most popular with our customers.
-- For each product, list the total quantity ordered along with the total sale generated (total quantity ordered * priceEach) for that product.
-- The column headers should be Product Name, Total # Ordered and Total Sale.
-- List the products by Total Sale descending.

SELECT * FROM products;
SELECT * FROM payments;
SELECT * FROM orderdetails;
SELECT productName AS 'Product Name',(quantityOrdered * priceEach) AS 'Total sale' 
FROM products JOIN orderdetails ON products.productcode=orderdetails.productcode 
ORDER BY  (quantityOrdered * priceEach) desc;

-- Part 3
-- Write a query which lists order status and the # of orders with that status.
-- Column headers should be Order Status and # Orders.
-- Sort alphabetically by status.

SELECT status AS "ORDER STATUS", count(*) AS "# ORDERS" FROM orders GROUP BY STATUS ORDER BY STATUS ASC;




-- Part 4
-- Write a query to list, for each product line, the total # of products sold from that product line.
-- The first column should be Product Line and the second should be # Sold.
-- Order by the second column descending.

SELECT products.productLine AS 'Product Line', sum(quantityOrdered) AS '#Sold'
FROM products 
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN productlines ON productlines.productLine = products.productLine
GROUP BY products.productline
ORDER BY sum(quantityOrdered) DESC;

-- Part 5
-- For each employee who represents customers, output the total # of orders that employee’s customers have placed alongside the total sale amount of those orders.
-- The employee name should be output as a single column named Sales Rep formatted as lastName, firstName.
-- The second column should be titled # Orders and the third should be Total Sales.
-- Sort the output by Total Sales descending.
-- Only (and all) employees with the job title Sales Rep should be included in the output, and if the employee made no sales the Total Sales should display as 0.00.

SELECT CONCAT(employees.lastName,employees.firstName) AS 'Sales Rep',
COUNT(quantityOrdered) AS  '#ORDERS',
IFNULL((quantityOrdered*priceEach), 0.00) AS 'Total Sales'
FROM employees 
LEFT JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
LEFT JOIN orders ON customers.customerNumber=orders.customerNumber
LEFT JOIN orderdetails ON orders.orderNumber=orderdetails.orderNumber
WHERE employees.jobTitle = 'Sales Rep'
GROUP BY CONCAT(employees.employeeNumber) ,'#ORDERS'
ORDER BY (quantityOrdered*priceEach)  DESC;

-- Part 6
-- Your product team is requesting data to help them create a bar-chart of monthly sales since the company’s inception.
-- Write a query to output the month (January, February, etc.), 4-digit year, and total sales for that month.
-- The first column should be labeled Month, the second Year, and the third should be Payments Received.
-- Values in the third column should be formatted as numbers with two decimals – for example: 694,292.68.
SELECT MONTHNAME(paymentdate) AS Month,extract(year FROM paymentdate) AS Year, sum(amount) AS 'Payments Received'
FROM payments GROUP BY 1,2 ORDER BY Year(paymentdate), MONTH(paymentdate) ASC;