# Cea mai recenta imagine oficiala a Node.js
FROM node:21-alpine3.18

# Copierea fisierului package.json in directorul curent
COPY package.json ./

# Rularea comenzii npm install
RUN npm install

# Copierea server.js in directorul de lucru /usr/src/app/
# Fiti atenti sa puneti la finalul numelui unui folder slash, altfel se va interpreta ca un fisier!
COPY server.js /usr/src/app/

# Expunerea portului 8080
EXPOSE 8080

# Comanda de rulare a aplicatiei
CMD ["node", "/usr/src/app/server.js"]