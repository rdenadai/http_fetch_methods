# WebSockets vs Server Side Events (SSE)

### WebSockets

1. Comunicação Bidirecional
2. Protocolo Próprio
3. Não Reconecta Automaticamente
4. Flexibilidade de Formato

### Server-Side Events (SSE)

1. Comunicação Unidirecional
2. Baseado em HTTP
3. Reconexão Automática
4. Formato de Mensagem (text)

## Executar o projeto

```bash
$> docker-compose up --build
```

Dentro do vscode vc pode usar o modo de debug para rodar o projeto.
Caso queira, vc pode mudar o docker-compose e passar o param `MODE` como `production`, dessa forma o projeto vai subir e deixar disponível cada um dos serviços nas portas especificadas no arquivo `docker-compose.yml`.
