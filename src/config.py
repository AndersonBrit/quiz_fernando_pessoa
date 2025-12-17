# config.py
# -------------------------
# Configuração da Base de Dados
# -------------------------
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "quiz_fernando_pessoa",
    "port": 3306
}

# -------------------------
# Configurações da Janela
# -------------------------
SCREEN_W = 600
SCREEN_H = 800
FPS = 60

# -------------------------
# Paleta de Cores
# -------------------------
COL_BG = (18, 24, 36)             # Fundo da janela
COL_CARD = (46, 58, 89)           # Fundo dos cartões de pergunta
COL_PRIMARY = (59, 130, 246)      # Cor principal (botões, destaques)
COL_TEXT = (235, 239, 244)        # Cor do texto principal
COL_SEC = (148, 163, 184)         # Cor secundária (textos secundários)
COL_OPTION = (70, 90, 160)        # Opções de resposta
COL_OPTION_HOVER = (90, 120, 200) # Opção quando o rato passa por cima
COL_BUTTON = (40, 120, 200)       # Botões gerais
COL_BUTTON_HOVER = (60, 150, 230) # Botão quando o rato passa por cima
COL_CORRECT = (22, 163, 74)       # Cor para resposta correta
COL_WRONG = (239, 68, 68)         # Cor para resposta errada
