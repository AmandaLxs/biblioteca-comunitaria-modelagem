-- 02_insert_data.sql
USE biblioteca_comunitaria;

-- CATEGORIA (algumas categorias)
INSERT INTO categoria (nome, descricao) VALUES
('Literatura Brasileira', 'Obras de autores brasileiros'),
('Ficção', 'Ficção em geral'),
('Educação', 'Livros acadêmicos e didáticos');

-- AUTORES
INSERT INTO autor (nome, nacionalidade, data_nascimento) VALUES
('Machado de Assis','Brasileira','1839-06-21'),
('Clarice Lispector','Brasileira','1920-12-10'),
('George Orwell','Britânica','1903-06-25');

-- USUÁRIOS
INSERT INTO usuario (cpf, nome, endereco, telefone, email) VALUES
('11122233344','Joana Pereira','Rua A, 123','11999990000','joana@example.com'),
('22233344455','Carlos Souza','Rua B, 45','11988880000','carlos@example.com'),
('33344455566','Mariana Lima','Rua C, 78','11977770000','mariana@example.com');

-- LIVROS
INSERT INTO livro (isbn, titulo, ano_publicacao, edicao, editora, categoria_id, paginas, disponivel) VALUES
('9788535909791','Dom Casmurro',1899,'1','Editora X', (SELECT id FROM categoria WHERE nome='Literatura Brasileira'), 208, TRUE),
('9788571643505','A Hora da Estrela',1977,'2','Editora Y', (SELECT id FROM categoria WHERE nome='Literatura Brasileira'), 128, TRUE),
('9780451524935','1984',1949,'1','Penguin', (SELECT id FROM categoria WHERE nome='Ficção'), 328, TRUE);

-- EXEMPLARES
INSERT INTO exemplar (codigo_exemplar, livro_id, estado_conservacao, localizacao, disponivel) VALUES
('EX-0001', (SELECT id FROM livro WHERE isbn='9788535909791'), 'Bom','Prateleira 1', TRUE),
('EX-0002', (SELECT id FROM livro WHERE isbn='9788535909791'), 'Regular','Prateleira 1', TRUE),
('EX-0003', (SELECT id FROM livro WHERE isbn='9788571643505'), 'Ótimo','Prateleira 2', TRUE),
('EX-0004', (SELECT id FROM livro WHERE isbn='9780451524935'), 'Bom','Prateleira 3', TRUE);

-- LIGANDO LIVROS A AUTORES (Livro-Autor)
INSERT INTO livro_autor (livro_id, autor_id) VALUES
( (SELECT id FROM livro WHERE isbn='9788535909791'), (SELECT id FROM autor WHERE nome='Machado de Assis') ),
( (SELECT id FROM livro WHERE isbn='9788571643505'), (SELECT id FROM autor WHERE nome='Clarice Lispector') ),
( (SELECT id FROM livro WHERE isbn='9780451524935'), (SELECT id FROM autor WHERE nome='George Orwell') );

-- EMPRESTIMOS (exemplo)
INSERT INTO emprestimo (exemplar_id, usuario_id, data_emprestimo, data_prevista_devolucao) VALUES
( (SELECT id FROM exemplar WHERE codigo_exemplar='EX-0001'), (SELECT id FROM usuario WHERE cpf='11122233344'), CURDATE() - INTERVAL 20 DAY, CURDATE() - INTERVAL 5 DAY ),
( (SELECT id FROM exemplar WHERE codigo_exemplar='EX-0003'), (SELECT id FROM usuario WHERE cpf='22233344455'), CURDATE() - INTERVAL 2 DAY, CURDATE() + INTERVAL 13 DAY );

-- Atualiza disponibilidade do exemplar emprestado (boa prática: transação em produção)
UPDATE exemplar SET disponivel = FALSE WHERE codigo_exemplar = 'EX-0001';

-- MULTA (exemplo para o empréstimo vencido)
INSERT INTO multa (emprestimo_id, valor, paga) VALUES
( (SELECT e.id FROM emprestimo e JOIN exemplar ex ON e.exemplar_id = ex.id WHERE ex.codigo_exemplar='EX-0001'), 15.00, FALSE);
