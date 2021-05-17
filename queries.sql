-- Database: Supermarket

-- DROP DATABASE "Supermarket";

CREATE DATABASE "Supermarket"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	
	insert into Employees (first_name, last_name, phone_number, job)
	values('piyush', 'vashisht', '9876762344', 'Warehouse keeper'),
('saksham', 'vats', '7876762344', 'customer assistance'),
('neelima' ,'pandey', '8876762344', 'Warehouse keeper');

	Insert into Products(product_name, manufacturer,cost_price, supplier_id, quantity, category_id, selling_price)
	values('Mad angles', 'ITC', 18,2,0,4,20);

	select * from supplier
	
	/*Query Staff using name or phone number or both*/
	
	select * from Employees where 
	first_name='Amrita'
	
	
	select * from Employees where 
	phone_number='7988964343';
	
	select * from Employees where 
	first_name='Amrita' AND phone_number='9675889749'
	
	/*Query Staff using their Role*/
	select * from Employees where 
	job='cashier';
	
	
	select * from Products
	select * from Inventory
	
	insert into Inventory(product_id,category_id, quantity)
	values(6,4,0);
	
	/*Query Product based on -*/

/*a. Name	*/	
	select * from Products
	where product_name='Frooti';

/*b. Category*/
	select * from Products
	where category_id= 1

/* c. InStock, OutOfStock*/

select  Inventory.product_id, Products.product_name, Inventory.quantity from Inventory
full join Products on Inventory.product_id=Products.product_id
where Inventory.quantity >0 

/* d. SP less than, greater than or between */

select * from products 
where selling_price <30


select * from products 
where selling_price >20


select * from products 
where selling_price between 20 AND 30;

/* Number of Products out of stock*/
select  Inventory.product_id, Products.product_name, Inventory.quantity from Inventory
full join Products on Inventory.product_id=Products.product_id
where Inventory.quantity =0 


select * from Category

/* Number of Products within a category*/

select * from Products
join Category on Products.category_id=category.category_id


select count(Products.product_id), category.category_code from Products
Join Category on  Products.category_id=Category.category_id
group by  category.category_code;


/*Product-Categories listed in descending with highest number of products to the lowest*/
select category.category_code, category.category_name, Inventory.quantity from Inventory
Join Category on category.category_id=Inventory.category_id
order by Quantity desc


/*List of Suppliers - */

/* a. Name */

select * from supplier
where supplier_name='OM supplier'

/* 	b. Phone	*/
select * from supplier
where phone='7823217276';

/*	c. Email */
select * from supplier
where email='Rathore@hotmail.com'
/*	d. City or State	*/

select * from supplier 
where city like 'gurgaon';


create Table PurchaseOrder (
	purchase_id serial primary key,
	product_id int references Products(product_id),
	supplier_id int references supplier(supplier_id),
	porder_date date not NULL
)

select * from PurchaseOrder

Insert Into PurchaseOrder (product_id, supplier_id, porder_date )
values (1,1, '2021-04-29'),
(1,2, '2021-04-28'),
(2,5, '2021-04-19'),
(6,5, '2021-04-18'),
(3,3, '2021-05-13'),
(4,4, '2021-05-17');

alter table supplier
drop column porder_date

/*	List of Product with different suppliers, with the recent date of supply and the amount supplied on the most recent occasion.	*/

select supplier.supplier_name, Products.product_name,Products.quantity, Purchaseorder.purchase_id, Purchaseorder.porder_date from PurchaseOrder
join Products on Products.product_id=PurchaseOrder.product_id
join supplier on supplier.supplier_id= PurchaseOrder.supplier_id
order by porder_date desc



/*Here this can also be filtered based on -*/
/*Product Name*/
select supplier.supplier_name, Products.product_name,Products.quantity, Purchaseorder.purchase_id, Purchaseorder.porder_date from PurchaseOrder
join Products on Products.product_id=PurchaseOrder.product_id
join supplier on supplier.supplier_id= PurchaseOrder.supplier_id
where Products.product_name like 'Frooti'
order by porder_date desc;

/*Supplier Name*/

select supplier.supplier_name, Products.product_name,Products.quantity, Purchaseorder.purchase_id, Purchaseorder.porder_date from PurchaseOrder
join Products on Products.product_id=PurchaseOrder.product_id
join supplier on supplier.supplier_id= PurchaseOrder.supplier_id
where supplier.supplier_name like 'Vitran Distributor'
order by porder_date desc;


/*Product Code*/
select supplier.supplier_name, Products.product_name,Products.quantity, Purchaseorder.purchase_id, Purchaseorder.porder_date from PurchaseOrder
join Products on Products.product_id=PurchaseOrder.product_id
join supplier on supplier.supplier_id= PurchaseOrder.supplier_id
where products.product_id =6
order by porder_date desc;

/*Supplied after a particular date*/

select supplier.supplier_name, Products.product_name,Products.quantity, Purchaseorder.purchase_id, Purchaseorder.porder_date from PurchaseOrder
join Products on Products.product_id=PurchaseOrder.product_id
join supplier on supplier.supplier_id= PurchaseOrder.supplier_id
where porder_date > '2021-04-29'
order by porder_date desc;

/* Supplied before a particular date 	*/

select supplier.supplier_name, Products.product_name,Products.quantity, Purchaseorder.purchase_id, Purchaseorder.porder_date from PurchaseOrder
join Products on Products.product_id=PurchaseOrder.product_id
join supplier on supplier.supplier_id= PurchaseOrder.supplier_id
where porder_date < '2021-04-29'
order by porder_date desc;

/*Product has inventory more than or less than a given qty*/

select supplier.supplier_name, Products.product_name,Products.quantity, Purchaseorder.purchase_id, Purchaseorder.porder_date ,
Inventory.quantity	from PurchaseOrder
join Products on Products.product_id=PurchaseOrder.product_id
join supplier on supplier.supplier_id= PurchaseOrder.supplier_id
join Inventory on Inventory.product_id= PurchaseOrder.product_id
where Inventory.quantity >36
order by porder_date desc;