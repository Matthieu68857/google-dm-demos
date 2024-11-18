CREATE EXTENSION IF NOT EXISTS pg_cron;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS sales_history;

-- Creating the customers table
CREATE TABLE customers (
            customer_id SERIAL PRIMARY KEY,
            customer_name VARCHAR(255) NOT NULL,
            email VARCHAR(255) UNIQUE NOT NULL,
            address TEXT
);

-- Creating the products table
CREATE TABLE products (
            product_id SERIAL PRIMARY KEY,
            product_name VARCHAR(255) NOT NULL,
            description TEXT,
            list_price NUMERIC(10, 2) NOT NULL,
            selling_price NUMERIC(10, 2) NOT NULL
);

-- Creating the orders table
CREATE TABLE orders (
            order_id SERIAL PRIMARY KEY,
            customer_id INT REFERENCES customers(customer_id),
            product_id INT REFERENCES products(product_id),
            order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            purchase_price DECIMAL (10, 2) NOT NULL
);

CREATE TABLE sales_history (
            order_id INT,
            product_id INT,
            purchase_price INT
);

INSERT INTO customers (customer_name, email, address) VALUES
('John Doe', 'john.doe@example.com', '123 Main St'),
('Jane Smith', 'jane.smith@example.com', '456 Elm St'),
('David Lee', 'david.lee@example.com', '789 Oak St'),
('Sarah Jones', 'sarah.jones@example.com', '1011 Pine St'),
('Michael Brown', 'michael.brown@example.com', '1213 Willow St'),
('Emily Davis', 'emily.davis@example.com', '1415 Maple St'),
('Christopher Wilson', 'christopher.wilson@example.com', '1617 Birch St'),
('Jessica Garcia', 'jessica.garcia@example.com', '1819 Cedar St'),
('Matthew Rodriguez', 'matthew.rodriguez@example.com', '2021 Oak St'),
('Ashley Martinez', 'ashley.martinez@example.com', '2223 Pine St'),
('Jacob Robinson', 'jacob.robinson@example.com', '2425 Willow St'),
('Amanda Clark', 'amanda.clark@example.com', '2627 Maple St'),
('Joshua Lewis', 'joshua.lewis@example.com', '2829 Birch St'),
('Brittany Young', 'brittany.young@example.com', '3031 Cedar St'),
('Andrew Allen', 'andrew.allen@example.com', '3233 Oak St'),
('Katherine King', 'katherine.king@example.com', '3435 Pine St'),
('Daniel Wright', 'daniel.wright@example.com', '3637 Willow St'),
('Elizabeth Scott', 'elizabeth.scott@example.com', '3839 Maple St'),
('Joseph Green', 'joseph.green@example.com', '4041 Birch St'),
('Linda Adams', 'linda.adams@example.com', '4243 Cedar St'),
('Anthony Baker', 'anthony.baker@example.com', '4445 Oak St'),
('Angela Nelson', 'angela.nelson@example.com', '4647 Pine St'),
('William Carter', 'william.carter@example.com', '4849 Willow St'),
('Rebecca Mitchell', 'rebecca.mitchell@example.com', '5051 Maple St'),
('David Perez', 'david.perez@example.com', '5253 Birch St'),
('Kimberly Roberts', 'kimberly.roberts@example.com', '5455 Cedar St'),
('James Turner', 'james.turner@example.com', '5657 Oak St'),
('Michelle Phillips', 'michelle.phillips@example.com', '5859 Pine St'),
('Patrick Campbell', 'patrick.campbell@example.com', '6061 Willow St'),
('Cynthia Parker', 'cynthia.parker@example.com', '6263 Maple St'),
('Kevin Evans', 'kevin.evans@example.com', '6465 Birch St'),
('Deborah Edwards', 'deborah.edwards@example.com', '6667 Cedar St'),
('Brian Collins', 'brian.collins@example.com', '6869 Oak St'),
('Laura Stewart', 'laura.stewart@example.com', '7071 Pine St'),
('Jason Sanchez', 'jason.sanchez@example.com', '7273 Willow St'),
('Sharon Morris', 'sharon.morris@example.com', '7475 Maple St'),
('Timothy Rogers', 'timothy.rogers@example.com', '7677 Birch St'),
('Margaret Reed', 'margaret.reed@example.com', '7879 Cedar St'),
('Jeffrey Cook', 'jeffrey.cook@example.com', '8081 Oak St'),
('Sarah Bell', 'sarah.bell@example.com', '8283 Pine St'),
('Ronald Murphy', 'ronald.murphy@example.com', '8485 Willow St'),
('Carolyn Bailey', 'carolyn.bailey@example.com', '8687 Maple St'),
('Nicholas Rivera', 'nicholas.rivera@example.com', '8889 Birch St'),
('Kathleen Cooper', 'kathleen.cooper@example.com', '9091 Cedar St'),
('Thomas Richardson', 'thomas.richardson@example.com', '9293 Oak St'),
('Barbara Cox', 'barbara.cox@example.com', '9495 Pine St'),
('Charles Howard', 'charles.howard@example.com', '9697 Willow St'),
('Margaret Ward', 'margaret.ward@example.com', '9899 Maple St'),
('Paul Torres', 'paul.torres@example.com', '10101 Birch St'),
('Ruth Peterson', 'ruth.peterson@example.com', '10303 Cedar St'),
('Kenneth Gray', 'kenneth.gray@example.com', '10505 Oak St'),
('Maria Ramirez', 'maria.ramirez@example.com', '10707 Pine St'),
('Brian James', 'brian.james@example.com', '10909 Willow St'),
('Dorothy Watson', 'dorothy.watson@example.com', '11111 Maple St'),
('Justin Brooks', 'justin.brooks@example.com', '11313 Birch St'),
('Virginia Kelly', 'virginia.kelly@example.com', '11515 Cedar St'),
('Henry Sanders', 'henry.sanders@example.com', '11717 Oak St'),
('Christine Price', 'christine.price@example.com', '11919 Pine St'),
('Patrick Bennett', 'patrick.bennett@example.com', '12121 Willow St'),
('Brenda Wood', 'brenda.wood@example.com', '12323 Maple St'),
('Jerry Barnes', 'jerry.barnes@example.com', '12525 Birch St'),
('Katherine Ross', 'katherine.ross@example.com', '12727 Cedar St'),
('Dennis Henderson', 'dennis.henderson@example.com', '12929 Oak St'),
('Carolyn Coleman', 'carolyn.coleman@example.com', '13131 Pine St'),
('Aaron Jenkins', 'aaron.jenkins@example.com', '13333 Willow St'),
('Evelyn Perry', 'evelyn.perry@example.com', '13535 Maple St'),
('Jose Powell', 'jose.powell@example.com', '13737 Birch St'),
('Gloria Long', 'gloria.long@example.com', '13939 Cedar St'),
('Keith Patterson', 'keith.patterson@example.com', '14141 Oak St'),
('Theresa Hughes', 'theresa.hughes@example.com', '14343 Pine St'),
('Arthur Flores', 'arthur.flores@example.com', '14545 Willow St'),
('Doris Washington', 'doris.washington@example.com', '14747 Maple St'),
('Gerald Butler', 'gerald.butler@example.com', '14949 Birch St'),
('Shirley Simmons', 'shirley.simmons@example.com', '15151 Cedar St'),
('Roger Foster', 'roger.foster@example.com', '15353 Oak St'),
('Ann Gonzales', 'ann.gonzales@example.com', '15555 Pine St'),
('Terry Bryant', 'terry.bryant@example.com', '15757 Willow St'),
('Phyllis Alexander', 'phyllis.alexander@example.com', '15959 Maple St'),
('Lawrence Russell', 'lawrence.russell@example.com', '16161 Birch St'),
('Lillian Griffin', 'lillian.griffin@example.com', '16363 Cedar St');

