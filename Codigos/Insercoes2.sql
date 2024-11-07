-- Tabela users
INSERT INTO users (first_name, last_name, email, cpf, birth_date, admin, nickname, password) VALUES
('Alice', 'Silva', 'alice@gmail.com', '12345678901', '1990-05-15', FALSE, 'aliceBaby', 'senha123'),
('Beatriz', 'Costa', 'bea@hotmail.com', '23456789012', '1985-07-24', FALSE, 'bC123', 'senha456'),
('Carlos', 'Souza', 'carlos@outlook.com', '34567890123', '1978-10-12', TRUE, 'carlinha', 'senha789'),
('Daniel', 'Ferreira', 'daniel@yahoo.com', '45678901234', '1995-11-03', FALSE, 'danyF', 'senha101'),
('Eduardo', 'Lima', 'edu@mail.com', '56789012345', '1982-03-18', FALSE, 'eduL123', 'senha202'),
('Fernanda', 'Santos', 'fernanda@gmail.com', '67890123456', '1993-08-30', FALSE, 'ferSan', 'senha303'),
('Gustavo', 'Oliveira', 'gustavo@hotmail.com', '78901234567', '1997-12-05', TRUE, 'gusOl', 'senha404');

-- Tabela adresses
INSERT INTO adresses (street, number, city, state, neighborhood, complement, cep) VALUES
('Rua das Flores', '101', 'São Paulo', 'SP', 'Jardim', NULL, '01001000'),
('Avenida Brasil', '305', 'Rio de Janeiro', 'RJ', 'Centro', 'Apto 302', '20040000'),
('Rua das Palmeiras', '78', 'Curitiba', 'PR', 'Batel', NULL, '80010000'),
('Avenida Paulista', '500', 'São Paulo', 'SP', 'Bela Vista', NULL, '01310000'),
('Rua da Paz', '34', 'Belo Horizonte', 'MG', 'Savassi', 'Casa', '30120000'),
('Avenida Atlântica', '2020', 'Florianópolis', 'SC', 'Centro', 'Cobertura', '88015000'),
('Rua do Sol', '12', 'Recife', 'PE', 'Boa Vista', NULL, '50050000');

-- Tabela adresses_users
INSERT INTO adresses_users (id_adress, id_user) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7);

-- Tabela phones
INSERT INTO phones (id_user, number) VALUES
(1, '11987654321'), (2, '21987654322'), (3, '41987654323'), (4, '11987654324'), (5, '31987654325'), (6, '48987654326'), (7, '81987654327');

-- Tabela products
INSERT INTO products (id_user, name, description, value, stock, created_at, flag_trade) VALUES
(1, 'Carrinho de Bebê', 'Carrinho compacto e leve', 199.90, 15, '2024-01-10', TRUE),
(2, 'Berço Portátil', 'Ideal para viagens', 299.90, 10, '2024-02-05', TRUE),
(3, 'Mamadeira', 'Mamadeira anti-cólica', 29.90, 50, '2024-03-12', TRUE),
(4, 'Roupão Infantil', 'Roupão confortável', 49.90, 20, '2024-04-20', FALSE),
(5, 'Brinquedo Educativo', 'Para estimular a criatividade', 39.90, 30, '2024-05-15', TRUE),
(6, 'Mochila Escolar', 'Mochila temática infantil', 69.90, 25, '2024-06-10', FALSE),
(7, 'Cadeirinha de Alimentação', 'Fácil de limpar e confortável', 89.90, 12, '2024-07-05', TRUE);

-- Tabela tags
INSERT INTO tags (type, name) VALUES
('cor', 'azul'), ('cor', 'rosa'), ('material', 'plástico'), ('tamanho', 'pequeno'), ('tamanho', 'grande'), ('categoria', 'brinquedo'), ('categoria', 'vestuário');

-- Tabela categories
INSERT INTO categories (name) VALUES
('Brinquedos'), ('Móveis'), ('Vestuário'), ('Acessórios'), ('Escola'), ('Cama e Banho'), ('Alimentação');

-- Tabela products_tags
INSERT INTO products_tags (id_product, id_tag) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7);

-- Tabela products_categories
INSERT INTO products_categories (id_product, id_category) VALUES
(1, 2), (2, 2), (3, 7), (4, 3), (5, 1), (6, 5), (7, 7);

-- Tabela push
INSERT INTO push (title, description, created_at) VALUES
('Promoção de Brinquedos!', 'Descontos em brinquedos variados', '2024-01-15'),
('Novidades na Loja!', 'Confira nossos novos produtos', '2024-02-20'),
('Desconto Especial', 'Ganhe 10% de desconto em acessórios', '2024-03-10'),
('Lançamento', 'Chegaram novos modelos de mochilas', '2024-04-05'),
('Oferta Relâmpago', 'Aproveite nossa oferta de 50% em roupas', '2024-05-01'),
('Frete Grátis', 'Frete grátis para compras acima de R$200', '2024-06-25'),
('Semana da Criança', 'Descontos exclusivos para os pequenos', '2024-07-15');

