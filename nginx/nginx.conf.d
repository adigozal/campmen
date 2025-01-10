server {
    listen 80;
    server_name campmen.az www.campmen.az;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name campmen.az www.campmen.az;

    # SSL configuration
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem; # Adjust this if using a paid cert
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem; # Adjust this if using a paid cert

    # SSL security settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;

    # Static files
    location /static/ {
        alias /path/to/your/static/files/;
    }

    # Media files
    location /media/ {
        alias /path/to/your/media/files/;
    }

    # Proxy to Django Gunicorn or UWSGI server
    location / {
        proxy_pass http://127.0.0.1:8000;  # Your Gunicorn or uWSGI address
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }
}
