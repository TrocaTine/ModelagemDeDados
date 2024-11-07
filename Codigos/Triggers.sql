-- DROP TRIGGER IF EXISTS trg_users_log ON users;
-- DROP TRIGGER IF EXISTS trg_trocadinhas_log ON trocadinhas;
-- DROP TRIGGER IF EXISTS trg_highlights_log ON highlights;
-- DROP TRIGGER IF EXISTS trg_shopping_carts_log ON shopping_carts;
-- DROP TRIGGER IF EXISTS trg_update_trocadinhas ON trocadinhas;
-- DROP TRIGGER IF EXISTS trg_hist_trocadinhas ON trocadinhas;
-- DROP TRIGGER IF EXISTS trg_hist_shopping_carts ON shopping_carts;

-- DROP FUNCTION IF EXISTS func_users_log;
-- DROP FUNCTION IF EXISTS func_trocadinhas_log;
-- DROP FUNCTION IF EXISTS func_highlights_log;
-- DROP FUNCTION IF EXISTS func_products_log;
-- DROP FUNCTION IF EXISTS func_shopping_carts_log;
-- DROP FUNCTION IF EXISTS func_update_trocadinhas;
-- DROP FUNCTION IF EXISTS func_hist_trocadinhas;
-- DROP FUNCTION IF EXISTS func_hist_shopping_carts;

--Função de Trigger Tabela Log - Usuario
CREATE OR REPLACE FUNCTION func_users_log() RETURNS trigger 
AS
$$
  DECLARE
  	usuario varchar(80);
  BEGIN
    SELECT usename FROM pg_user INTO usuario;
	INSERT INTO log_users (new_id_user, update_at, operation, user_changed, old_id_user) 
	VALUES (NEW.id_user, current_date, TG_OP, usuario, OLD.id_user);
	RETURN NEW;
  END;
$$
LANGUAGE 'plpgsql';

--Trigger para registrar na tabela de log de usuario
CREATE OR REPLACE TRIGGER trg_users_log
AFTER INSERT OR UPDATE OR delete ON users
FOR EACH ROW
EXECUTE PROCEDURE func_users_log();

--------------------------------------------------------------------------------------------------
--Função de Trigger Tabela Log - Trocadinhas
CREATE OR REPLACE FUNCTION func_trocadinhas_log() RETURNS trigger 
AS
$$
  DECLARE
  	usuario varchar(80);
  BEGIN
    SELECT usename FROM pg_user INTO usuario;
	INSERT INTO log_trocadinhas (new_id_trocadinha, update_at, operation, user_changed, old_id_trocadinha) 
	VALUES (NEW.id_trocadinha, current_date, TG_OP, usuario, OLD.id_trocadinha);
	RETURN NEW;
  END;
$$
LANGUAGE 'plpgsql';

--Trigger para registrar na tabela de log de usuario
CREATE OR REPLACE TRIGGER trg_trocadinhas_log
AFTER INSERT OR UPDATE OR delete ON trocadinhas
FOR EACH ROW
EXECUTE PROCEdure func_trocadinhas_log();

--------------------------------------------------------------------------------------------------
--Função de Trigger Tabela Log - Highlights
CREATE OR REPLACE FUNCTION func_highlights_log() RETURNS trigger 
AS
$$
  DECLARE
  	usuario varchar(80);
  BEGIN
    SELECT usename FROM pg_user INTO usuario;
	INSERT INTO log_highlights (new_id_highlight, update_at, operation, user_changed, old_id_highlight) 
	VALUES (NEW.id_highlight, current_date, TG_OP, usuario, OLD.id_highlight);
	RETURN NEW;
  END;
$$
LANGUAGE 'plpgsql';

--Trigger para registrar na tabela de log de destaque
CREATE OR REPLACE TRIGGER trg_highlights_log
AFTER INSERT OR UPDATE OR DELETE ON highlights
FOR EACH ROW
EXECUTE PROCEdure func_highlights_log();

--------------------------------------------------------------------------------------------------
--Função de Trigger Tabela Log - products
CREATE OR REPLACE FUNCTION func_products_log() RETURNS trigger 
AS
$$
  DECLARE
  	usuario varchar(80);
  BEGIN
    SELECT usename FROM pg_user INTO usuario;
	INSERT INTO log_products (new_id_product, update_at, operation, user_changed, old_id_product) 
	VALUES (NEW.id_product, current_date, TG_OP, usuario, OLD.id_product);
	RETURN NEW;
  END;
