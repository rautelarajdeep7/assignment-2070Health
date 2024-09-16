FROM python:3.9-slim
WORKDIR /app
COPY ./app/requirements.txt .
RUN pip3 install -r requirements.txt
COPY ./app/* .
EXPOSE 5000
CMD ["python3", "-m", "flask", "--app", "app.py", "run"]

