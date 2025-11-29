-- 04_update_commands.sql
USE biblioteca_comunitaria;

-- 1) Registrar devolução e recalcular disponibilidade
START TRANSACTION;
UPDATE emprestimo
SET data_devolucao_real = CURDATE(),
    multa_aplicada = 0.00
WHERE id = 2; -- ajuste conforme id real
UPDATE exemplar ex
JOIN emprestimo em ON ex.id = em.exemplar_id
SET ex.disponivel = TRUE
WHERE em.id = 2;
COMMIT;

-- 2) Marcar multa como paga
UPDATE multa SET paga = TRUE, data_pagamento = CURDATE()
WHERE id = (SELECT id FROM multa WHERE paga = FALSE LIMIT 1);

-- 3) Ajuste de estado de conservação em lote
UPDATE exemplar SET estado_conservacao = 'Reparar'
WHERE estado_conservacao = 'Regular' AND localizacao = 'Prateleira 1';
