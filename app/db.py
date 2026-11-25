import os
import mysql.connector
from flask import g

def get_db():
    """Ouvre une connexion à la BDD si elle n'existe pas encore pour la requête en cours."""
    if 'db' not in g:
        g.db = mysql.connector.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            user=os.getenv('DB_USER', 'root'),
            password=os.getenv('DB_PASSWORD', ''),
            database=os.getenv('DB_NAME', 'cvven_materiel')
        )
    return g.db

def close_db(e=None):
    """Ferme proprement la connexion à la fin de la requête HTTP."""
    db = g.pop('db', None)
    if db is not None:
        db.close()