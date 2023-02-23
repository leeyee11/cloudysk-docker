FROM node:16 AS build
USER root
WORKDIR /app
RUN git clone https://github.com/leeyee11/cloudysk.git
WORKDIR /app/cloudysk
RUN npm ci --include=dev && npm run build && rm -rf node_modules
RUN git clone https://github.com/leeyee11/cloudysk-frontend.git frontend
WORKDIR /app/cloudysk/frontend
RUN npm ci --include=dev && npm run build && rm -rf node_modules
WORKDIR /app

FROM node:16-slim
USER root
WORKDIR /app/cloudysk
COPY --from=build /app /app
CMD ["node", "dist/index.js"]