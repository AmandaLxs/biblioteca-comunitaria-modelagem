-- 01_create_schema_and_tables.sql
-- Script MySQL (Workbench). Ajuste se usar PostgreSQL (SERIAL -> SERIAL/IDENTITY etc).

-- Cria schema / banco
CREATE DATABASE IF NOT EXISTS biblioteca_comunitaria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE biblioteca_comunitaria;

-- Tabela: USUARIO
CREATE TABLE IF NOT EXISTS usuario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cpf CHAR(11) UNIQUE NOT NULL,
  nome VARCHAR(150) NOT NULL,
  endereco VARCHAR(255),
  telefone VARCHAR(20),
  email VARCHAR(150),
  ativo BOOLEAN DEFAULT TRUE,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: CATEGORIA
CREATE TABLE IF NOT EXISTS categoria (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE,
  descricao TEXT
);

-- Tabela: AUTOR
CREATE TABLE IF NOT EXISTS autor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  nacionalidade VARCHAR(80),
  data_nascimento DATE
);

-- Tabela: LIVRO
CREATE TABLE IF NOT EXISTS livro (
  id INT AUTO_INCREMENT PRIMARY KEY,
  isbn CHAR(13) UNIQUE NOT NULL,
  titulo VARCHAR(250) NOT NULL,
  ano_publicacao YEAR,
  edicao VARCHAR(50),
  editora VARCHAR(120),
  categoria_id INT,
  paginas INT,
  disponivel BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_livro_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

-- Tabela: EXEMPLAR
CREATE TABLE IF NOT EXISTS exemplar (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo_exemplar VARCHAR(50) NOT NULL UNIQUE,
  livro_id INT NOT NULL,
  estado_conservacao VARCHAR(80),
  localizacao VARCHAR(100),
  disponivel BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_exemplar_livro FOREIGN KEY (livro_id) REFERENCES livro(id)
);

-- Tabela: EMPRESTIMO
CREATE TABLE IF NOT EXISTS emprestimo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  exemplar_id INT NOT NULL,
  usuario_id INT NOT NULL,
  data_emprestimo DATE NOT NULL,
  data_prevista_devolucao DATE NOT NULL,
  data_devolucao_real DATE,
  multa_aplicada DECIMAL(7,2) DEFAULT 0.00,
  CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (exemplar_id) REFERENCES exemplar(id),
  CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- Tabela: MULTA (separada para rastrear pagamentos)
CREATE TABLE IF NOT EXISTS multa (
  id INT AUTO_INCREMENT PRIMARY KEY,
  emprestimo_id INT NOT NULL UNIQUE,
  valor DECIMAL(7,2) NOT NULL,
  paga BOOLEAN DEFAULT FALSE,
  data_emissao DATE DEFAULT CURDATE(),
  data_pagamento DATE,
  CONSTRAINT fk_multa_emprestimo FOREIGN KEY (emprestimo_id) REFERENCES emprestimo(id)
);

-- Tabela associativa: LIVRO_AUTOR (N:N)
CREATE TABLE IF NOT EXISTS livro_autor (
  livro_id INT NOT NULL,
  autor_id INT NOT NULL,
  PRIMARY KEY (livro_id, autor_id),
  CONSTRAINT fk_la_livro FOREIGN KEY (livro_id) REFERENCES livro(id) ON DELETE CASCADE,
  CONSTRAINT fk_la_autor FOREIGN KEY (autor_id) REFERENCES autor(id) ON DELETE CASCADE
);

-- Índices (exemplos)
CREATE INDEX idx_usuario_email ON usuario(email);
CREATE INDEX idx_exemplar_livro ON exemplar(livro_id);
CREATE INDEX idx_emprestimo_usuario ON emprestimo(usuario_id);
