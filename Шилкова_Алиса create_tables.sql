create table job (
    job_id                SERIAL primary key unique,
    job_industry_category varchar not null,
    job_title             varchar null
);

create table address (
  address_id SERIAL primary key unique,
  address varchar not null,
  postcode	integer not null,
  state	varchar not null,
  country	varchar not null
);

create table customer (
  customer_id primary key unique,
  job_id integer references job(job_id),
  address_id integer references address,
  first_name	varchar not null,
  last_name	varchar,
  gender	varchar not null,
  DOB	varchar,
  wealth_segment	varchar not null,
  deceased_indicator	varchar not null,
  owns_car	varchar not null,
  property_valuation integer not null
);

create table product (
  product_id serial,
  product_size float,
  brand	varchar,
  product_line	varchar,
  product_class	varchar,
  product_scale	varchar,
  standard_cost float,
  primary key (product_id, product_size)
);


create table transaction (
  transaction_id	SERIAL primary key unique,
  product_id	integer not null,
  product_size	float not null,
  customer_id	integer references customer(customer_id),
  transaction_date	varchar not null,
  online_order	bool not null,
  order_status	varchar not null,
  foreign key (product_id, product_size) references product(product_id, product_size)

);
