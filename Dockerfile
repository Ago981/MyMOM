FROM python:3.11-slim-bullseye

WORKDIR /app

# Copia i file del repository
COPY . .

# Installa le dipendenze
RUN pip install --no-cache-dir -r requirements.txt

# Espone la porta 7860
EXPOSE 7860

# AVVIA L'APP ORIGINALE (Bypassando run.py che bloccava la UI)
CMD ["uvicorn", "mediaflow_proxy.main:app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
