# Projeto de Modelagem de Dados - Trocatine

Este repositório contém um conjunto de scripts SQL para criar, gerenciar e manter um banco de dados relacional para o sistema "Trocatine". Os scripts incluem a criação de tabelas, funções, procedimentos armazenados, triggers e logs para auditoria. 

## Estrutura do Repositório

- **`códigos/Functions.sql`**: Contém as funções usadas para cálculo e consulta no banco de dados.
    - `total_value_order(shopping_cart_finish)`: Calcula o valor total de um pedido finalizado.
    - `value_product(product_new, quantity)`: Calcula o valor de um produto multiplicado pela quantidade.
    - `podium_trocadinhas(expiration_datep)`: Retorna as três trocadinhas com as maiores quantidades, não expiradas até uma data específica.

- **`códigos/Insercoes2.sql`**: Script para inserção de dados iniciais no banco. Inclui registros em várias tabelas, como `users`, `adresses`, `phones`, `products`, `tags`, `categories`, `shopping_carts` e `trocadinhas`.

- **`códigos/Procedure.sql`**: Contém os procedimentos armazenados que gerenciam ações no banco de dados.
    - `create_user`: Cria um novo usuário e seus dados associados (endereço e telefone).
    - `create_product`: Cria um novo produto e adiciona categorias e tags associadas.
    - `create_order`: Gera um pedido com base em um carrinho de compras ou um produto específico.
    - `create_tag` e `create_category`: Geram novas tags e categorias, evitando duplicatas.

- **`códigos/Script_Trocatine_vs2.sql`**: Script de criação e configuração inicial do banco de dados. Inclui definições de tabelas, relacionamentos e constraints, e algumas tabelas de logs para auditoria.
  
- **`códigos/Triggers.sql`**: Script que contém as funções de trigger para manter o histórico e auditoria das tabelas.
    - `func_users_log`, `func_trocadinhas_log`, `func_highlights_log`: Funções para registrar operações de inserção, atualização e exclusão nas tabelas de usuários, trocadinhas e destaques, respectivamente.
    - `trg_users_log`, `trg_trocadinhas_log`: Triggers que chamam as funções de log, adicionando automaticamente uma entrada em cada operação nas tabelas associadas.

## Pré-requisitos

Para usar esses scripts, você precisará de:
- **PostgreSQL** instalado e configurado.
- Um ambiente para executar scripts SQL (como o terminal do PostgreSQL ou um gerenciador de banco de dados visual, como DBeaver ou pgAdmin).

## Instruções de Uso

1. **Inicialize o Banco de Dados**:
   - Execute `Script_Trocatine_vs2.sql` para criar as tabelas necessárias e configurar as constraints.

2. **Insira Dados**:
   - Utilize `Insercoes2.sql` para preencher o banco com dados iniciais para testes.

3. **Defina as Funções**:
   - Execute `Functions.sql` para adicionar funções que auxiliam nos cálculos e consultas no banco.

4. **Configure os Procedimentos**:
   - Execute `Procedure.sql` para definir procedimentos armazenados para a criação de usuários, produtos e pedidos.

5. **Aplique os Triggers**:
   - Execute `Triggers.sql` para criar os triggers que automatizam o registro de logs de auditoria nas tabelas.

## Observações

- **Procedimentos e Funções**: Certifique-se de que cada função e procedimento tenha sido executado com sucesso. Erros comuns incluem permissões insuficientes e falta de tabelas referenciadas.
- **Segurança**: As senhas e informações confidenciais, como o número de cartão, estão incluídas no script apenas para fins de teste. Recomendamos criptografar informações sensíveis ao implementar em um ambiente de produção.

---
