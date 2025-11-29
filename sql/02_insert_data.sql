-- 02_insert_data.sql
USE biblioteca_comunitaria;

-- CATEGORIAS
INSERT INTO categoria (nome, descricao) VALUES
('Literatura Brasileira','Romances e contos brasileiros'),
('Ficcao','Livros de ficção em geral'),
('Educacao','Livros acadêmicos e didáticos'),
('Infantil','Literatura infantil e juvenil');

-- AUTORES
INSERT INTO autor (nome, nacionalidade, data_nascimento) VALUES
('Machado de Assis','Brasileira','1839-06-21'),
('Clarice Lispector','Brasileira','1920-12-10'),
('George Orwell','Britânica','1903-06-25'),
('J. K. Rowling','Britânica','1965-07-31');

-- USUARIOS
INSERT INTO usuario (cpf, nome, endereco, telefone, email) VALUES
('11122233344','Joana Pereira','Rua A, 123','11999990000','joana@example.com'),
('22233344455','Carlos Souza','Rua B, 45','11988880000','carlos@example.com'),
('33344455566','Mariana Lima','Rua C, 78','11977770000','mariana@example.com'),
('44455566677','Pedro Alves','Av. Central, 10','11966660000','pedro@example.com');

-- LIVROS
INSERT INTO livro (isbn, titulo, subtitulo, ano_publicacao, edicao, editora, categoria_id, paginas) VALUES
('9788535909791','Dom Casmurro',NULL,1899,'1','Editora X',(SELECT id FROM categoria WHERE nome='Literatura Brasileira'),208),
('9788571643505','A Hora da Estrela',NULL,1977,'1','Editora Y',(SELECT id FROM categoria WHERE nome='Literatura Brasileira'),128),
('9780451524935','1984',NULL,1949,'1','Penguin',(SELECT id FROM categoria WHERE nome='Ficcao'),328),
('9780747532743','Harry Potter e a Pedra Filosofal',NULL,1997,'1','Bloomsbury',(SELECT id FROM categoria WHERE nome='Infantil'),223);

-- EXEMPLARES
INSERT INTO exemplar (codigo_exemplar, livro_id, estado_conservacao, localizacao, disponivel, adquirido_em) VALUES
('EX-0001', (SELECT id FROM livro WHERE isbn='9788535909791'), 'Bom','Prateleira 1', TRUE, '2015-05-10'),
('EX-0002', (SELECT id FROM livro WHERE isbn='9788535909791'), 'Regular','Prateleira 1', TRUE, '2016-02-20'),
('EX-0003', (SELECT id FROM livro WHERE isbn='9788571643505'), 'Otimo','Prateleira 2', TRUE, '2018-08-15'),
('EX-0004', (SELECT id FROM livro WHERE isbn='9780451524935'), 'Bom','Prateleira 3', TRUE, '2019-01-12'),
('EX-0005', (SELECT id FROM livro WHERE isbn='9780747532743'), 'Bom','Prateleira Infantil', TRUE, '2020-11-05');

-- LIVRO_AUTOR (N:N)
INSERT INTO livro_autor (livro_id, autor_id) VALUES
( (SELECT id FROM livro WHERE isbn='9788535909791'), (SELECT id FROM autor WHERE nome='Machado de Assis') ),
( (SELECT id FROM livro WHERE isbn='9788571643505'), (SELECT id FROM autor WHERE nome='Clarice Lispector') ),
( (SELECT id FROM livro WHERE isbn='9780451524935'), (SELECT id FROM autor WHERE nome='George Orwell') ),
( (SELECT id FROM livro WHERE isbn='9780747532743'), (SELECT id FROM autor WHERE nome='J. K. Rowling') );

-- EMPRESTIMOS
INSERT INTO emprestimo (exemplar_id, usuario_id, data_emprestimo, data_prevista_devolucao, data_devolucao_real, multa_aplicada, status) VALUES
( (SELECT id FROM exemplar WHERE codigo_exemplar='EX-0001'), (SELECT id FROM usuario WHERE cpf='11122233344'), CURDATE() - INTERVAL 20 DAY, CURDATE() - INTERVAL 5 DAY, NULL, 0.00, 'Ativo'),
( (SELECT id FROM exemplar WHERE codigo_exemplar='EX-0003'), (SELECT id FROM usuario WHERE cpf='22233344455'), CURDATE() - INTERVAL 2 DAY, CURDATE() + INTERVAL 13 DAY, NULL, 0.00, 'Ativo'),
( (SELECT id FROM exemplar WHERE codigo_exemplar='EX-0004'), (SELECT id FROM usuario WHERE cpf='33344455566'), CURDATE() - INTERVAL 40 DAY, CURDATE() - INTERVAL 25 DAY, CURDATE() - INTERVAL 10 DAY, 5.00, 'Devolvido');

-- Atualiza disponibilidade dos exemplares emprestados
UPDATE exemplar SET disponivel = FALSE WHERE codigo_exemplar IN ('EX-0001','EX-0003');

-- MULTAS (exemplo para empréstimo atrasado)
INSERT INTO multa (emprestimo_id, valor, paga, descricao) VALUES
( (SELECT e.id FROM emprestimo e JOIN exemplar ex ON e.exemplar_id = ex.id WHERE ex.codigo_exemplar='EX-0001' LIMIT 1), 15.00, FALSE, 'Atraso 10 dias');

