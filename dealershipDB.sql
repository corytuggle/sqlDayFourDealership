-- Creates

CREATE TABLE parts (
	part_id SERIAL PRIMARY KEY,
	part_name VARCHAR(150),
	part_count INTEGER,
	part_price NUMERIC(10,2)
);

CREATE TABLE salesperson (
	sales_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

CREATE TABLE mechanic (
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

CREATE TABLE service_code (
	serv_code_id SERIAL PRIMARY KEY,
	serv_desc VARCHAR(300),
	serv_sub NUMERIC(10,2),
	part_id INTEGER NOT NULL,
	FOREIGN KEY (part_id) REFERENCES parts(part_id)
);

CREATE TABLE service_tix (
	serv_id SERIAL PRIMARY KEY,
	serv_date DATE DEFAULT CURRENT_DATE,
	serv_sub NUMERIC(10,2),
	serv_cost NUMERIC(10,2),
	serv_code_id INTEGER NOT NULL,
	FOREIGN KEY (serv_code_id) REFERENCES service_code(serv_code_id)
);

CREATE TABLE invoice (
	invoice_id SERIAL PRIMARY KEY,
	order_date DATE DEFAULT CURRENT_DATE,
	price NUMERIC(10,2),
	down_payment NUMERIC(10,2),
	taxes NUMERIC(10,2),
	sales_id INTEGER NOT NULL,
	FOREIGN KEY (sales_id) REFERENCES salesperson(sales_id)
);

CREATE TABLE customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	payment_info VARCHAR(200),
	invoice_id INTEGER NOT NULL,
	serv_id INTEGER NOT NULL,
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
	FOREIGN KEY (serv_id) REFERENCES service_tix(serv_id)
);

CREATE TABLE car (
	car_id SERIAL PRIMARY KEY,
	year_ INTEGER,
	make VARCHAR(50),
	model VARCHAR(50),
	color VARCHAR(50),
	invoice_id INTEGER NOT NULL,
	sales_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	serv_id INTEGER NOT NULL,
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
	FOREIGN KEY (sales_id) REFERENCES salesperson(sales_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (serv_id) REFERENCES service_tix(serv_id)
);

CREATE TABLE dealership (
	dealer_id SERIAL PRIMARY KEY,
	address VARCHAR(250),
	sales_id INTEGER NOT NULL,
	invoice_id INTEGER NOT NULL,
	mechanic_id INTEGER NOT NULL,
	serv_id INTEGER NOT NULL,
	part_id INTEGER NOT NULL,
	FOREIGN KEY (sales_id) REFERENCES salesperson(sales_id),
	FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
	FOREIGN KEY (serv_id) REFERENCES service_tix(serv_id),
	FOREIGN KEY (part_id) REFERENCES parts(part_id)
);

-- Inserts

INSERT INTO parts (part_id, part_name, part_count, part_price)
VALUES (80001, 'Oil', 500, 25.00);

INSERT INTO parts (part_id, part_name, part_count, part_price)
VALUES (80002, 'Tire', 2000, 100.00);

INSERT INTO parts (part_id, part_name, part_count, part_price)
VALUES (81000, 'Customer/Vehicle Supplied', 0, 0.00);

INSERT INTO salesperson (sales_id, first_name, last_name)
VALUES (10001, 'John', 'Williamson');

INSERT INTO salesperson (sales_id, first_name, last_name)
VALUES (10002, 'Jacob', 'Jefferson');

INSERT INTO mechanic (mechanic_id, first_name, last_name)
VALUES (20001, 'Jingleheimer', 'Pulliam');

INSERT INTO mechanic (mechanic_id, first_name, last_name)
VALUES (20002, 'Schmitt', 'Finley');

INSERT INTO service_code (serv_code_id, serv_desc, serv_sub, part_id)
VALUES (70001, 'Oil Change', 30.00, 80001);

INSERT INTO service_code (serv_code_id, serv_desc, serv_sub, part_id)
VALUES (70002, 'New Tire', 120.00, 80002);

INSERT INTO service_code (serv_code_id, serv_desc, serv_sub, part_id)
VALUES (71000, 'Tire Rotation', 0.00, 81000);

INSERT INTO service_tix (serv_id, serv_date, serv_sub, serv_cost, serv_code_id)
VALUES (60001, '2021-12-31', 30.00, 30.00, 70001);

INSERT INTO service_tix (serv_id, serv_date, serv_sub, serv_cost, serv_code_id)
VALUES (60002, '2022-06-12', 240.00, 270.00, 70002);

INSERT INTO service_tix (serv_id, serv_sub, serv_cost, serv_code_id)
VALUES (60003, 0.00, 0.00, 71000);

INSERT INTO invoice (invoice_id, order_date, price, down_payment, taxes, sales_id)
VALUES (50001, '2019-01-19', 25999.39, 6000.00, 1819.96, 10001);

INSERT INTO invoice (invoice_id, order_date, price, down_payment, taxes, sales_id)
VALUES (50002, '2019-08-05', 39999.69, 8000.00, 2799.98, 10002);

INSERT INTO invoice (invoice_id, price, down_payment, taxes, sales_id)
VALUES (50003, 17499.99, 3500.00, 1225.00, 10001);

INSERT INTO customer (customer_id, first_name, last_name, payment_info, invoice_id, serv_id)
VALUES (30001, 'Charles', 'Xavier', 'ACCT:00123456789 RT#:987654321 CHK#:1234', 50002, 60003);

INSERT INTO customer (customer_id, first_name, last_name, payment_info, invoice_id, serv_id)
VALUES (30002, 'Erik', 'Lensher', 'ACCT:00321654987 RT#:987654321 CHK#:9876', 50001, 60001);

INSERT INTO car (car_id, year_, make, model, color, invoice_id, sales_id, customer_id, serv_id)
VALUES (40001, 2020, 'Leekirb', 'Mutant', 'Cobalt Blue', 50002, 10002, 30001, 60003);

INSERT INTO car (car_id, year_, make, model, color, invoice_id, sales_id, customer_id, serv_id)
VALUES (40002, 2019, 'Leekirb', 'Magnet', 'Muted Magenta', 50001, 10001, 30002, 60001);

INSERT INTO dealership (dealer_id, address, sales_id, invoice_id, mechanic_id, serv_id, part_id)
VALUES (00001, '1963 Lee-Kirby Parkway, Eastwalnut, New York, 55555', 10001, 50001, 20001, 60001, 80001);

INSERT INTO dealership (dealer_id, address, sales_id, invoice_id, mechanic_id, serv_id, part_id)
VALUES (00002, '1407 Graymalkin Lane, Salem Center, Westchester County, New York, 55555', 10002, 50002, 20002, 60002, 80002);


SELECT * FROM ;

-- In hindsight, I definitely see where I messed up logically by applying too many foreign keys. 
-- The data all works and is inserted correctly, but I can see how this would spiral into chaos if the DB was actually assembled this way