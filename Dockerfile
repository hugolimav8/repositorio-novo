# Usa uma imagem leve do Nginx como base
FROM nginx:alpine

# Copia o conteúdo da sua pasta de dados para dentro do diretório padrão do Nginx
COPY ./site-dados /usr/share/nginx/html

# Expõe a porta interna do container
EXPOSE 80
