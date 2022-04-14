-- Здесь я вывожу информация о продуктах и к какой категории они относятся
SELECT * FROM products.categories
INNER JOIN products.products ON categories.id = products.category_id

-- В данном запросе я узнаю где живут клиенты, и какие адреса не используются
SELECT addresses.country, shoppers.name FROM public.addresses
LEFT JOIN products_workers.shoppers ON shoppers.address_id = addresses.id;

-- В данном скрипте я узнаю имя и фамилию покупателя, узнаю название и цену продукта, и был ли продукт оплачен
SELECT shoppers.name || ' ' || shoppers.surname as name, products.title, products.price, purchases.paid FROM public.products_purchases
INNER JOIN products.products ON products_purchases.product_id = products.id
INNER JOIN products_workers.purchases ON products_purchases.purchase_id = purchases.id
INNER JOIN products_workers.shoppers ON purchases.shopper_id = shoppers.id;
