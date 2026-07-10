FROM python:3.11-slim-bullseye

WORKDIR /app

# Render scarica già i file, copiamoli semplicemente dentro la cartella del container
COPY . .

# Installa le dipendenze del progetto
RUN pip install --no-cache-dir -r requirements.txt

# Usa la porta 7860 allineata con la variabile d'ambiente di Render
EXPOSE 7860
CMD ["uvicorn", "run:main_app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
