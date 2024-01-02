echo "<h1>Hi from netcat</h1>" > index.html
while true; \
do echo -e "HTTP/1.1 200 OK\n\n $(cat index.html)" | \
nc -l -w0 -q0 8000; done