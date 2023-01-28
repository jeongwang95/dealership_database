-- populating salespersons table
CREATE OR REPLACE FUNCTION add_salesperson(
	_first_name VARCHAR(100),
	_last_name VARCHAR(100)
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO salespersons (first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$$ LANGUAGE plpgsql;

SELECT add_salesperson('Lola', 'Brice');
SELECT add_salesperson('Shelley', 'King');
SELECT add_salesperson('Terrance', 'Elwin');
SELECT add_salesperson('Kristin', 'Young');

SELECT *
FROM salespersons;

-- populating customers table
CREATE OR REPLACE FUNCTION add_customer(
	_first_name VARCHAR(100),
	_last_name VARCHAR(100)
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO customers (first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$$ LANGUAGE plpgsql;

SELECT add_customer('Zackary', 'Gage');
SELECT add_customer('Clair', 'Hart');
SELECT add_customer('Toria', 'Power');
SELECT add_customer('Harding', 'Northrop');
SELECT add_customer('Krystal', 'Nielson');

SELECT *
FROM customers;

-- populating mechanics table
CREATE OR REPLACE FUNCTION add_mechanic(
	_first_name VARCHAR(100),
	_last_name VARCHAR(100)
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO mechanics (first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$$ LANGUAGE plpgsql;

SELECT add_mechanic('Ross', 'Savage');
SELECT add_mechanic('Terry', 'Young');
SELECT add_mechanic('Dianna', 'Bradford');
SELECT add_mechanic('Clayton', 'Harding');

SELECT *
FROM mechanics;

-- populating cars table
CREATE OR REPLACE FUNCTION add_car(
	_make VARCHAR(100),
	_model VARCHAR(100),
	_year INTEGER,
	_mileage INTEGER,
	_dealer_owned BOOLEAN
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO cars (make, model, "year", mileage, dealer_owned)
	VALUES(_make, _model, _year, _mileage, _dealer_owned);
END;
$$ LANGUAGE plpgsql;

SELECT add_car('Toyota', 'Prius', 2023, 0, true);
SELECT add_car('Toyota', 'Crown', 2023, 0, true);
SELECT add_car('BMW', '330i', 2019, 45000, true);
SELECT add_car('Lexus', 'RX', 2020, 40000, false);
SELECT add_car('Toyota', 'RAV4', 2017, 70000, false);
SELECT add_car('Toyota', 'Camry Hybird', 2022, 12000, false);
SELECT add_car('Toyota', 'GR Supra', 2023, 0, false);
SELECT add_car('Nissan', 'Altima', 2012, 120000, false);
SELECT add_car('Toyota', 'Tundra', 2023, 0, true);
SELECT add_car('Hyundai', 'Sonata', 2020, 37000, true);
SELECT add_car('Toyota', 'Highlander', 2023, 0, true);

SELECT *
FROM cars;

-- populating sales_invoices table
CREATE OR REPLACE FUNCTION add_sales_invoice(
	_sold_date TIMESTAMP,
	_amount NUMERIC(10,2),
	_salesperson_id INTEGER,
	_car_id INTEGER,
	_customer_id INTEGER
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO sales_invoices (sold_date, amount, salesperson_id, car_id, customer_id)
	VALUES(_sold_date, _amount, _salesperson_id, _car_id, _customer_id);
END;
$$ LANGUAGE plpgsql;

SELECT add_sales_invoice('2017-08-08 13:30:00', 35000, 4, 5, 2);
SELECT add_sales_invoice('2020-12-01 18:00:00', 15000, 2, 8, 2);
SELECT add_sales_invoice('2022-10-20 16:15:00', 55000, 1, 4, 3);
SELECT add_sales_invoice(LOCALTIMESTAMP, 50000, 1, 7, 1);
SELECT add_sales_invoice('2023-1-27 19:54:00', 47500, 3, 11, 5);

SELECT *
FROM sales_invoices;

-- populating service_invoices table
CREATE OR REPLACE FUNCTION add_service_invoice(
	_service_date TIMESTAMP,
	_amount NUMERIC(10,2),
	_service_type TEXT,
	_customer_id INTEGER,
	_car_id INTEGER
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO service_invoices (service_date, amount, service_type, customer_id, car_id)
	VALUES(_service_date, _amount, _service_type, _customer_id, _car_id);
END;
$$ LANGUAGE plpgsql;

SELECT add_service_invoice('2017-11-08 10:30:00', 50, 'oil change', 2,5);
SELECT add_service_invoice('2021-11-30 8:00:00', 1200, 'brake change', 2, 8);
SELECT add_service_invoice('2023-1-11 11:11:00', 90, 'oil change & tire rotation', 3, 4);
SELECT add_service_invoice('2023-1-24 9:15:00', 100, 'flat tire fix', 4, 6);
SELECT add_service_invoice('2023-3-3 7:45:00', 0, 'recall', 1, 7);

SELECT *
FROM service_invoices;

-- populating service_tickets table
CREATE OR REPLACE FUNCTION add_service_ticket(
	_mechanic_id INTEGER,
	_service_id INTEGER
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO service_tickets (mechanic_id, service_id)
	VALUES(_mechanic_id, _service_id);
END;
$$ LANGUAGE plpgsql;

SELECT add_service_ticket(1,1);
SELECT add_service_ticket(2,2);
SELECT add_service_ticket(3,3);
SELECT add_service_ticket(3,4);
SELECT add_service_ticket(4,4);
SELECT add_service_ticket(1,5);

SELECT *
FROM service_tickets;

-- populating dealer_inventory table
CREATE OR REPLACE FUNCTION add_dealer_inventory(
	_used BOOLEAN,
	_purchased_date TIMESTAMP,
	_purchased_price NUMERIC(10,2),
	_sale_price NUMERIC(10,2),
	_days_in_lot INTERVAL,
	_car_id INTEGER
)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO dealer_inventory (used, purchased_date, purchased_price, sale_price, days_in_lot, car_id)
	VALUES(_used, _purchased_date, _purchased_price, _sale_price, _days_in_lot, _car_id);
END;
$$ LANGUAGE plpgsql;

SELECT add_dealer_inventory(true, '2022-12-12 8:00:00', 15000, 22000, '46 days', 3);
SELECT add_dealer_inventory(false, '2023-1-10 8:00:00', 25000, 40000, '15 days', 1);
SELECT add_dealer_inventory(false, '2023-1-10 8:00:00', 30000, 45000, '15 days', 2);
SELECT add_dealer_inventory(false, '2023-1-10 8:00:00', 33000, 48000, '15 days', 11);
SELECT add_dealer_inventory(false, LOCALTIMESTAMP, 45000, 65000, '0 days', 9);
SELECT add_dealer_inventory(true, '2023-1-27 19:54:00', 12000, 18000, '0 days', 10);

SELECT *
FROM dealer_inventory;