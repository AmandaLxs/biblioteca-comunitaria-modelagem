# Biblioteca Comunitária - Atividade 4 (SQL) - Amanda Lima da Silva

## Objetivo
Implementar e manipular dados com SQL (DML) em um projeto - mini-mundo Biblioteca Comunitária. O repositório contém scripts DDL e DML prontos para execução em MySQL Workbench.

## Estrutura do repositório
- `sql/01_create_schema_and_tables.sql`  - DDL
- `sql/02_insert_data.sql`              - INSERTs (povoamento)
- `sql/03_select_queries.sql`           - SELECTs (5 exemplos: JOIN/WHERE/ORDER BY/GROUP BY/LIMIT)
- `sql/04_update_commands.sql`          - UPDATEs (4 exemplos)
- `sql/05_delete_commands.sql`          - DELETEs (4 exemplos)
- `sql/06_transactions_and_examples.sql`- Transações exemplo
- `docs/model_logico_summary.md`        - Resumo do modelo lógico

## Como executar (MySQL Workbench) — passo rápido
1. Baixe/clone o repositório.
2. No MySQL Workbench, conecte ao servidor local.
3. Execute na ordem:
   - `sql/01_create_schema_and_tables.sql`
   - `sql/02_insert_data.sql`
   - Teste consultas em `sql/03_select_queries.sql`
   - Teste updates em `sql/04_update_commands.sql`
   - Teste deletes em `sql/05_delete_commands.sql`
   - Teste transação em `sql/06_transactions_and_examples.sql`
4. Verificações úteis:
   - `SHOW DATABASES;`
   - `USE biblioteca_comunitaria;`
   - `SHOW TABLES;`
   - `SELECT COUNT(*) FROM usuario;`

## Entrega
- Link do repositório (público): https://github.com/AmandaLxs/biblioteca-comunitaria-modelagem

## Observações
- Os scripts foram projetados para MySQL (Workbench).
- Se ocorrerem erros por execução duplicada, rode `DROP DATABASE biblioteca_comunitaria;` e reexecute os scripts na ordem.