INSERT INTO products (product_name, description, list_price, selling_price) VALUES
('Men''s Cotton T-Shirt', 'Comfortable and stylish t-shirt for everyday wear.', 19.99, 15.99),
('Women''s Denim Jeans', 'Classic denim jeans with a comfortable fit.', 49.99, 39.99),
('Running Shoes', 'High-performance running shoes for optimal comfort and support.', 79.99, 69.99),
('Laptop Backpack', 'Durable and spacious backpack for carrying your laptop and essentials.', 59.99, 49.99),
('Wireless Headphones', 'Noise-cancelling wireless headphones for immersive audio.', 129.99, 99.99),
('Coffee Maker', 'Automatic coffee maker with programmable timer.', 39.99, 29.99),
('Blender', 'Powerful blender for smoothies, soups, and more.', 59.99, 49.99),
('Toaster Oven', 'Compact toaster oven with multiple cooking functions.', 49.99, 39.99),
('Cookware Set', '10-piece cookware set with non-stick coating.', 129.99, 99.99),
('Dinnerware Set', '16-piece dinnerware set for everyday dining.', 79.99, 69.99),
('Bath Towel Set', '6-piece bath towel set made from soft and absorbent cotton.', 39.99, 29.99),
('Bed Sheet Set', 'Queen-size bed sheet set with a high thread count.', 69.99, 59.99),
('Down Comforter', 'Lightweight and warm down comforter for cozy nights.', 149.99, 129.99),
('Throw Pillow', 'Decorative throw pillow with a stylish pattern.', 29.99, 19.99),
('Area Rug', '5x7 area rug with a modern design.', 199.99, 159.99),
('Floor Lamp', 'Stylish floor lamp with adjustable brightness.', 79.99, 69.99),
('Table Lamp', 'Ceramic table lamp with a decorative shade.', 49.99, 39.99),
('Wall Art', 'Canvas wall art with a nature scene.', 59.99, 49.99),
('Picture Frame', 'Set of 3 picture frames for displaying your favorite photos.', 29.99, 19.99),
('Candles', 'Scented candles for creating a relaxing atmosphere.', 12.99, 9.99),
('Hair Dryer', 'Ionic hair dryer with multiple heat and speed settings.', 39.99, 29.99),
('Hair Straightener', 'Ceramic hair straightener with adjustable temperature.', 49.99, 39.99),
('Electric Toothbrush', 'Rechargeable electric toothbrush with multiple brushing modes.', 79.99, 69.99),
('Shaving Kit', 'Men''s shaving kit with razor, shaving cream, and aftershave.', 29.99, 19.99),
('Makeup Set', 'Makeup set with eyeshadow palette, lipstick, and mascara.', 49.99, 39.99),
('Perfume', 'Women''s perfume with a floral scent.', 79.99, 69.99),
('Cologne', 'Men''s cologne with a woody scent.', 59.99, 49.99),
('Sunscreen', 'SPF 30 sunscreen for protection from the sun''s harmful rays.', 12.99, 9.99),
('Hand Sanitizer', 'Travel-size hand sanitizer with moisturizing aloe vera.', 3.99, 2.99),
('First Aid Kit', 'Comprehensive first aid kit for home or travel.', 29.99, 19.99),
('Pain Reliever', 'Over-the-counter pain reliever for headache and muscle aches.', 9.99, 7.99),
('Vitamins', 'Daily multivitamins for overall health and wellness.', 19.99, 15.99),
('Cough Syrup', 'Cough syrup for relief from coughs and sore throats.', 12.99, 9.99),
('Notebook', 'Spiral notebook with college-ruled paper.', 3.99, 2.99),
('Pens', 'Pack of 10 ballpoint pens with black ink.', 5.99, 4.99),
('Pencils', 'Pack of 12 graphite pencils with erasers.', 4.99, 3.99),
('Highlighters', 'Set of 5 highlighters in assorted colors.', 6.99, 5.99),
('Stapler', 'Heavy-duty stapler with staple remover.', 12.99, 9.99),
('Scissors', 'Stainless steel scissors with comfortable grip.', 9.99, 7.99),
('Tape Dispenser', 'Tape dispenser with clear tape.', 7.99, 6.99),
('Calculator', 'Scientific calculator with large display.', 19.99, 15.99),
('Calendar', 'Wall calendar with monthly view.', 12.99, 9.99),
('Planner', 'Daily planner with space for notes and appointments.', 15.99, 12.99),
('Gift Wrap', 'Roll of wrapping paper with a festive design.', 4.99, 3.99),
('Greeting Card', 'Blank greeting card with envelope.', 2.99, 1.99),
('Gift Bag', 'Small gift bag with tissue paper.', 3.99, 2.99),
('Ribbon', 'Spool of ribbon for decorating gifts.', 5.99, 4.99);

INSERT INTO sales_history (order_id, product_id, purchase_price)
SELECT floor(random() * 50 + 1), floor(random() * 50 + 1), floor(random() * 100 + 1)
FROM generate_series(1, 1000) AS i;