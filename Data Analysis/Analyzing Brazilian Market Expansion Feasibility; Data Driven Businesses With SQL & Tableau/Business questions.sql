#Before deciding if Eniac is to partner with Magist, we have to answer some business questions:

# NUMBER OF ORDER
SELECT 
    COUNT(*) AS orders_count
FROM
    orders;
    
#NUMBER OF DELIVERED ORDERS
    
SELECT 
    order_status, 
    COUNT(*) AS orders
FROM
    orders
GROUP BY order_status;

#IS MAGIST HAVING AN USER GROWTH?

SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;
 #There has been an increase in Magist user growth in 2017, but in September and October of 2018, it dropped drastically. 

# How many products are there in the products table?

SELECT 
    COUNT(DISTINCT product_id) AS products_count
FROM
    products;
    # = 32951
    
#Which are the categories with most products?

SELECT 
    product_category_name, 
    COUNT(DISTINCT product_id) AS n_products
FROM
    products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;


#How many of those products were present in actual transactions?

SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;
    # = 32951
    
#What’s the price for the most expensive and cheapest products?

SELECT 
    MIN(price) AS cheapest, 
    MAX(price) AS most_expensive
FROM 
	order_items;
    # cheapest = 0.85
    #expensive = 6735
    
# What are the highest and lowest payment values?

SELECT 
	MAX(payment_value) as highest,
    MIN(payment_value) as lowest
FROM
	order_payments; 
    #highest = 13664.1
    #lowest = 0
     
    
#In relation to the sellers:

#How many months of data are included in the magist database?
SELECT timestampdiff(month,  min(order_purchase_timestamp),max(order_purchase_timestamp))
from orders;
   # = 25

#How many sellers are there?
select distinct 
count(seller_id) 
from sellers;
   # = 3095

#How many Tech sellers are there? 
SELECT 
       CASE #Column Big_category
           WHEN product_category_name LIKE 'ele%' THEN 'tech_category'
           WHEN product_category_name LIKE 'info%' THEN 'tech_category'
           WHEN product_category_name LIKE 'pc%' THEN 'tech_category'
           WHEN product_category_name LIKE 'tel%' THEN 'tech_category'
           WHEN product_category_name = 'audio' THEN 'tech_category'
           ELSE 'not_tech'
       END AS big_category,
	count(distinct seller_id) as seller_counter
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY big_category
Having big_category = 'tech_category'
ORDER BY big_category;
  # = 584

 #What percentage of overall sellers are Tech sellers? 
 SELECT(584/3095*100);
   # = 18.87
 
 #What is the total amount earned by all sellers?
 select round(sum(price))
 from order_items;
     # = 13591644
 #What is the total amount earned by Tech Sellers?
 SELECT 
       CASE #Column Big_category
           WHEN product_category_name LIKE 'ele%' THEN 'tech_category'
           WHEN product_category_name LIKE 'info%' THEN 'tech_category'
           WHEN product_category_name LIKE 'pc%' THEN 'tech_category'
           WHEN product_category_name LIKE 'tel%' THEN 'tech_category'
           WHEN product_category_name = 'audio' THEN 'tech_category'
           ELSE 'not_tech'
       END AS big_category,
	round(sum(price)) as total_tech_amount
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY big_category
Having big_category = 'tech_category'
ORDER BY big_category;

    # = 2114787
 
#Average monthly income of All Sellers
SELECT 13591644/ 3095 / 25;
	# = 175.66

 #Average monthly income earned by Tech sellers
 SELECT 2114787/ 584 / 25;
 # = 144.8
  

