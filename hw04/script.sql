-- Создать базу данных
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;

-- Табличные пространства и роли.
REVOKE ALL ON DATABASE shop FROM PUBLIC;
CREATE ROLE shop_role;
GRANT ALL PRIVILEGES ON DATABASE shop to shop_role;

-- Схема данных.
DROP SCHEMA IF EXISTS products;
CREATE SCHEMA products;
DROP SCHEMA IF EXISTS products_workers;
CREATE SCHEMA products_workers;

-- Таблицы
DROP TABLE IF EXISTS addresses;
CREATE TABLE addresses (
	id BIGSERIAL PRIMARY KEY,
	country TEXT NOT NULL,
	city TEXT NOT NULL,
	address TEXT NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL
);

DROP TABLE IF EXISTS products_workers.shoppers;
CREATE TABLE products_workers.shoppers (
	id BIGSERIAL PRIMARY KEY,
	address_id BIGSERIAL,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	phone VARCHAR(20) NOT NULL,
	email TEXT NOT NULL,
	password TEXT NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	CONSTRAINT address_fk
		FOREIGN KEY (address_id)
		REFERENCES addresses(id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS products_workers.producers;
CREATE TABLE products_workers.producers (
	id BIGSERIAL PRIMARY KEY,
	address_id BIGSERIAL,
	title TEXT NOT NULL,
	phone VARCHAR(20),
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	CONSTRAINT address_fk
		FOREIGN KEY (address_id)
		REFERENCES addresses(id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS products.categories;
CREATE TABLE products.categories(
	id BIGSERIAL PRIMARY KEY,
	title TEXT
);

DROP TABLE IF EXISTS products.products;
CREATE TABLE products.products (
	id BIGSERIAL PRIMARY KEY,
	category_id BIGSERIAL,
	title TEXT NOT NULL,
	price MONEY NOT NULL,
	enabled BOOLEAN NOT NULL,
	count INT NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	CONSTRAINT category_fk
		FOREIGN KEY (category_id)
		REFERENCES products.categories(id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS producers_products;
CREATE TABLE producers_products (
	id BIGSERIAL PRIMARY KEY,
	producer_id BIGSERIAL,
	product_id BIGSERIAL,
	CONSTRAINT producer_fk
		FOREIGN KEY (producer_id)
		REFERENCES products_workers.producers(id)
		ON DELETE CASCADE,
	CONSTRAINT product_fk
		FOREIGN KEY (product_id)
		REFERENCES products.products(id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS products_workers.suppliers;
CREATE TABLE products_workers.suppliers (
	id BIGSERIAL PRIMARY KEY,
	title TEXT NOT NULL,
	phone VARCHAR(20) NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL
);

DROP TABLE IF EXISTS products_workers.purchases;
CREATE TABLE products_workers.purchases (
	id BIGSERIAL PRIMARY KEY,
	shopper_id BIGSERIAL,
	address_id BIGSERIAL,
	amount money NOT NULL,
	paid boolean NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	CONSTRAINT shopper_fk
		FOREIGN KEY (shopper_id)
		REFERENCES products_workers.shoppers(id)
		ON DELETE CASCADE,
	CONSTRAINT address_fk
		FOREIGN KEY (address_id)
		REFERENCES addresses(id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS products_purchases;
CREATE TABLE products_purchases (
	id BIGSERIAL PRIMARY KEY,
	product_id BIGSERIAL,
	purchase_id BIGSERIAL,
	CONSTRAINT product_fk
		FOREIGN KEY (product_id)
		REFERENCES products.products(id)
		ON DELETE CASCADE,
	CONSTRAINT purchase_fk
		FOREIGN KEY (purchase_id)
		REFERENCES products_workers.purchases(id)
		ON DELETE CASCADE
);
