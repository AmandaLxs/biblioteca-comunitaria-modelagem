-- 05_delete_commands.sql
USE biblioteca_comunitaria;

-- 1) Remover usuário inativo e sem empréstimos (exemplo)
DELETE FROM usuario
WHERE id = (SELECT id FROM usuario WHERE cpf = '00000000000' LIMIT 1);

-- 2) Excluir exemplar danificado (apenas se não estiver emprestado)
DELETE FROM exemplar
WHERE id = (SELECT ex.id FROM exemplar ex
            LEFT JOIN emprestimo em ON em.exemplar_id = ex.id AND em.data_devolucao_real IS NULL
            WHERE ex.codigo_exemplar = 'EX-9999' AND em.id IS NULL LIMIT 1);

-- 3) Excluir livro sem exemplares (limpeza)
DELETE FROM livro
WHERE id NOT IN (SELECT DISTINCT livro_id FROM exemplar);
