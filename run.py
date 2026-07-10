from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from mediaflow_proxy.main import app as mediaflow_app  # Import mediaflow app
import httpx
import re
import string
import os  # <-- Ti serve per leggere la porta di Render

# Initialize the main FastAPI application
main_app = FastAPI()

# Manually add only non-static routes from mediaflow_app
for route in mediaflow_app.routes:
    if route.path != "/":  # Continua a escludere la statica originale se necessario
        main_app.router.routes.append(route)

# AGGIUNGI QUESTO: Crea una rotta iniziale per evitare la pagina bianca
@main_app.get("/", response_class=HTMLResponse)
def home():
    return """
    <html>
        <head><title>Mediaflow Proxy</title></head>
        <body style="font-family: Arial, sans-serif; text-align: center; margin-top: 50px;">
            <h1>🚀 Il proxy Mediaflow è attivo su Render!</h1>
            <p>Le rotte API sono pronte per ricevere connessioni.</p>
        </body>
    </html>
    """

# Run the main app
if __name__ == "__main__":
    import uvicorn
    # Legge la porta di Render, se non esiste usa la 8080 come backup per il locale
    port = int(os.environ.get("PORT", 7860))
    uvicorn.run(main_app, host="0.0.0.0", port=port)

