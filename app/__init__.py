import os
from flask import Flask, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
from .db import get_db, close_db

def create_app():
    load_dotenv()  # Charge les variables du fichier .env

    app = Flask(__name__)
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

    # Autorise le frontend (HTML/JS) à interroger l'API
    CORS(app)

    # Ferme la connexion BDD après chaque requête
    app.teardown_appcontext(close_db)

    # Route de test ("Healthcheck") pour vérifier que l'API et la BDD répondent
    @app.route('/api/health', methods=['GET'])
    def health_check():
        try:
            db = get_db()
            cursor = db.cursor(dictionary=True)
            cursor.execute("SELECT COUNT(*) AS nb_centres FROM centre")
            result = cursor.fetchone()
            return jsonify({
                "status": "OK",
                "message": "API CVVEN opérationnelle",
                "centres_en_base": result['nb_centres']
            }), 200
        except Exception as e:
            return jsonify({"status": "ERROR", "message": str(e)}), 500

    return app