/*1. output_customer_orders(IN customer_name VARCHAR(50), IN customer_surname VARCHAR(50))*/

select customer.first_name, customer.last_name, orders.date, orders.id as 'order_id' 
from customer, orders 
where 	customer.id = orders.customer_id and 
	customer.first_name = customer_name and 
	customer.last_name = customer_surname;
/*
2. output_order_items(IN order_id INT)
*/
select orders.id, orders.date, orders.customer_id, order_item.item_id, order_item.item_count 
from orders, order_item 
where 	order_item.order_id = orders.id and 
	orders.id = order_id;
/*
3. output_3_most_purchased_item()
*/
select item.name, item.price, sum(order_item.item_count) 
from  order_item, item 
where item.id = order_item.item_id 
group by order_item.item_id 
order by order_item.item_count DESC 
limit 0,3;
/*
4. output_category_products(IN category VARCHAR(50))
*/
select category.name as 'category', item.name as 'item_name', item.price as 'item_price' 
from category, item 
where 	item.category_id = category.id and 
	category = category.name;
/*
5. most_popular_items_in_categories()
*/
select category_name, name, price, max(item_count) 
from (
	select item.category_id, category.name as 'category_name', item.name, item.price, sum(order_item.item_count) as 'item_count' 
	from  order_item, item, category 
	where 	item.id = order_item.item_id and 
		item.category_id = category.id 
	group by order_item.item_id 
	order by item_count DESC) general_count 
group by category_id;
/*
6. output_most_popular_item_of_month(IN month_num INT)
*/
select item.name, item.price, sum(order_item.item_count) 
from  order_item, item, orders 
where 	item.id = order_item.item_id 
	and order_item.order_id = orders.id and
	month(orders.date) = month_num 
group by order_item.item_id 
order by order_item.item_count DESC 
limit 1;
/*
7. output_order_cost(IN order_id INT)
*/
select order_item.order_id, ROUND((sum(order_item.item_count * item.price) * 1.10),2) as 'cost' 
from item, order_item 
where 	item.id = order_item.item_id and 
	order_item.order_id = order_id 
group by order_item.order_id;
