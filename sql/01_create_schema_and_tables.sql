-- 01_create_schema_and_tables.sql
-- MySQL - DDL aprimorado para Biblioteca Comunitária

DROP DATABASE IF EXISTS biblioteca_comunitaria;
CREATE DATABASE biblioteca_comunitaria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE biblioteca_comunitaria;

-- Tabela USUARIO
CREATE TABLE usuario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cpf CHAR(11) UNIQUE NOT NULL,
  nome VARCHAR(150) NOT NULL,
  endereco VARCHAR(255),
  telefone VARCHAR(20),
  email VARCHAR(150),
  ativo BOOLEAN DEFAULT TRUE,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabela CATEGORIA
CREATE TABLE categoria (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE,
  descricao TEXT
) ENGINE=InnoDB;

-- Tabela AUTOR
CREATE TABLE autor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  nacionalidade VARCHAR(80),
  data_nascimento DATE
) ENGINE=InnoDB;

-- Tabela LIVRO
CREATE TABLE livro (
  id INT AUTO_INCREMENT PRIMARY KEY,
  isbn CHAR(13) UNIQUE NOT NULL,
  titulo VARCHAR(250) NOT NULL,
  subtitulo VARCHAR(250),
  ano_publicacao YEAR,
  edicao VARCHAR(50),
  editora VARCHAR(120),
  categoria_id INT,
  paginas INT,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  disponivel BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_livro_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela EXEMPLAR (livros físicos, N exemplar por livro)
CREATE TABLE exemplar (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo_exemplar VARCHAR(50) NOT NULL UNIQUE,
  livro_id INT NOT NULL,
  estado_conservacao VARCHAR(80) DEFAULT 'Bom',
  localizacao VARCHAR(100),
  disponivel BOOLEAN DEFAULT TRUE,
  adquirido_em DATE,
  CONSTRAINT fk_exemplar_livro FOREIGN KEY (livro_id) REFERENCES livro(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela EMPRESTIMO
CREATE TABLE emprestimo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  exemplar_id INT NOT NULL,
  usuario_id INT NOT NULL,
  data_emprestimo DATE NOT NULL,
  data_prevista_devolucao DATE NOT NULL,
  data_devolucao_real DATE,
  multa_aplicada DECIMAL(7,2) DEFAULT 0.00,
  status ENUM('Ativo','Devolvido','Atrasado') DEFAULT 'Ativo',
  CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (exemplar_id) REFERENCES exemplar(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela MULTA (detalhes de multas)
CREATE TABLE multa (
  id INT AUTO_INCREMENT PRIMARY KEY,
  emprestimo_id INT NOT NULL UNIQUE,
  valor DECIMAL(7,2) NOT NULL,
  paga BOOLEAN DEFAULT FALSE,
  data_emissao DATE DEFAULT (CURRENT_DATE),
  data_pagamento DATE,
  descricao VARCHAR(255),
  CONSTRAINT fk_multa_emprestimo FOREIGN KEY (emprestimo_id) REFERENCES emprestimo(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabela associativa LIVRO_AUTOR (N:N)
CREATE TABLE livro_autor (
  livro_id INT NOT NULL,
  autor_id INT NOT NULL,
  papel VARCHAR(80) DEFAULT 'Autor',
  PRIMARY KEY (livro_id, autor_id),
  CONSTRAINT fk_la_livro FOREIGN KEY (livro_id) REFERENCES livro(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_la_autor FOREIGN KEY (autor_id) REFERENCES autor(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Índices adicionais
CREATE INDEX idx_usuario_email ON usuario(email);
CREATE INDEX idx_exemplar_livro ON exemplar(livro_id);
CREATE INDEX idx_emprestimo_usuario ON emprestimo(usuario_id);
CREATE INDEX idx_livro_isbn ON livro(isbn);
