FROM node:latest
WORKDIR /nod
RUN apt update && apt install git npm -y
RUN git clone https://github.com/Azure-Samples/js-e2e-express-server.git && cd js-e2e-express-server
WORKDIR /nod/js-e2e-express-server
RUN ls && npm update -g
RUN npm install && npm run
COPY . .
EXPOSE 3000
CMD ["npm", "start"]

