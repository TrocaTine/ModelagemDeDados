DROP TABLE IF EXISTS adresses_users;
DROP TABLE IF EXISTS products_tags;
DROP TABLE IF EXISTS products_categories;
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS users_push;
DROP TABLE IF EXISTS phones;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS push;
DROP TABLE IF EXISTS adresses;
DROP TABLE IF EXISTS highlights;
DROP FUNCTION IF EXISTS podium_trocadinhas;
DROP TABLE IF EXISTS trocadinhas;
DROP TABLE IF EXISTS history_trocadinhas;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS shopping_carts;
DROP TABLE IF EXISTS history_shopping_carts;
DROP TABLE IF EXISTS saved_cards;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS log_highlights;
DROP TABLE IF EXISTS log_users;
DROP TABLE IF EXISTS log_push;
DROP TABLE IF EXISTS log_shopping_carts;
DROP TABLE IF EXISTS log_trocadinhas;
DROP TABLE IF EXISTS log_products;

CREATE TABLE users (
    id_user SERIAL PRIMARY KEY NOT NULL,
    first_name VARCHAR(20) NOT NULL CHECK (LENGTH(first_name) >= 3),
    last_name VARCHAR(100) NOT NULL CHECK (LENGTH(last_name) >= 2),
    email VARCHAR(80) NOT NULL UNIQUE CHECK (
        email LIKE '%@gmail.com' OR
        email LIKE '%@hotmail.com' OR
        email LIKE '%@mail.com' OR
        email LIKE '%@yahoo.com' OR
        email LIKE '%@outlook.com'
    ),
    cpf VARCHAR(15) NOT NULL UNIQUE,
    birth_date DATE NOT NULL,
    admin BOOLEAN DEFAULT FALSE,
    nickname VARCHAR(20) NOT NULL UNIQUE CHECK (LENGTH(nickname) > 3),
    password VARCHAR NOT NULL
);

CREATE TABLE adresses (
    id_adress SERIAL PRIMARY KEY NOT NULL,
    street VARCHAR(80) NOT NULL CHECK (LENGTH(street) >= 5),
    number VARCHAR(5) NOT NULL,
    city VARCHAR(80) NOT NULL CHECK (LENGTH(city) >= 3),
    state VARCHAR(2) NOT NULL CHECK (LENGTH(state) = 2),
	neighborhood VARCHAR(80),
    complement VARCHAR(120),
    cep VARCHAR(15) NOT NULL CHECK (LENGTH(cep) >= 8)
);

CREATE TABLE adresses_users (
    id_adress INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
	FOREIGN KEY (id_user) REFERENCES users(id_user),
	FOREIGN KEY (id_adress) REFERENCES adresses(id_adress)
);

