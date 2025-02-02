from node:18
workdir /app
copy package*.json ./
run npm install
copy . .
expose 8080
cmd ["npm", "run", "serve" ]