server {
    listen 80;
    server_name www.campmen.az;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name www.campmen.az;

    ssl_certificate /etc/nginx/ssl/fullchain.pem;  # SSL sertifikası
    ssl_certificate_key /etc/nginx/ssl/privkey.pem;  # SSL özel anahtarı

    location / {
        proxy_pass http://web:8000;  # Django'nun konteynerine yönlendirme
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /static/ {
        alias /code/static/;
    }

    location /media/ {
        alias /code/media/;
    }
}
