FROM python:3.9

WORKDIR /app

# Gereksinimleri yükleyin
COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Uygulama dosyalarını kopyalayın
COPY . .

# Portu expose edin
EXPOSE 8003

# Django sunucusunu başlatın
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8003" ]
