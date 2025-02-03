from node:18-alpine as build
workdir /app
copy package*.json ./
run npm install
copy . .
RUN chmod +x ./set-secrets.sh && ./set-secrets.sh
run npm run build
from nginx:alpine
copy --from=build /app/dist /usr/share/nginx/html
expose 80
cmd ["nginx","-g","daemon off;"]