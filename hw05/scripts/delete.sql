DELETE FROM products.products
USING products.categories
WHERE categories.id = products.category_id AND
categories.title = 'Компьютеры';