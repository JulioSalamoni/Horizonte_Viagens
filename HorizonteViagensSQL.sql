CREATE DATABASE IF NOT EXISTS HORIZONTEVIAGENS;
USE HORIZONTEVIAGENS ;

-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.PASSAPORTE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.PASSAPORTE (
  id_passaporte INT NOT NULL AUTO_INCREMENT,
  nome_titular_passaporte VARCHAR(50) NOT NULL,
  data_nimento_passaporte DATE NOT NULL,
  local_nimento VARCHAR(30) NOT NULL,
  sexo_titular_passaporte ENUM("Masculino", "Feminino", "Outros") NOT NULL,
  nacionalidade_titular_passaporte VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_passaporte))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.ENDERECO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.ENDERECO (
  id_endereco INT NOT NULL AUTO_INCREMENT,
  logradouro_endereco VARCHAR(70) NOT NULL,
  numero_endereco VARCHAR(10) NULL,
  cep_endereco VARCHAR(10) NULL,
  bairro_endereco VARCHAR(50) NULL,
  cidade_endereco VARCHAR(45) NULL,
  estado_endereco VARCHAR(45) NULL,
  complemento_endereco VARCHAR(30) NULL,
  PRIMARY KEY (id_endereco))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.TELEFONE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.TELEFONE (
  id_telefone INT NOT NULL AUTO_INCREMENT,
  numero_telefone VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_telefone),
  UNIQUE INDEX numero_telefone_UNIQUE (numero_telefone ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.CLIENTE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.CLIENTE (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  id_passaporte INT NOT NULL,
  id_telefone INT NOT NULL,
  id_endereco INT NOT NULL,
  nome_cliente VARCHAR(50) NOT NULL,
  cpf_cliente VARCHAR(11) NOT NULL,
  email_cliente VARCHAR(50) NOT NULL,
  nome_social_cliente VARCHAR(50) NULL,
  estado_civil_cliente VARCHAR(20) NULL,
  data_cadastro_cliente DATE NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (id_cliente),
  UNIQUE INDEX email_cliente_UNIQUE (email_cliente ) ,
  UNIQUE INDEX cpf_cliente_UNIQUE (cpf_cliente ) ,
  INDEX fk_CLIENTE_PASSAPORTE1_idx (id_passaporte ) ,
  INDEX fk_CLIENTE_TELEFONE1_idx (id_telefone ) ,
  INDEX fk_CLIENTE_ENDERECO1_idx (id_endereco ) ,
  CONSTRAINT fk_CLIENTE_PASSAPORTE1
    FOREIGN KEY (id_passaporte)
    REFERENCES HORIZONTEVIAGENS.PASSAPORTE (id_passaporte)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_CLIENTE_TELEFONE1
    FOREIGN KEY (id_telefone)
    REFERENCES HORIZONTEVIAGENS.TELEFONE (id_telefone)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_CLIENTE_ENDERECO1
    FOREIGN KEY (id_endereco)
    REFERENCES HORIZONTEVIAGENS.ENDERECO (id_endereco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.FUNCIONARIO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.FUNCIONARIO (
  id_funcionario INT NOT NULL AUTO_INCREMENT,
  nome_funcionario VARCHAR(50) NOT NULL,
  cpf_funcionario VARCHAR(11) NOT NULL,
  email_funcionario VARCHAR(50) NOT NULL,
  cep_funcionario VARCHAR(10) NULL,
  data_nimento_funcionario DATE NOT NULL,
  sexo_funcionario ENUM("Masculino", "Feminino", "Outros") NOT NULL,
  nome_social_funcionario VARCHAR(50) NULL,
  data_admissao DATE NULL DEFAULT current_timestamp,
  data_demissao DATE NULL,
  pis VARCHAR(11) NOT NULL,
  salario DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (id_funcionario),
  UNIQUE INDEX cpf_funcionario_UNIQUE (cpf_funcionario ) ,
  UNIQUE INDEX email_funcionario_UNIQUE (email_funcionario ) ,
  UNIQUE INDEX pis_UNIQUE (pis ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.FORMA_DE_PAGAMENTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.FORMA_DE_PAGAMENTO (
  id_forma_de_pagamento INT NOT NULL AUTO_INCREMENT,
  descricao_forma_de_pagamento VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_forma_de_pagamento))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.HOSPEDAGEM
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.HOSPEDAGEM (
  id_hospedagem INT NOT NULL AUTO_INCREMENT,
  descricao_hospedagem VARCHAR(50) NOT NULL,
  valor_hospedagem DECIMAL(7,2) NOT NULL,
  detalhes_hospedagem TEXT NOT NULL,
  PRIMARY KEY (id_hospedagem))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.PASSAGEM
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.PASSAGEM (
  id_passagem INT NOT NULL AUTO_INCREMENT,
  descricao_passagem VARCHAR(50) NOT NULL,
  valor_passagem DECIMAL(7,2) NOT NULL,
  detalhes_passagem TEXT NOT NULL,
  PRIMARY KEY (id_passagem))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.DISPONIBILIDADE_HOSPEDAGEM
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.DISPONIBILIDADE_HOSPEDAGEM (
  id_disponibilidade_hospedagem INT NOT NULL AUTO_INCREMENT,
  id_hospedagem INT NOT NULL,
  quantidade_disponivel_hospedagem INT NOT NULL,
  PRIMARY KEY (id_disponibilidade_hospedagem),
  INDEX fk_DISPONIBILIDADE_HOSPEDAGEM_HOSPEDAGEM1_idx (id_hospedagem ) ,
  CONSTRAINT fk_DISPONIBILIDADE_HOSPEDAGEM_HOSPEDAGEM1
    FOREIGN KEY (id_hospedagem)
    REFERENCES HORIZONTEVIAGENS.HOSPEDAGEM (id_hospedagem)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.DISPONIBILIDADE_PASSAGEM
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.DISPONIBILIDADE_PASSAGEM (
  id_disponibilidade_passagem INT NOT NULL AUTO_INCREMENT,
  id_passagem INT NOT NULL,
  quantidade_disponivel_passagem INT NOT NULL,
  PRIMARY KEY (id_disponibilidade_passagem),
  INDEX fk_DISPONIBILIDADE_PASSAGEM_PASSAGEM1_idx (id_passagem ) ,
  CONSTRAINT fk_DISPONIBILIDADE_PASSAGEM_PASSAGEM1
    FOREIGN KEY (id_passagem)
    REFERENCES HORIZONTEVIAGENS.PASSAGEM (id_passagem)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.VIAGEM
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.VIAGEM (
  id_viagem INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  id_hospedagem INT NOT NULL,
  id_passagem INT NOT NULL,
  data_inicio_viagem DATE NOT NULL,
  data_fim_viagem DATE NOT NULL,
  valor_total_viagem DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (id_viagem),
  INDEX fk_VIAGEM_CLIENTE1_idx (id_cliente ) ,
  INDEX fk_VIAGEM_PASSAGEM1_idx (id_passagem ) ,
  INDEX fk_VIAGEM_HOSPEDAGEM1_idx (id_hospedagem ) ,
  CONSTRAINT fk_VIAGEM_CLIENTE1
    FOREIGN KEY (id_cliente)
    REFERENCES HORIZONTEVIAGENS.CLIENTE (id_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_VIAGEM_PASSAGEM1
    FOREIGN KEY (id_passagem)
    REFERENCES HORIZONTEVIAGENS.PASSAGEM (id_passagem)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_VIAGEM_HOSPEDAGEM1
    FOREIGN KEY (id_hospedagem)
    REFERENCES HORIZONTEVIAGENS.HOSPEDAGEM (id_hospedagem)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table HORIZONTEVIAGENS.VENDA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HORIZONTEVIAGENS.VENDA (
  id_venda INT NOT NULL AUTO_INCREMENT,
  id_funcionario INT NOT NULL,
  id_viagem INT NOT NULL,
  id_forma_de_pagamento INT NOT NULL,
  data_Hora DATE NOT NULL DEFAULT current_timestamp,
  total DECIMAL(8,2) NOT NULL,
  status_venda VARCHAR(10) NULL,
  PRIMARY KEY (id_venda),
  INDEX fk_VENDA_VIAGEM_idx (id_viagem ) ,
  INDEX fk_VENDA_FUNCIONARIO1_idx (id_funcionario ) ,
  INDEX fk_VENDA_FORMA_DE_PAGAMENTO1_idx (id_forma_de_pagamento ) ,
  CONSTRAINT fk_VENDA_VIAGEM
    FOREIGN KEY (id_viagem)
    REFERENCES HORIZONTEVIAGENS.VIAGEM (id_viagem)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_VENDA_FUNCIONARIO1
    FOREIGN KEY (id_funcionario)
    REFERENCES HORIZONTEVIAGENS.FUNCIONARIO (id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_VENDA_FORMA_DE_PAGAMENTO1
    FOREIGN KEY (id_forma_de_pagamento)
    REFERENCES HORIZONTEVIAGENS.FORMA_DE_PAGAMENTO (id_forma_de_pagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- --------------------------------------- INSERTS ---------------------------------------------------------------------------------------------


INSERT INTO FUNCIONARIO
(nome_funcionario, cpf_funcionario, email_funcionario, cep_funcionario,
data_nimento_funcionario, sexo_funcionario, nome_social_funcionario,
data_admissao, data_demissao, pis, salario)
VALUES
('Julio Cezar Salamoni', '12345678901', 'julio.salamoni@horizonte.com', '89010000',
'2003-08-06', 'Masculino', NULL, '2022-01-10', NULL, '12345678901', 4200.00),

('Mariana Rocha', '23456789012', 'mariana.rocha@horizonte.com', '89020000',
'2005-08-22', 'Feminino', NULL, '2023-03-01', NULL, '23456789012', 3900.00),

('Gabriel Caruso', '34567890123', 'gabriel.caruso@horizonte.com', '89030000',
'2004-11-12', 'Masculino', NULL, '2024-02-15', NULL, '34567890123', 3500.00),

('Larissa Sazacalatacatis', '45678901234', 'larissa.szk@horizonte.com', '89040000',
'2004-06-27', 'Feminino', NULL, '2021-09-20', NULL, '45678901234', 4800.00),

('Alex Pinto', '56789012345', 'alex.pinto@horizonte.com', '89050000',
'2005-04-30', 'Masculino', NULL, '2020-05-18', NULL, '56789012345', 5500.00);

--

INSERT INTO FORMA_DE_PAGAMENTO
(descricao_forma_de_pagamento)
VALUES
('Dinheiro'),
('PIX'),
('Cartão de Débito'),
('Cartão de Crédito'),
('Boleto Bancário'),
('Transferência Bancária');

-- 

INSERT INTO HOSPEDAGEM
(descricao_hospedagem, valor_hospedagem, detalhes_hospedagem)
VALUES
('Hotel Copacabana Palace - Rio de Janeiro', 1450.00,
'Quarto luxo com café da manhã e vista para o mar.'),

('Hotel Fasano - São Paulo', 980.00,
'Suíte executiva com café da manhã incluso.'),

('Resort Costão do Santinho - Florianópolis', 1750.00,
'Pacote all inclusive com acesso às piscinas.'),

('Hotel Wish Foz do Iguaçu', 890.00,
'Quarto casal com café da manhã e estacionamento.'),

('Hotel Vila Galé Salvador', 760.00,
'Quarto standard com piscina e academia.');

--

INSERT INTO DISPONIBILIDADE_HOSPEDAGEM
(id_hospedagem, quantidade_disponivel_hospedagem)
VALUES
(1,20),
(2,15),
(3,10),
(4,18),
(5,25);

--

INSERT INTO PASSAGEM
(descricao_passagem, valor_passagem, detalhes_passagem)
VALUES
('São Paulo → Rio de Janeiro', 420.00,
'Voo direto com bagagem de mão inclusa.'),

('Curitiba → Florianópolis', 280.00,
'Voo econômico com duração de 50 minutos.'),

('São Paulo → Foz do Iguaçu', 560.00,
'Voo direto com bagagem despachada.'),

('Belo Horizonte → Salvador', 710.00,
'Voo com uma conexão e bagagem inclusa.'),

('Brasília → Recife', 680.00,
'Voo direto em classe econômica.');

-- 

INSERT INTO DISPONIBILIDADE_PASSAGEM
(id_passagem, quantidade_disponivel_passagem)
VALUES
(1,60),
(2,45),
(3,35),
(4,50),
(5,40);
