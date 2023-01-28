CREATE TABLE salespersons (
	"salesperson_id" SERIAL,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100),
	PRIMARY KEY ("salesperson_id")
);

CREATE TABLE cars (
	"car_id" SERIAL,
	"make" VARCHAR(100),
	"model" VARCHAR(100),
	"year" INTEGER,
	"mileage" INTEGER,
	"dealer_owned" BOOLEAN,
	PRIMARY KEY ("car_id")
);

CREATE TABLE customers (
	"customer_id" SERIAL,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100),
	PRIMARY KEY ("customer_id")				
);

CREATE TABLE sales_invoices (
	"sales_id" SERIAL,
	"sold_date" TIMESTAMP,
	"amount" NUMERIC (10,2),
	"salesperson_id" INTEGER REFERENCES salespersons("salesperson_id"),
	"car_id" INTEGER REFERENCES "cars"("car_id"),
	"customer_id" INTEGER REFERENCES "customers"("customer_id"),
	PRIMARY KEY ("sales_id")
);

CREATE TABLE service_invoices (
	"service_id" SERIAL,
	"service_date" TIMESTAMP,
	"amount" NUMERIC (10,2),
	"service_type" TEXT,
	"customer_id" INTEGER REFERENCES customers("customer_id"),
	"car_id" INTEGER REFERENCES cars("car_id"),
	PRIMARY KEY ("service_id")     
);

CREATE TABLE mechanics (
	"mechanic_id" SERIAL,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100),
	PRIMARY KEY ("mechanic_id")
);

CREATE TABLE service_tickets (
	"ticket_id" SERIAL,
	"mechanic_id" INTEGER REFERENCES mechanics("mechanic_id"),
	"service_id" INTEGER REFERENCES "service_invoices"("service_id"),
	PRIMARY KEY ("ticket_id")
);

CREATE TABLE dealer_inventory (
	"inventory_id" SERIAL,
	"used_new" BOOLEAN,
	"purchased_date" TIMESTAMP,
	"purchased_price" NUMERIC (10,2),
	"sale_price" NUMERIC (10,2),
	"days_in_lot" INTERVAL,
	"car_id" INTEGER REFERENCES "cars"("car_id"),
	PRIMARY KEY ("inventory_id")    
);

