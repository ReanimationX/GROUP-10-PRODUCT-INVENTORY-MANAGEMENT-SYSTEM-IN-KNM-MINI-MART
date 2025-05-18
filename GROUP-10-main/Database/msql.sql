CREATE DATABASE IF NOT EXISTS InventoryDB_Connection;
USE InventoryDB_Connection;
-- SELECT * FROM products;

-- DELETE FROM products where id;

-- truncate products;

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    barcode VARCHAR(50) NOT NULL UNIQUE,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    expiration_date DATE NULL,
    category_id INT NULL,
    last_stock_in TIMESTAMP NULL,
    last_stock_out TIMESTAMP NULL,
 --   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   -- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

INSERT INTO categories (name) VALUES 
('canned food'),
('processed food'),
('junk food'),
('hygiene'),
('dairy product');


DROP TABLE IF EXISTS stock_in;
CREATE TABLE stock_in (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    stock_in_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS stock_out;
CREATE TABLE stock_out (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    stock_out_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DOUBLE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(50)
);

select * from users;

SELECT p.product_name, p.quantity, p.price, p.expiration_date, c.category_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.id;

SELECT product_name, category, barcode, quantity, price, expiration_date FROM products;
SELECT product_name, SUM(quantity_sold) AS sales_quantity, SUM(total_price) AS total_sales, sale_date 
FROM sales 
GROUP BY product_name;
SELECT p.barcode, p.name, p.price, s.quantity, p.expiration_date, c.name AS category_name 
FROM products p
JOIN stock_in s ON p.barcode = s.barcode
JOIN categories c ON p.category_id = c.id
SELECT product_name, expiration_date, quantity FROM products WHERE expiration_date <= CURDATE() + INTERVAL 30 DAY;

CREATE INDEX idx_barcode ON products(barcode);
CREATE INDEX idx_product_name ON products(product_name);
CREATE INDEX idx_created_at ON products(created_at);


/*
CREATE DATABASE IF NOT EXISTS InventoryDB_Connection;
USE InventoryDB_Connection;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DOUBLE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


--  Products table
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    barcode VARCHAR(50) NOT NULL UNIQUE,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    expiration_date DATE NULL,
    category_id INT NULL,
    last_stock_in TIMESTAMP NULL,
    last_stock_out TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

--  Stock-in table
DROP TABLE IF EXISTS stock_in;
CREATE TABLE stock_in (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    stock_in_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

--  Stock-out table
DROP TABLE IF EXISTS stock_out;
CREATE TABLE stock_out (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    stock_out_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

--  Sales table
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DOUBLE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(50)
);

SELECT p.product_name, p.quantity, p.price, p.expiration_date, c.category_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.id;




--  Indexes for performance optimization
CREATE INDEX idx_barcode ON products(barcode);
CREATE INDEX idx_product_name ON products(product_name);
CREATE INDEX idx_created_at ON products(created_at);*/