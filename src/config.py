# src/config.py

# =====================================================
# Configuration file for the Fernando Pessoa Quiz project
# Stores database settings, screen/window settings, and color palette
# =====================================================

# -------------------------
# Database Configuration
# -------------------------
DB_CONFIG = {
    "host": "localhost",                  # Database server host
    "user": "root",                       # Database username
    "password": "",                       # Database password
    "database": "quiz_fernando_pessoa",  # Database name
    "port": 3306                          # Database port (default MySQL port)
}

# -------------------------
# Window / Screen Settings
# -------------------------
SCREEN_W = 600   # Width of the window in pixels
SCREEN_H = 800   # Height of the window in pixels
FPS = 60         # Frames per second for the game loop

# -------------------------
# Color Palette (RGB)
# -------------------------
COL_BG = (18, 24, 36)             # Background color
COL_CARD = (46, 58, 89)           # Card background color (questions)
COL_PRIMARY = (59, 130, 246)      # Primary color (buttons, highlights)
COL_TEXT = (235, 239, 244)        # Main text color
COL_SEC = (148, 163, 184)         # Secondary text color
COL_OPTION = (70, 90, 160)        # Answer option color
COL_OPTION_HOVER = (90, 120, 200) # Answer option hover color
COL_BUTTON = (40, 120, 200)       # General button color
COL_BUTTON_HOVER = (60, 150, 230) # Button hover color
COL_CORRECT = (22, 163, 74)       # Color for correct answers
COL_WRONG = (239, 68, 68)         # Color for wrong answers
