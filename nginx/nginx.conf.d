upstream hello_django {
    server 127.0.0.1:8000;  # Django uygulamasının çalıştığı yerel IP ve port
}

server {
    listen 80;
    server_name www.campmen.az campmen.az;  # Domain adınızı belirtin

    location / {
        proxy_pass http://hello_django;  # Django uygulamanız
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_redirect off;
    }
    
    location /static/ {
        alias /code/static/;  # Statik dosyalarınızın yolu
    }

    location /media/ {
        alias /code/media/;  # Medya dosyalarınızın yolu
    }
}
