# db.py
import mysql.connector  # biblioteca para conectar a bases de dados MySQL
import datetime         # biblioteca para lidar com datas e horas
from config import *    # importa configurações, como DB_CONFIG

# -----------------------------
# Classe para lidar com a base de dados
# -----------------------------
class DB:
    def __init__(self, config=None):
        # config: dicionário com dados da DB (host, user, password, database)
        # se não for passado, usa DB_CONFIG do ficheiro config
        self.config = config or DB_CONFIG
        self.conn = None       # ligação à base de dados
        self.user_id = None    # ID do utilizador atual

    # cria ligação à DB se ainda não existir ou se estiver fechada
    def connect(self):
        if self.conn is None or not self.conn.is_connected():
            self.conn = mysql.connector.connect(**self.config)

    # fecha ligação à DB
    def close(self):
        if self.conn and self.conn.is_connected():
            self.conn.close()
            self.conn = None

    # cria ou obtém ID de um utilizador pelo nome
    def create_or_get_user(self, nome, turma=None):
        self.connect()
        cur = self.conn.cursor(dictionary=True)  # cursor que devolve dicionários
        # procura utilizador pelo nome
        cur.execute("SELECT ID_Utilizador FROM Utilizador WHERE Nome = %s LIMIT 1", (nome,))
        row = cur.fetchone()
        if row:
            # se já existir, guarda o ID
            self.user_id = row["ID_Utilizador"]
            # atualiza turma se for fornecida
            if turma:
                try:
                    cur.execute("UPDATE Utilizador SET Turma = %s WHERE ID_Utilizador = %s", (turma, self.user_id))
                    self.conn.commit()
                except:
                    pass
            cur.close()
            return self.user_id

        # se não existir, insere novo utilizador
        cur.execute("INSERT INTO Utilizador (Nome, Turma, Data_Registo) VALUES (%s, %s, %s)",
                    (nome, turma, datetime.datetime.now()))
        self.conn.commit()
        self.user_id = cur.lastrowid  # obtém o ID do utilizador inserido
        cur.close()
        return self.user_id

    # obtém uma pergunta aleatória com as suas opções
    def get_random_question(self):
        self.connect()
        cur = self.conn.cursor(dictionary=True)
        # escolhe uma pergunta aleatória
        cur.execute("SELECT * FROM Pergunta ORDER BY RAND() LIMIT 1")
        pergunta = cur.fetchone()
        if not pergunta:
            cur.close()
            return None
        pid = pergunta.get("ID_Pergunta")
        # obtém as opções da pergunta
        cur.execute("SELECT ID_Opcao, Conteudo, Certa, ID_Pergunta FROM Opcao WHERE ID_Pergunta = %s", (pid,))
        opcoes = cur.fetchall()
        pergunta["opcoes"] = opcoes or []
        cur.close()
        return pergunta

    # guarda a resposta de uma pergunta feita pelo utilizador
    def save_answer(self, id_opcao, acertou, pontuacao=0):
        if self.user_id is None:
            return  # não guarda se não houver utilizador
        self.connect()
        cur = self.conn.cursor()
        cur.execute("INSERT INTO Resposta (ID_Utilizador, ID_Opcao, Pontuacao, Acertou) VALUES (%s, %s, %s, %s)",
                    (self.user_id, id_opcao, pontuacao, 1 if acertou else 0))
        self.conn.commit()
        cur.close()

    # guarda pontuação total do utilizador ao fim do quiz
    def save_total_score(self, total):
        if self.user_id is None:
            return
        self.connect()
        cur = self.conn.cursor()
        cur.execute("INSERT INTO Pontuacao (ID_Utilizador, Pontuacao_Total) VALUES (%s, %s)",
                    (self.user_id, total))
        self.conn.commit()
        cur.close()

    # obtém leaderboard (top pontuações)
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
