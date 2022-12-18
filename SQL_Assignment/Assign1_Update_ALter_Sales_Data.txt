show databases;
Use FIRSTDEMO;
SELECT * FROM MS_sales_data;

CREATE Or replace Table MS_sales_data
(
order_id String ,
order_date date PRIMARY KEY,ship_date date,  ----Order date as PK--- DATA tUPE SHOULD BE DATE
ship_mode varchar(20),
customer_name varchar(30),
segment varchar(20),
state string,country varchar(40),
market varchar(20),region varchar(20),
product_id string,category varchar(20),
sub_category varchar(20),product_name string,
sales number, quantity number,	
discount number(10,2),profit number(10,2),
shipping_cost number(10,2),order_priority varchar(20),
year number  
);
Describe table MS_sales_data;
ALter table MS_sales_data       ---- PK drop
Drop Primary key;

ALTER table  MS_sales_data     ----- Now Order_ID is PK
add PRIMARY KEY(order_id);

Alter table MS_sales_data          --- Adding New column order_extract
Add column order_extract VARCHAR(20);

Update MS_sales_data                                   --Update the new column value 
SET order_extract=trim(substring(order_id,9,15),'');   ---trim is used for removing extra spaces

ALter table MS_sales_data                             ---Add column
Add column Discount_Flag varchar(10);

update MS_sales_data                                  ----- Update the added column
Set Discount_Flag=
(Case
    WHEN DISCOUNT>0 Then 'yes'
    Else 'No'
End);   

ALter table MS_sales_data                             ---Add column Process_days
Add column Process_days Number;

Update MS_sales_data                                    ---- days it takes for each order
Set Process_days=datediff('Day',ORDER_DATE,SHIP_DATE);

ALter table MS_sales_data                             ---Add column Rating
Add column Rating number;

Update MS_sales_data                                  ----- Updating Rating Column
Set Rating=
Case 
    When Process_days<=3 THEN 5
    WHEN Process_days>3 AND Process_days<=6 THEN 4
    WHEN Process_days>6 AND Process_days<=10 THEN 3
    ELSE 2
END;

select Process_days,Rating from MS_SALES_DATA;