-- Tabela users_push
INSERT INTO users_push (id_user, id_push) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7);

-- Tabela favorites
INSERT INTO favorites (id_user, id_product) VALUES
(1, 5), (2, 4), (3, 1), (4, 2), (5, 3), (6, 7), (7, 6);

-- Tabela shopping_carts
INSERT INTO shopping_carts (id_shopping_cart, id_user, id_product, quantity, value) VALUES
(1, 1, 2, 1, 299.90), (2, 2, 5, 2, 79.80), (3, 3, 4, 1, 49.90), (4, 4, 6, 1, 69.90), (5, 5, 3, 3, 89.70), (6, 6, 7, 1, 89.90), (7, 7, 1, 2, 399.80);

-- Tabela history_shopping_carts
INSERT INTO history_shopping_carts (id_shopping_cart_old, id_user, id_product, quantity, value, status) VALUES
(1, 1, 2, 1, 299.90, 'Completed'), (2, 2, 5, 2, 79.80, 'Pending'), (3, 3, 4, 1, 49.90, 'Shipped'), (4, 4, 6, 1, 69.90, 'Completed'), (5, 5, 3, 3, 89.70, 'Pending'), (6, 6, 7, 1, 89.90, 'Completed'), (7, 7, 1, 2, 399.80, 'Pending');

-- Tabela saved_cards
INSERT INTO saved_cards (id_user, card_number, expiration_date, cvv) VALUES
(1, '1234123412341234', '2025-05-15', '123'), (2, '2345234523452345', '2026-07-24', '234'), (3, '3456345634563456', '2024-10-12', '345'), (4, '4567456745674567', '2025-11-03', '456'), (5, '5678567856785678', '2023-03-18', '567'), (6, '6789678967896789', '2026-08-30', '678'), (7, '7890789078907890', '2025-12-05', '789');

-- Tabela orders
INSERT INTO orders (id_shopping_cart_old, id_product, id_saved_card, payment_type, total_value) VALUES
(2, 5, 2, 'Credit Card', 79.80),
(3, 4, 3, 'Credit Card', 49.90),
(4, 6, 4, 'Debit Card', 69.90),
(5, 3, 5, 'Credit Card', 89.70),
(6, 7, 6, 'Credit Card', 89.90),
(7, 1, 7, 'Debit Card', 399.80);

-- Tabela highlights
INSERT INTO highlights (id_user, id_product, id_saved_card, payment_type, value, accounted_at, expirantion_at) VALUES
(1, 2, 1, 'Credit Card', 150.00, '2024-01-15', '2024-07-15'),
(2, 5, 2, 'Credit Card', 90.00, '2024-02-10', '2024-08-10'),
(3, 4, 3, 'Debit Card', 45.00, '2024-03-05', '2024-09-05'),
(4, 6, 4, 'Credit Card', 100.00, '2024-04-20', '2024-10-20'),
(5, 3, 5, 'Debit Card', 70.00, '2024-05-12', '2024-11-12'),
(6, 7, 6, 'Credit Card', 120.00, '2024-06-18', '2024-12-18'),
(7, 1, 7, 'Debit Card', 200.00, '2024-07-01', '2025-01-01');

-- Tabela trocadinhas
INSERT INTO trocadinhas (id_user, number_trocadinha, expiration_date, last_atualization) VALUES
(1, 10, '2025-01-15', '2024-07-15'),
(2, 5, '2024-12-10', '2024-06-10'),
(3, 8, '2025-03-05', '2024-09-05'),
(4, 12, '2025-06-20', '2024-10-20'),
(5, 7, '2024-11-12', '2024-05-12'),
(6, 15, '2025-02-18', '2024-08-18'),
(7, 20, '2025-01-01', '2024-07-01');

-- Tabela history_trocadinhas
INSERT INTO history_trocadinhas (id_hist_trocadinha, id_user, position, number_trocadinha, expiration_date, last_atualization) VALUES
(1, 1, 'Primeiro', 5, '2024-07-15', '2024-01-15'),
(2, 2, 'Segundo', 3, '2024-06-10', '2024-02-10'),
(3, 3, 'Segundo', 4, '2024-09-05', '2024-03-05'),
(4, 4, 'Primeiro', 2, '2024-10-20', '2024-04-20'),
(5, 5, 'Segundo', 7, '2024-11-12', '2024-05-12'),
(6, 6, 'Terceiro', 10, '2024-12-18', '2024-06-18'),
(7, 7, 'Terceiro', 15, '2025-01-01', '2024-07-01');
