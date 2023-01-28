LTER TABLE cars
ADD COLUMN is_serviced BOOLEAN;

-- change is_serviced column in cars 
-- if the car got serviced from the dealership
CREATE OR REPLACE PROCEDURE check_service()
AS $$
BEGIN
	UPDATE cars
	SET is_serviced = false;
	
	UPDATE cars
	SET is_serviced = true
	FROM service_invoices
	WHERE cars.car_id = service_invoices.car_id;
END;
$$ LANGUAGE plpgsql;

CALL check_service();

SELECT *
FROM cars;

-- update dealer_inventory: updates days_in_lot column & remove vehicles that has been sold
-- update cars: change dealer_owned column to false if car has been sold
CREATE OR REPLACE PROCEDURE update_inventory()
AS $$
BEGIN
	DELETE FROM dealer_inventory
	USING sales_invoices
	WHERE dealer_inventory.car_id = sales_invoices.car_id;
	
	UPDATE dealer_inventory
	SET days_in_lot = LOCALTIMESTAMP - purchased_date;
	
	UPDATE cars
	SET dealer_owned = false
	FROM sales_invoices
	WHERE cars.car_id = sales_invoices.car_id;
END;
$$ LANGUAGE plpgsql;

CALL update_inventory();

SELECT *
FROM dealer_inventory;

-- update car price:
-- change the price of cars that has been in the lot for 'x' days
-- useful for giving discounts on cars that has been sitting in the lot for a long time
CREATE OR REPLACE FUNCTION get_discount(price NUMERIC, discount INTEGER)
RETURNS INTEGER
AS $$
    BEGIN
        RETURN (price * discount/100);
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE apply_discount(discount INTEGER, days INTERVAL)
AS $$
BEGIN
	UPDATE dealer_inventory
	SET sale_price = get_discount(sale_price, 100-discount)
	WHERE days_in_lot > days;
END;
$$ LANGUAGE plpgsql;

CALL apply_discount(10, '30 days');

SELECT *
FROM dealer_inventory;