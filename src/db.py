# src/db.py

import mysql.connector  # Library for connecting to MySQL databases
import datetime         # Library for handling dates and times
from config import *    # Imports configuration, including DB_CONFIG


# =====================================================
# DB Class
# =====================================================
# Responsible for managing all database interactions:
# - Connection management
# - User creation and retrieval
# - Handling questions, answers, and scores
# =====================================================
class DB:
    def __init__(self, config=None):
        """
        Initializes the DB class.
        
        :param config: Dictionary with database connection data (host, user, password, database)
                       If None, uses DB_CONFIG from config.py
        """
        self.config = config or DB_CONFIG
        self.conn = None       # Database connection
        self.user_id = None    # Current user ID

    # -------------------------------------------------
    # Connects to the database
    # -------------------------------------------------
    def connect(self):
        if self.conn is None or not self.conn.is_connected():
            self.conn = mysql.connector.connect(**self.config)

    # -------------------------------------------------
    # Closes the database connection
    # -------------------------------------------------
    def close(self):
        if self.conn and self.conn.is_connected():
            self.conn.close()
            self.conn = None

    # -------------------------------------------------
    # Creates a new user or returns the ID if already exists
    # -------------------------------------------------
    def create_or_get_user(self, name, class_name=None):
        self.connect()
        cur = self.conn.cursor(dictionary=True)  # Cursor returns dictionaries

        # Check if the user already exists
        cur.execute("SELECT ID_Utilizador FROM Utilizador WHERE Nome = %s LIMIT 1", (name,))
        row = cur.fetchone()
        if row:
            self.user_id = row["ID_Utilizador"]
            # Update class if provided
            if class_name:
                try:
                    cur.execute("UPDATE Utilizador SET Turma = %s WHERE ID_Utilizador = %s", (class_name, self.user_id))
                    self.conn.commit()
                except:
                    pass
            cur.close()
            return self.user_id

        # Insert a new user
        cur.execute(
            "INSERT INTO Utilizador (Nome, Turma, Data_Registo) VALUES (%s, %s, %s)",
            (name, class_name, datetime.datetime.now())
        )
        self.conn.commit()
        self.user_id = cur.lastrowid  # Get the inserted user ID
        cur.close()
        return self.user_id

    # -------------------------------------------------
    # Retrieves a random question with its options
    # -------------------------------------------------
    def get_random_question(self):
        self.connect()
        cur = self.conn.cursor(dictionary=True)

        # Select a random question
        cur.execute("SELECT * FROM Pergunta ORDER BY RAND() LIMIT 1")
        question = cur.fetchone()
        if not question:
            cur.close()
            return None

        qid = question.get("ID_Pergunta")

        # Retrieve the options for the question
        cur.execute("SELECT ID_Opcao, Conteudo, Certa, ID_Pergunta FROM Opcao WHERE ID_Pergunta = %s", (qid,))
        options = cur.fetchall()
        question["opcoes"] = options or []

        cur.close()
        return question

    # -------------------------------------------------
    # Saves a user's answer to a question
    # -------------------------------------------------
    def save_answer(self, option_id, correct, score=0):
        if self.user_id is None:
            return  # Do not save if no user

        self.connect()
        cur = self.conn.cursor()
        cur.execute(
            "INSERT INTO Resposta (ID_Utilizador, ID_Opcao, Pontuacao, Acertou) VALUES (%s, %s, %s, %s)",
            (self.user_id, option_id, score, 1 if correct else 0)
        )
        self.conn.commit()
        cur.close()

    # -------------------------------------------------
    # Saves the total score of the user at the end of the quiz
    # -------------------------------------------------
    def save_total_score(self, total):
        if self.user_id is None:
            return

        self.connect()
        cur = self.conn.cursor()
        cur.execute(
            "INSERT INTO Pontuacao (ID_Utilizador, Pontuacao_Total) VALUES (%s, %s)",
            (self.user_id, total)
        )
        self.conn.commit()
        cur.close()

    # -------------------------------------------------
    # Returns the leaderboard (top scores)
    # -------------------------------------------------
    def get_leaderboard(self, limit=10):
        self.connect()
        cur = self.conn.cursor(dictionary=True)
        cur.execute("""
            SELECT P.ID_Pontuacao, U.Nome, P.Pontuacao_Total
            FROM Pontuacao P
            LEFT JOIN Utilizador U ON P.ID_Utilizador = U.ID_Utilizador
            ORDER BY P.Pontuacao_Total DESC, P.ID_Pontuacao ASC
            LIMIT %s
        """, (limit,))
        rows = cur.fetchall()
        cur.close()
        return rows
