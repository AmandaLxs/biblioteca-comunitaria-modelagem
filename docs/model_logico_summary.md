# Resumo do Modelo Lógico - Biblioteca Comunitária

Baseado nas atividades anteriores (Atividade 1 a 3), este documento resume as entidades principais:
- USUARIO (id, cpf, nome, endereco, telefone, email, ativo)
- CATEGORIA (id, nome, descricao)
- AUTOR (id, nome, nacionalidade, data_nascimento)
- LIVRO (id, isbn, titulo, ano_publicacao, edicao, editora, categoria_id, paginas, disponivel)
- EXEMPLAR (id, codigo_exemplar, livro_id, estado_conservacao, localizacao, disponivel)
- EMPRESTIMO (id, exemplar_id, usuario_id, data_emprestimo, data_prevista_devolucao, data_devolucao_real, multa_aplicada)
- MULTA (id, emprestimo_id, valor, paga, data_emissao, data_pagamento)
- LIVRO_AUTOR (livro_id, autor_id) — tabela associativa N:N

Observações:
- As chaves estrangeiras garantem integridade referencial (FKs definidas nos scripts).
- Tabela livro_autor resolve relacionamento N:N entre LIVRO e AUTOR.
- Índices primários e alguns índices para consultas frequentes (ex: email, exemplar.livro_id).
