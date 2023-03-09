# Stage 0, "builder", based on Node.js, to build and compile the frontend
FROM node:14 AS builder

# set the working directory
WORKDIR /app

# copy the package and package-lock files from local to container work directory /app
# this is done so that we only install dependencies whenever a package changes (added/removed)
# this saves us the build time by using docker caches if there is no change in these files
COPY package.json ./
COPY package-lock.json ./

# Run command npm install to install packages
RUN npm install

#copy all the folder contents from local to container
COPY . .

#create a react production build
RUN npm run build


# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.19-alpine AS server

# create a default.conf file in nginx conf.d directory
RUN echo $'server { \n\
    listen 80; \n\
    location / { \n\
    root   /usr/share/nginx/html; \n\
    index  index.html index.htm; \n\
    try_files $uri $uri/ /index.html; \n\
    } \n\
    error_page 500 502 503 504 /50x.html; \n\
    location = /50x.html { \n\
    root  /usr/share/nginx/html; \n\
    } \n\
    }' > /etc/nginx/conf.d/default.conf

# we copy the output from first stage that is our react build
# into nginx html directory where it will serve our index file
COPY --from=builder ./app/build /usr/share/nginx/html