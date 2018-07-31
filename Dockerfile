FROM mhart/alpine-node:6.11.0
ENV LAST_UPDATED 20170624T180000

# Installation curl
RUN apk add -U curl

# Copie des dependences du serveur
COPY package.json /tmp/package.json

# Installation des dependences
RUN cd /tmp && npm install

# Copie dependences des librairies
RUN mkdir /app && cp -a /tmp/node_modules /app/

# Copie des fichiers dans app
COPY . /app/

# Utilisation  /app comme repertoire de travail 
WORKDIR /app

# définir un bilan de santé 
HEALTHCHECK  --interval=30s --timeout=30s CMD curl -f http: // 127.0.0.1:8000 || exit 1

# Exposition du port http 
EXPOSE 8000

# Exécution de l'application
CMD ["npm", "start"]