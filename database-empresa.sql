CREATE DATABASE empresa;
use empresa;

CREATE TABLE produto (
codigo VARCHAR (3) PRIMARY KEY,
descricao VARCHAR (50) UNIQUE,
estoque INT NOT NULL DEFAULT 0
);

INSERT INTO produto (codigo, descricao,estoque) VALUES
('001', 'notebook', 30),
('002', 'headset', 10),
('003', 'teclado', 45);

CREATE TABLE venda (
venda INT AUTO_INCREMENT PRIMARY KEY,
produto VARCHAR (3),
quantidade INT
);

INSERT INTO venda (produto, quantidade) VALUES
('001', 5),
('002', 5),
('003', 5);

DELIMITER $

CREATE TRIGGER venda_insert AFTER INSERT
ON venda
FOR EACH ROW
BEGIN
	UPDATE produto SET estoque = estoque - NEW.quantidade
WHERE codigo = NEW.produto;
END$

CREATE TRIGGER venda_delete AFTER DELETE
ON venda
FOR EACH ROW
BEGIN
	UPDATE produto SET estoque = estoque + OLD.quantidade
WHERE codigo = OLD.produto;
END$

DELIMITER ;


DELIMITER //
CREATE PROCEDURE vendaDiaria()
BEGIN
SELECT * FROM venda;
END//

call vendaDiaria()