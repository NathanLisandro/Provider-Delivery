# App Prestadores de Serviço

Este é um aplicativo desenvolvido como atividade final da disciplina **ESOFT 6**, com o objetivo de gerenciar prestadores de serviço e avaliações realizadas pelos usuários. O aplicativo permite cadastrar, listar, editar e excluir prestadores, além de adicionar avaliações para cada prestador.

## Funcionalidades

- **Cadastro de Prestadores**:
  - Permite adicionar prestadores com informações como nome, telefone, preço por hora, descrição e serviços oferecidos.
  
- **Listagem de Prestadores**:
  - Exibe uma lista dos prestadores cadastrados com nome, preço por hora, média de avaliações e quantidade de avaliações.

- **Avaliações**:
  - Adicione avaliações para cada prestador, incluindo uma nota (1 a 5 estrelas) e um comentário.
  - Atualize a média e a quantidade de avaliações em tempo real.

- **CRUD Completo**:
  - Adicionar, listar, editar e remover prestadores e avaliações.

- **Tela de Dashboard**:
  - Tela inicial com navegação para todas as funcionalidades do aplicativo.

- **Menu de Navegação**:
  - Acesse as diferentes páginas do app através de um menu lateral.

## Tecnologias Utilizadas

- **Frontend**: Desenvolvido em Flutter.
- **Backend Fake**: `json-server` para simular a API e persistir os dados.
- **Componentes Customizados**:
  - `PrestadorCard`: Exibe os detalhes de um prestador.
  - `StarRating`: Exibe e permite selecionar a avaliação com estrelas.

## Requisitos

- **Flutter SDK**: Certifique-se de ter o Flutter instalado.
- **Json-server**: Para executar o backend fake.

## Como Executar

### 1. Clone o repositório

git clone https://github.com/seu_usuario/app-prestadores-servico.git

cd app-prestadores-servico

flutter run

cd ..

cd ./backend

json-server --watch db.json