$$
LANGUAGE 'plpgsql';

--Trigger para registrar na tabela de log de usuario
CREATE OR REPLACE TRIGGER trg_products_log
AFTER INSERT OR UPDATE OR delete ON products
FOR EACH ROW
EXECUTE PROCEdure func_products_log();

--------------------------------------------------------------------------------------------------
--Função de Trigger Tabela Log - push
CREATE OR REPLACE FUNCTION func_push_log() RETURNS trigger 
AS
$$
  DECLARE
  	usuario varchar(80);
  BEGIN
    SELECT usename FROM pg_user INTO usuario;
	INSERT INTO log_push (new_id_push, update_at, operation, user_changed, old_id_push) 
	VALUES (NEW.id_push, current_date, TG_OP, usuario, OLD.id_push);
	RETURN NEW;
  END;
$$
LANGUAGE 'plpgsql';

--Trigger para registrar na tabela de log de usuario
CREATE OR REPLACE TRIGGER trg_push_log
AFTER INSERT OR UPDATE OR delete ON push
FOR EACH ROW
EXECUTE PROCEdure func_push_log();

--------------------------------------------------------------------------------------------------
--Função de Trigger Tabela Log - Shopping_carts
CREATE OR REPLACE FUNCTION func_shopping_carts_log() RETURNS trigger 
AS
$$
  DECLARE
  	usuario varchar(80);
  BEGIN
    SELECT usename FROM pg_user INTO usuario;
	INSERT INTO log_shopping_carts (new_id_shopping_cart, update_at, operation, user_changed, old_id_shopping_cart) 
	VALUES (NEW.id_shopping_cart, current_date, TG_OP, usuario, OLD.id_shopping_cart);
	RETURN NEW;
  END;
$$
LANGUAGE 'plpgsql';

--Trigger para registrar na tabela de log de usuario
CREATE OR REPLACE TRIGGER trg_shopping_carts_log
AFTER INSERT OR UPDATE OR delete ON shopping_carts
FOR EACH ROW
EXECUTE PROCEdure func_shopping_carts_log();

-----------------------------------------------------------------------------------------------------------
---- SEM TABELA DE LOG

-- Função de Trigger para atualizar a data de atualização na tabela trocadinha
CREATE OR REPLACE FUNCTION func_update_trocadinhas() RETURNS TRIGGER
AS
$$
	BEGIN
		UPDATE trocadinhas
		SET last_atualization = current_date
		WHERE id_trocadinha = new.id_trocadinha;
		RETURN NEW;
	END;
$$
LANGUAGE 'plpgsql';

CREATE OR REPLACE TRIGGER trg_update_trocadinhas
AFTER INSERT OR UPDATE ON trocadinhas
FOR EACH ROW
EXECUTE PROCEDURE func_update_trocadinhas();


-- Função de Trigger para registrar o histórico na tabela trocadinha
CREATE OR REPLACE FUNCTION func_hist_trocadinhas() RETURNS trigger 
AS
$$
  BEGIN
	IF OLD.id_user in (SELECT id_user FROM podium_trocadinhas(OLD.expiration_date)) THEN
		INSERT INTO history_trocadinhas(id_user, number_trocadinha, expiration_date, last_atualization) 
		VALUES (OLD.id_user, OLD.number_trocadinha, OLD.expiration_date, OLD.last_atualization);
	END IF;
	RETURN NEW;
  END
  $$
LANGUAGE 'plpgsql';

CREATE OR REPLACE TRIGGER trg_hist_trocadinhas
AFTER DELETE ON trocadinhas
FOR EACH ROW
EXECUTE PROCEDURE func_hist_trocadinhas();


-- Função de Trigger para registrar o histórico na tabela order
CREATE OR REPLACE FUNCTION func_hist_shopping_carts() RETURNS trigger 
AS
$$
  BEGIN
    INSERT INTO history_shopping_carts(id_user, id_shopping_cart_old, id_product, quantity, value)
    VALUES (
		OLD.id_user, 
		OLD.id_shopping_cart, 
		OLD.id_product, 
		OLD.quantity, 
		value_product(OLD.id_product, OLD.quantity));
    RETURN NEW;
  END;
$$
LANGUAGE 'plpgsql';

CREATE OR REPLACE TRIGGER trg_hist_shopping_carts
AFTER DELETE ON shopping_carts
FOR EACH ROW
EXECUTE PROCEDURE func_hist_shopping_carts();