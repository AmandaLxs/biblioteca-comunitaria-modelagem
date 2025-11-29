-- 04_update_commands.sql
USE biblioteca_comunitaria;

-- UPDATE 1: Registrar devolução (ajusta emprestimo e exemplar)
START TRANSACTION;
UPDATE emprestimo
SET data_devolucao_real = CURDATE(),
    multa_aplicada = 0.00,
    status = 'Devolvido'
WHERE id = (SELECT id FROM emprestimo WHERE status = 'Ativo' LIMIT 1);
UPDATE exemplar ex
JOIN emprestimo em ON ex.id = em.exemplar_id
SET ex.disponivel = TRUE
WHERE em.id = (SELECT id FROM emprestimo WHERE status = 'Devolvido' ORDER BY data_devolucao_real DESC LIMIT 1);
COMMIT;

-- UPDATE 2: Marcar multa como paga
UPDATE multa
SET paga = TRUE, data_pagamento = CURDATE()
WHERE paga = FALSE
LIMIT 1;

-- UPDATE 3: Ajustar estado de conservação
UPDATE exemplar
SET estado_conservacao = 'Reparar'
WHERE estado_conservacao = 'Regular' AND localizacao = 'Prateleira 1';

-- UPDATE 4: Atualizar disponibilidade em lote (exemplo)
UPDATE exemplar
SET disponivel = FALSE
WHERE codigo_exemplar IN ('EX-0002') AND disponivel = TRUE;