CREATE TABLE phones (
    id_phone SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    number VARCHAR(15) NOT NULL CHECK (LENGTH(number) >= 13),
	FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE products (
    id_product SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL CHECK (LENGTH(name) >= 3),
    description VARCHAR CHECK (LENGTH(description) >= 3),
    value NUMERIC DEFAULT 0,
    stock BIGINT DEFAULT 1,
    created_at DATE DEFAULT current_date,
	update_at DATE DEFAULT current_date,
    flag_trade BOOLEAN NOT NULL DEFAULT TRUE,
	FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE tags (
    id_tag SERIAL PRIMARY KEY NOT NULL,
    type VARCHAR(80) NOT NULL CHECK (LENGTH(type) >= 3),
    name VARCHAR(80) NOT NULL
);

CREATE TABLE categories (
    id_category SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(80) NOT NULL CHECK (LENGTH(name) >= 3)
);

CREATE TABLE products_tags (
    id_product INTEGER NOT NULL,
    id_tag INTEGER NOT NULL,
	FOREIGN KEY (id_product) REFERENCES products(id_product),
	FOREIGN KEY (id_tag) REFERENCES tags(id_tag)
);

CREATE TABLE products_categories (
    id_product INTEGER NOT NULL,
    id_category INTEGER NOT NULL,
	FOREIGN KEY (id_product) REFERENCES products(id_product),
	FOREIGN KEY (id_category) REFERENCES categories(id_category)
);

CREATE TABLE push (
    id_push SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR(100) NOT NULL CHECK (LENGTH(title) >= 3),
    description VARCHAR NOT NULL,
    created_at DATE DEFAULT current_date
);

CREATE TABLE users_push (
    id_user INTEGER NOT NULL,
    id_push INTEGER NOT NULL,
	FOREIGN KEY (id_user) REFERENCES users(id_user),
	FOREIGN KEY (id_push) REFERENCES push(id_push)
);

CREATE TABLE favorites (
    id_user INTEGER NOT NULL,
    id_product INTEGER NOT NULL,
	FOREIGN KEY (id_user) REFERENCES users(id_user),
	FOREIGN KEY (id_product) REFERENCES products(id_product)
);

CREATE TABLE shopping_carts (
    id_shopping_cart_org SERIAL PRIMARY KEY NOT NULL,
    id_shopping_cart SERIAL,
    id_user INTEGER NOT NULL,
    id_product INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
	value NUMERIC DEFAULT 0,
	FOREIGN KEY (id_user) REFERENCES users(id_user),
	FOREIGN KEY (id_product) REFERENCES products(id_product)
);

CREATE TABLE history_shopping_carts (
	id_history_shopping_cart SERIAL PRIMARY KEY NOT NULL,
    id_shopping_cart_old INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    id_product INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    value NUMERIC DEFAULT 0,
    status VARCHAR(80) DEFAULT 'Pending',
	FOREIGN KEY (id_user) REFERENCES users(id_user),
	FOREIGN KEY (id_product) REFERENCES products(id_product)
);

CREATE TABLE saved_cards (
    id_saved_card SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    card_number VARCHAR(22) NOT NULL CHECK (LENGTH(card_number) >= 16),
    expiration_date DATE NOT NULL,
    cvv VARCHAR(4) NOT NULL CHECK (LENGTH(cvv) >= 3),
	FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE orders (
    id_order SERIAL PRIMARY KEY NOT NULL,
    id_shopping_cart_old INTEGER,
    id_product INTEGER NOT NULL,
    id_saved_card INTEGER,
    payment_type VARCHAR(20) NOT NULL CHECK (LENGTH(payment_type) >= 3),
    total_value NUMERIC DEFAULT 0,
    accounted_at DATE DEFAULT current_date,
	FOREIGN KEY (id_saved_card) REFERENCES saved_cards(id_saved_card)
);

CREATE TABLE highlights (
    id_highlight SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    id_product INTEGER NOT NULL,
    id_saved_card INTEGER,
    payment_type VARCHAR(20) NOT NULL CHECK (LENGTH(payment_type) >= 3),
    value NUMERIC DEFAULT 0,
    accounted_at DATE DEFAULT current_date,
    expirantion_at DATE NOT NULL,
	FOREIGN KEY (id_user) REFERENCES users(id_user),
	FOREIGN KEY (id_product) REFERENCES products(id_product),
	FOREIGN KEY (id_saved_card) REFERENCES saved_cards(id_saved_card)
);

CREATE TABLE trocadinhas (
    id_trocadinha SERIAL PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    number_trocadinha INTEGER DEFAULT 0,
    expiration_date DATE NOT NULL,
    last_atualization DATE DEFAULT current_date,
	FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE history_trocadinhas (
    id_hist_trocadinha INTEGER PRIMARY KEY NOT NULL,
    id_user INTEGER NOT NULL,
    position VARCHAR(80),
    number_trocadinha INTEGER NOT NULL,
    expiration_date DATE NOT NULL,
    last_atualization DATE NOT NULL,
	FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE log_highlights (
    new_id_highlight INTEGER,
    update_at DATE,
    operation VARCHAR(20),
	user_changed VARCHAR(20),
    old_id_highlight INTEGER
);

CREATE TABLE log_shopping_carts (
    new_id_shopping_cart INTEGER,
    update_at DATE,
    operation VARCHAR(20),
	user_changed VARCHAR(20),
    old_id_shopping_cart INTEGER
);

CREATE TABLE log_trocadinhas (
    new_id_trocadinha INTEGER,
    update_at DATE,
    operation VARCHAR(20),
	user_changed VARCHAR(20),
    old_id_trocadinha INTEGER
);

CREATE TABLE log_users (
    new_id_user INTEGER,
    update_at DATE,
    operation VARCHAR(20),
	user_changed VARCHAR(20),
    old_id_user INTEGER
);

CREATE TABLE log_push (
    new_id_push INTEGER,
    update_at DATE,
    operation VARCHAR(20),
	user_changed VARCHAR(20),
    old_id_push INTEGER
);

CREATE TABLE log_products (
    new_id_product INTEGER,
    update_at DATE,
    operation VARCHAR(20),
	user_changed VARCHAR(20),
    old_id_product INTEGER
);