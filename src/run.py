# run.py
from db import DB              # Importa a classe DB para gerir a base de dados
from quiz import QuizGame      # Importa a classe principal do jogo Quiz
from config import DB_CONFIG   # Importa a configuração da base de dados

# -----------------------------
# Função principal que inicia o jogo
# -----------------------------
def main():
    db = DB(config=DB_CONFIG)               # Cria uma instância da base de dados com as configurações
    game = QuizGame(db, max_questions=20)  # Cria uma instância do jogo, com 20 perguntas máximas
    
    try:
        game.run()  # Inicia o loop principal do jogo (controla eventos, desenho, lógica)
    except KeyboardInterrupt:  # Permite interromper o programa com Ctrl+C
        print("Programa terminado pelo utilizador.")
    finally:  # Garante que a base de dados é fechada no final, mesmo se ocorrer erro
        try:
            db.close()
        except:
            pass  # Ignora erros ao fechar a base de dados

# -----------------------------
# Ponto de entrada do programa
# -----------------------------
if __name__ == "__main__":
    main()  # Chama a função principal quando o script é executado diretamente
