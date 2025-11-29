# Biblioteca Comunitária - Atividade 4 (SQL)

## Objetivo
Repositório com scripts SQL para criação, povoamento e manipulação de dados do sistema Biblioteca Comunitária — Atividade 4 do curso de Modelagem de Banco de Dados.

## Estrutura
- `sql/01_create_schema_and_tables.sql`  - DDL: criação do schema e tabelas
- `sql/02_insert_data.sql`              - DML: inserts de exemplo para povoar o banco
- `sql/03_select_queries.sql`           - SELECTs (JOIN, agregação, WHERE, LIKE)
- `sql/04_update_commands.sql`          - Exemplos de UPDATE (≥3)
- `sql/05_delete_commands.sql`          - Exemplos de DELETE (≥3)
- `sql/06_transactions_and_examples.sql`- Transações e exemplos avançados
- `docs/model_logico_summary.md`        - Resumo do modelo lógico
- `.gitignore`

## Como executar (MySQL Workbench)
1. No MySQL Workbench, conecte ao servidor MySQL.
2. Execute na ordem:
   - `sql/01_create_schema_and_tables.sql`
   - `sql/02_insert_data.sql`
   - Teste as consultas em `sql/03_select_queries.sql`
   - Teste updates e deletes em ambiente de desenvolvimento (usar `sql/04_*` e `sql/05_*`)
3. Observações:
   - Use transações para operações críticas (`START TRANSACTION; ... COMMIT;`)
   - Se usar PostgreSQL, adapte `AUTO_INCREMENT` → `SERIAL` e funções de data

## Autor
Amanda Lima da Silva

