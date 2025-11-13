-- job
select job_title, job_industry_category from customer_original group by 1, 2

-- address
select address, postcode, state, country from customer_original group by 1, 2, 3, 4

--customer
select   customer_id	,
  job_id,
  address_id ,
  first_name,
  last_name,
  gender,
  "DOB",
  wealth_segment,
  deceased_indicator,
  owns_car,
  property_valuation from customer_original co
  -- для отображения в customer соответствующих внешних ключей job_id и address_id
  left join job on (job.job_title = co.job_title and job.job_industry_category = co.job_industry_category)  
  left join address on (
  							address.address = co.address 
  							and address.postcode = co.postcode 
  							and address.state = co.state 
  							and address.country = co.country 
  							)  
 
-- product
select product_id, product_size, brand,product_line, product_class, product_scale, standard_cost from transaction_original group by 1, 2, 3, 4, 5, 6, 7

-- transaction
select transaction_id, customer_id, product_id, product_size, customer_id, transaction_date, online_order, order_status from transaction_original;