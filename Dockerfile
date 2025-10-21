FROM nginx:stable-alpine

# 建立非 root 用戶
RUN addgroup -S nginx \
    && adduser -S -G nginx nginx \
    && chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /var/log/nginx \
    && chown -R nginx:nginx /etc/nginx/conf.d

# 複製自定義 nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# 設定適當的檔案權限
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# 切換到非 root 用戶
USER nginx

# 設定工作目錄
WORKDIR /etc/nginx

# 使用安全的命令執行方式
CMD ["nginx", "-g", "daemon off;"]