-- 06_transactions_and_examples.sql
USE biblioteca_comunitaria;

-- Exemplo transacional: registrar novo empréstimo de forma segura
START TRANSACTION;

-- 1) Verifica exemplar disponível (FOR UPDATE trava linha)
SELECT id, disponivel FROM exemplar WHERE codigo_exemplar = 'EX-0005' FOR UPDATE;

-- 2) Inserir empréstimo se disponível
INSERT INTO emprestimo (exemplar_id, usuario_id, data_emprestimo, data_prevista_devolucao, status)
VALUES (
  (SELECT id FROM exemplar WHERE codigo_exemplar = 'EX-0005'),
  (SELECT id FROM usuario WHERE cpf = '44455566677'),
  CURDATE(),
  DATE_ADD(CURDATE(), INTERVAL 14 DAY),
  'Ativo'
);

-- 3) Atualiza disponibilidade
UPDATE exemplar SET disponivel = FALSE WHERE codigo_exemplar = 'EX-0005';

COMMIT;
