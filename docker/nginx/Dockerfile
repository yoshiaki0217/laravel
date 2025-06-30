# 最新のNode.js LTS（v20）とNginxを組み合わせたDockerfile
# Node.js をビルドステージとして使用
FROM node:20-alpine as node

# 本番環境で使用する Nginx イメージ
FROM nginx:1.25-alpine

# シェルのオプションを明示的に指定（デバッグ性・安全性向上）
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

# タイムゾーンをUTCに設定（必要に応じてAsia/Tokyoなども可）
ENV TZ=UTC

# 必要なビルドツールなどをAlpine Linuxに追加
RUN apk update && \
  apk add --no-cache g++ make python3

# Node.js バイナリ・ライブラリ・yarnなどをコピー（multi-stage build）
# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

# Nginxの設定ファイルを反映（ホストの `docker/nginx/*.conf` からコピー）
COPY ./docker/nginx/*.conf /etc/nginx/conf.d/
