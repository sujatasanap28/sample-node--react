FROM node:alpine AS frontend-build
WORKDIR /usr/bin/app/
COPY /my-app ./my-app
RUN cd my-app && npm install && npm run build

FROM node:alpine AS backend-build
WORKDIR /root/
COPY --from=frontend-build /usr/bin/app/my-app/build/ ./my-app/build/
COPY /api/ ./api/
RUN cd api && npm install

EXPOSE 3080
CMD [ "node","./api/server.js" ]