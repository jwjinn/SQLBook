
# 1. 칼럼 조회: classicmodel.customers의 customerNumber를 조회

use classicmodels;

SELECT customerNumber 
from customers c;

# 2. 상품 갯수를 전달해주세요.

SELECT count(productCode)
from products;

# 3. classicmodels.payments의 amount 총합과 checknumber 개수를 구하세요.

SELECT sum(amount), count(checkNumber)
from payments p;

# 4. products의 productName, productline을 조회.

SELECT productName, productLine 
from products p;

# 5. products의 productCode의 개수를 구하고 칼럼 명을 n_products로 변경

SELECT count(productCode) as "n_products"
from products p;

# 6. orderdetails의 ordernumber의 중복을 제거하고 조회하세요.

select DISTINCT orderNumber 
from orderdetails o;

# 6. orderdetail의 priceeach가 30에서 50사이인 데이터를 조회하세요.

SELECT *
from orderdetails o 
where priceEach BETWEEN 30 and 50;

# 7. orderdetails의 priceach가 30이상인 데이터를 조회하세요.

SELECT *
from orderdetails o 
where priceEach >= 30;

# 8. customers의 country가 USA 또는 Canada인 customernumber를 조회.
SELECT customerNumber 
from customers c 
where country in ('USA', 'Canada');

SELECT customerNumber 
from customers c
where (country = 'USA') or (country = 'Canada');

# 9. customers의 country가 USA, Canada가 아닌 customernumber를 조회.

SELECT customerNumber 
from customers c 
where country not in ('USA', 'Canada');

# 10. employees의 reportsTo의 값이 Null인 employnumber를 조회하세요.

SELECT employeeNumber 
from employees e 
where reportsTo is null;

# 11. customers의 addresline1에 ST가 포함된 addressline1을 출력

SELECT addressLine1 
from customers c 
where addressLine1 like '%ST%';

# 12. customers 테이블을 이용해 국가, 도시별 고객 수를 구하세요.
# coutry, city의 모든 경우의 테이블에서(해당 경우에 관한 테이블이 독립적으로 있다고 생각하는 것이 편함.) 각각의 독립적인 테이블에 공통적으로 부여할 집계함수는?

SELECT country, city, count(customerNumber) n_customers
from customers c
group by country, city;

# 13. customers 테이블을 이용해 USA 거주자의 수를 계산하고 그 비중을 구하세요.

# 2개를 동시에 + 산술 계산을 해야하다보니 sum과 case when을 사용해야 한다.
SELECT count(*)
from customers c
where country = 'USA';

SELECT sum(case when country = 'USA' then 1 else 0 end) n_usa,
sum(case when country = 'USA' then 1 else 0 end)/count(*) usa_portion
from customers c;

# 14. customers, orders 테이블을 결합하고 ordernumber와 country를 출력하세요.

SELECT  c.country, o.orderNumber 
from customers c left join orders o on c.customerNumber = o.customerNumber;


# 15. customers, orders 테이블을 이용해 USA 거주자의 주문 번호, 국가를 출력하세요.

SELECT c.country, o.orderNumber 
from customers c left join orders o on c.customerNumber = o.customerNumber 
where c.country = 'USA';

# 16. customers, orders 테이블으 이용해 USA 거주자의 주문 번호, 국가를 출력하세요.

SELECT o.orderNumber , c.country 
from customers c inner join orders o on c.customerNumber = o.customerNumber
where c.country = 'USA';


# 17. customers의 country 칼럼을 이용해 북미(Canada, USA), 비북미를 출력하는 칼럼을 생성.

SELECT country, case when country in ('Canada', 'USA') then 'North America' else 'others' end as region
from customers c;

# 18. customers의 country 칼럼을 이용해 북미, 비북미를 출력하는 칼럼을 생성하고 북미, 비북미 거주 고객의 수를 계산하세요.

SELECT country, case when country in ('Canada', 'USA') then 'North America' else 'others' end as region, count(customerNumber) n_customers
from customers c
group by case when country in ('Canada', 'USA') then 'North America' else 'others' end;


# partition BY 범위 설정, ~  별 순위
# 19. classicmodels.products  buyprice 컬럼으로 순위를 매겨주세요.

SELECT buyPrice,
ROW_NUMBER() over (order by buyprice) rownumber,
RANK() over (order by buyprice) rnk,
DENSE_RANK () over (order by buyprice) DENSE_RNK
from products;

# 20. classicmodels.customers와 orders를 이용해 USA 거주자의 주문 번호를 출력하세요.

SELECT orderNumber 
from orders o 
where customerNumber IN (
SELECT customerNumber 
from customers c
where country = 'USA');