# 정적 웹페이지(iLoom 매장 지도)를 가벼운 nginx 웹서버로 서빙한다.
# crawlers/ · scripts/ 등 데이터 수집용 Node.js 코드는 .dockerignore 로 제외된다.
FROM nginx:alpine

# 정적 파일(index.html, *.js 데이터 파일 등)을 nginx 기본 서빙 경로로 복사
COPY . /usr/share/nginx/html/

# nginx 는 80 포트로 서빙한다
EXPOSE 80

# 배포 후 정상 동작 여부를 확인하는 상태 점검
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ >/dev/null 2>&1 || exit 1

# nginx:alpine 기본 시작 명령(nginx -g 'daemon off;')을 그대로 사용
