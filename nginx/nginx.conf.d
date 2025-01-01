upstream hello_django {
    server web:8003;
}

server {

    listen 80;

    location / {
        proxy_pass http://hello_django;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
    }
        
    location /static/ {
        alias /code/static/;
    }
    location /media/ {
        alias /code/media/;
    }

}