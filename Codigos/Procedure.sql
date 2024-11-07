CREATE OR REPLACE PROCEDURE create_user(
	first_namep varchar, 
	last_namep varchar, 
	emailp varchar, 
	cpfp varchar, 
    birth_datep date, 
	adminp boolean, 
	nicknamep varchar, 
	passwordp varchar, 
	streetp varchar, 
	numberp integer,
    cityp varchar, 
	statep varchar, 
	neighborhoodp varchar, 
	complementp varchar, 
	cepp varchar, 
	number_phonep varchar
	)
LANGUAGE PLPGSQL
as 
	$$
	DECLARE
	existencia integer;
	BEGIN
		select count(email) from users where UPPER(email) = UPPER(emailp) into existencia;
		
		IF (existencia) = 0 THEN
			INSERT INTO users(first_name, last_name, email, cpf, birth_date, admin, nickname, password)
            VALUES (first_namep, last_namep, emailp, cpfp, birth_datep , adminp, nicknamep, passwordp);

			INSERT INTO adresses(street, number, city, state, neighborhood, complement, cep) 
            VALUES (streetp , numberp, cityp , statep , neighborhoodp , complementp , cepp);
			
			INSERT INTO adresses_users(id_user, id_adress)
            VALUES ((select max(id_user) from users),(select max(id_adress) from adresses));

            INSERT INTO phones(id_user, number) VALUES ((select max(id_user) from users), number_phonep);
		ELSE
			RAISE EXCEPTION 'Usuario já existente!';
		END IF;
		COMMIT;
	END
	$$;


CREATE OR REPLACE PROCEDURE create_product(
	id_userp integer,
    name_product varchar, 
    descriptionp varchar, 
    valuep numeric,
    stockp integer, 
    flag_tradep boolean, 
    typep varchar[],    
    name_tags varchar[], 
    name_category varchar
)
LANGUAGE PLPGSQL
AS 
$$
	DECLARE
		new_product_id INT;
		new_category_id INT;
		existing_tag_id INT;
		existing_category_id INT;
		tag_name varchar;
		tag_type varchar;
	BEGIN
		INSERT INTO products(id_user, name, description, value, stock, created_at, update_at, flag_trade)
		VALUES (id_userp, name_product, descriptionp, valuep, stockp, current_date, current_date, flag_tradep);

		new_product_id := (SELECT MAX(id_product) FROM products);

		SELECT id_category INTO existing_category_id FROM categories WHERE UPPER(name) = UPPER(name_category);

		IF NOT FOUND THEN
			INSERT INTO categories(name) 
			VALUES (name_category);

			existing_category_id := (SELECT id_category FROM categories WHERE UPPER(name) = UPPER(name_category));
		END IF;

		INSERT INTO products_categories(id_product, id_category) 
		VALUES (new_product_id, existing_category_id);

		FOR i IN 1..array_length(name_tags, 1) LOOP
			tag_name := name_tags[i];
			tag_type := typep[i];

			SELECT id_tag INTO existing_tag_id FROM tags WHERE UPPER(name) = UPPER(tag_name) AND UPPER(type) = UPPER(tag_type);

			IF NOT FOUND THEN
				INSERT INTO tags(type, name) 
				VALUES (tag_type, tag_name);

				existing_tag_id := (SELECT id_tag FROM tags WHERE UPPER(name) = UPPER(tag_name) AND UPPER(type) = UPPER(tag_type));
			END IF;

			INSERT INTO products_tags(id_product, id_tag) 
			VALUES (new_product_id, existing_tag_id);
		END LOOP;

		COMMIT;
	END
	$$;


CREATE OR REPLACE PROCEDURE create_order (
	id_shopping_cartp integer = null,
	quantityp integer = null,
	id_productp integer,
	id_saved_cardp integer, 
	payment_typep varchar
	)
LANGUAGE PLPGSQL
AS
	$$
	DECLARE
	total_value NUMERIC;
	
	BEGIN
		IF id_shopping_cartp is null THEN
			SELECT value_product(id_productp, quantityp) INTO total_value;

			INSERT INTO orders(id_product, id_saved_card, payment_type, total_value, accounted_at)
			VALUES (id_productp, id_saved_cardp, payment_typep, total_value, current_date);
		ELSE
			SELECT total_value_order(id_shopping_cartp) INTO total_value;

			DELETE FROM shopping_carts WHERE id_shopping_cart = id_shopping_cartp;

			INSERT INTO orders(id_shopping_cart_old, id_product, id_saved_card, payment_type, total_value, accounted_at)
			VALUES ((SELECT MAX(id_shopping_cart_old) FROM history_shopping_carts), ,id_saved_cardp, payment_typep, total_value, current_date);
		END IF;
	COMMIT;
	END
	$$;

CREATE OR REPLACE PROCEDURE create_tag(
    typep varchar,
    name_tag varchar
)
LANGUAGE PLPGSQL
AS 
$$
	DECLARE
		existing_tag_id INT;
	BEGIN

		SELECT id_tag INTO existing_tag_id FROM tags WHERE UPPER(name) = UPPER(name_tag) AND UPPER(type) = UPPER(typep);

		IF NOT FOUND THEN
			INSERT INTO tags(type, name) 
			VALUES (typep, name_tag);
		ELSE
			RAISE NOTICE 'A tag % com o type % já existe! Não é necessario inseri-la novamente', name_tag, typep;
		END IF;
	END
	$$;

CREATE OR REPLACE PROCEDURE create_category(
    name_category varchar
)
LANGUAGE PLPGSQL
AS 
$$
	DECLARE
		existing_category_id INT;
	BEGIN

		SELECT id_category INTO existing_category_id FROM categories WHERE UPPER(name) = UPPER(name_category);

		IF NOT FOUND THEN
			INSERT INTO categories(name) 
			VALUES (name_category);
		ELSE
			RAISE NOTICE 'A category % já existe! Não é necessario inseri-la novamente', name_category;
		END IF;
	END
	$$;