-- 05_delete_commands.sql
USE biblioteca_comunitaria;

-- DELETE 1: Remover usuário teste sem empréstimos
DELETE FROM usuario
WHERE cpf = '00000000000' 
  AND id NOT IN (SELECT usuario_id FROM emprestimo);

-- DELETE 2: Excluir exemplar danificado (apenas se não estiver emprestado)
DELETE FROM exemplar
WHERE codigo_exemplar = 'EX-9999'
  AND id NOT IN (SELECT exemplar_id FROM emprestimo WHERE data_devolucao_real IS NULL);

-- DELETE 3: Excluir livros sem exemplares (limpeza)
DELETE FROM livro
WHERE id NOT IN (SELECT DISTINCT livro_id FROM exemplar);

-- DELETE 4: Excluir multas pagas antigas (limpeza condicional)
DELETE FROM multa
WHERE paga = TRUE AND data_emissao < DATE_SUB(CURDATE(), INTERVAL 365 DAY);
