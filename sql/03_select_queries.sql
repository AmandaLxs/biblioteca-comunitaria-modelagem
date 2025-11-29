-- 03_select_queries.sql
USE biblioteca_comunitaria;

-- 1) Lista de livros disponíveis com autor e categoria
SELECT l.titulo, l.isbn, a.nome AS autor, c.nome AS categoria, l.ano_publicacao
FROM livro l
JOIN livro_autor la ON l.id = la.livro_id
JOIN autor a ON la.autor_id = a.id
LEFT JOIN categoria c ON l.categoria_id = c.id
WHERE l.disponivel = TRUE
ORDER BY l.titulo;

-- 2) Empréstimos atrasados (data_devolucao_real IS NULL e data_prevista_devolucao < hoje)
SELECT e.id, u.nome AS usuario, ex.codigo_exemplar, l.titulo, e.data_prevista_devolucao
FROM emprestimo e
JOIN usuario u ON e.usuario_id = u.id
JOIN exemplar ex ON e.exemplar_id = ex.id
JOIN livro l ON ex.livro_id = l.id
WHERE e.data_devolucao_real IS NULL
  AND e.data_prevista_devolucao < CURDATE()
ORDER BY e.data_prevista_devolucao ASC;

-- 3) Quantidade de exemplares por livro (agregação)
SELECT l.titulo, COUNT(ex.id) AS total_exemplares, SUM(ex.disponivel = TRUE) AS disponiveis
FROM livro l
LEFT JOIN exemplar ex ON ex.livro_id = l.id
GROUP BY l.id, l.titulo
ORDER BY total_exemplares DESC;

-- 4) Usuários com multas pendentes
SELECT u.nome, u.cpf, m.valor, m.data_emissao
FROM multa m
JOIN emprestimo e ON m.emprestimo_id = e.id
JOIN usuario u ON e.usuario_id = u.id
WHERE m.paga = FALSE
ORDER BY m.data_emissao;

-- 5) Buscar livros por termo no título (LIKE) com limite
SELECT id, titulo, isbn FROM livro
WHERE titulo LIKE '%Hora%'
ORDER BY titulo
LIMIT 10;
