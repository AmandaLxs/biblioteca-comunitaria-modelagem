# Resumo do Modelo Lógico - Biblioteca Comunitária

Entidades principais:
- USUARIO (id, cpf, nome, endereco, telefone, email, ativo, criado_em)
- CATEGORIA (id, nome, descricao)
- AUTOR (id, nome, nacionalidade, data_nascimento)
- LIVRO (id, isbn, titulo, subtitulo, ano_publicacao, edicao, editora, categoria_id, paginas, disponivel)
- EXEMPLAR (id, codigo_exemplar, livro_id, estado_conservacao, localizacao, disponivel, adquirido_em)
- EMPRESTIMO (id, exemplar_id, usuario_id, data_emprestimo, data_prevista_devolucao, data_devolucao_real, multa_aplicada, status)
- MULTA (id, emprestimo_id, valor, paga, data_emissao, data_pagamento, descricao)
- LIVRO_AUTOR (livro_id, autor_id, papel)

Observações:
- Integridade referencial garantida por chaves estrangeiras e ações ON DELETE/ON UPDATE.
- Tabela associativa livro_autor para resolver N:N entre livro e autor.
- Uso de tipos adequados: DECIMAL para valores monetários, DATE/YEAR/TIMESTAMP para temporais, CHAR para CPF/ISBN fixos.
