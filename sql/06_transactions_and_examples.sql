-- 06_transactions_and_examples.sql
USE biblioteca_comunitaria;

-- Exemplo: registrar empréstimo com verificação de disponibilidade (transação)
START TRANSACTION;
-- verificar exemplar disponível
SELECT id, disponivel FROM exemplar WHERE codigo_exemplar = 'EX-0004' FOR UPDATE;
-- se disponivel = TRUE então:
INSERT INTO emprestimo (exemplar_id, usuario_id, data_emprestimo, data_prevista_devolucao)
VALUES ( (SELECT id FROM exemplar WHERE codigo_exemplar='EX-0004'), (SELECT id FROM usuario WHERE cpf='33344455566'), CURDATE(), DATE_ADD(CURDATE(), INTERVAL 15 DAY) );
UPDATE exemplar SET disponivel = FALSE WHERE codigo_exemplar = 'EX-0004';
COMMIT;
