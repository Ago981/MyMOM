FROM python:3.11-slim-bullseye
WORKDIR /app
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/Ago981/MyMOM.git .
RUN pip install --no-cache-dir -r requirements.txt

# Non usare una porta fissa. Utilizza la variabile $PORT fornita da Render
CMD ["sh", "-c", "uvicorn run:main_app --host 0.0.0.0 --port $PORT --workers 4"]

