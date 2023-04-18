# 基础镜像
FROM node:14-alpine as build-stage

# 维护者
LABEL maintainer=tianengu@outlook.com

# 工作目录
WORKDIR /app

# 复制所有文件到工作目录
COPY . .

# 安装依赖
RUN npm install --registry=https://registry.npm.taobao.org

# 构建项目
RUN npm run build

# nginx 配置文件
FROM nginx:stable-apline as production-stage

COPY --from=build-stage /app/dist /usr/share/ngnix/html

# 端口
EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]
