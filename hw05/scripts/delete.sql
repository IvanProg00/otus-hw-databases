DELETE FROM products.products
USING products.categories
WHERE categories.id = products.category_id AND
categories.title = 'Компьютеры';

DELETE FROM products_workers.shoppers
USING public.addresses
WHERE addresses.id = shoppers.address_id AND
addresses.city = 'Novo Hamburgo';
