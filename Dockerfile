FROM node:18.18 as builder
WORKDIR /app
COPY . /app
RUN npm install
RUN npm run build.ignore
FROM nginx
# 多阶段构建
COPY --from=builder /app/build /app
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]