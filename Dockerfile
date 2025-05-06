# Usa a imagem oficial do Node.js com Alpine Linux (leve)
FROM node:23-slim

# Cria e define o diretório de trabalho
WORKDIR /app

# Copia os arquivos de dependência
COPY package*.json ./

# Instala as dependências do projeto
RUN npm install

# Copia o restante dos arquivos do projeto
COPY . .

# Expõe a porta que o Vite usa
EXPOSE 5173

# Comando padrão para rodar o projeto
CMD ["npm", "run", "dev"]
