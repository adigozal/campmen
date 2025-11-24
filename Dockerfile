FROM python:3.10.12

ENV PYTHONUNBUFFERED 1
ENV APP_ROOT /code

# Copy requirements
COPY requirements.txt /requirements.txt

# Create virtualenv
RUN python3 -m venv /venv
RUN /venv/bin/pip install --upgrade pip
RUN /venv/bin/pip install --no-cache-dir -r /requirements.txt

# Copy project
WORKDIR ${APP_ROOT}
COPY . ${APP_ROOT}

# Collect static files
RUN if [ -f manage.py ]; then /venv/bin/python manage.py collectstatic --noinput; fi

EXPOSE 8000 8001

# Start uWSGI
CMD ["/venv/bin/uwsgi", "--ini", "/code/uwsgi.ini"]
