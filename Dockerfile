# Build stage
FROM node:14 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx:stable-alpine as production-stage
## don't want NGINX vanilla.  Want non-port 80, and from RH ubi, or similar

COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
#EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]

# To deploy on ezhost.dev you need to deploy from a git repo, 
# paste the url of the repo and choose the name you want, 
# when the app is running, go on the expose part, 
# the port is 8080 and choose the subdomain you want 
# after go on https://the_subdomain_you_choose.ezhost-app.com and you will see your kanban board  in 2 min you have your kanban board online :)
