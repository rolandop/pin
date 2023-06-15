FROM python:3.9-slim
LABEL project=voting-app
WORKDIR /app
COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY . .
EXPOSE 80
CMD ["python", "./app.py"]