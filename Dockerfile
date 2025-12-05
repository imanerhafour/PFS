FROM python:3.11-slim

# Évite les questions interactives
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Créer utilisateur non-root (bonus sécurité)
RUN useradd --create-home --shell /bin/bash appuser
WORKDIR /home/appuser
USER appuser

# Copier et installer dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code
COPY . .

# Exposer le port Streamlit
EXPOSE 8501

# Commande par défaut
CMD ["streamlit", "run", "app/streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
