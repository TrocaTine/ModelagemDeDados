CREATE OR REPLACE FUNCTION total_value_order(shopping_cart_finish integer)
	returns decimal as
	'SELECT SUM(value_product(id_product, quantity)) FROM shopping_carts WHERE id_shopping_cart = $1'
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION value_product(product_new integer, quantity integer)
	returns decimal as
	'SELECT value*$2 FROM products WHERE id_product = $1'
LANGUAGE SQL;

DROP FUNCTION IF EXISTS podium_trocadinha;

CREATE OR REPLACE FUNCTION podium_trocadinhas(expiration_datep date)
RETURNS SETOF trocadinhas
AS
	$$
	BEGIN
		RETURN QUERY
		SELECT * FROM trocadinhas WHERE expiration_date NOT BETWEEN expiration_datep AND current_date ORDER BY number_trocadinha DESC LIMIT 3;
	END
	$$
LANGUAGE PLPGSQL;