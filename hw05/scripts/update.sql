UPDATE products.products
SET title = 'Disabled ' || products.title
FROM products.categories where categories.id = products.category_id AND
enabled IS FALSE;

UPDATE public.addresses
SET (updated_at, country) = (NOW(), 'Russia')
FROM products_workers.shoppers where addresses.id = shoppers.address_id;
