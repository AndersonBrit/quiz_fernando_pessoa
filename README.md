<h1 align="center">Fernando Pessoa Quiz (Pygame + MySQL)</h1>

<p align="center">
  <img src="docs\media\app\imagens\8_title.png" alt="Banner" width="600">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/python-3.10+-blue">
  <img src="https://img.shields.io/badge/mysql-5.7+-green">
  <img src="https://img.shields.io/badge/pygame-2.2+-orange">
  <img src="https://img.shields.io/badge/status-complete-brightgreen">
  <img src="https://img.shields.io/badge/project-academic-informational">
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg">
  </a>
</p>

## Description
Educational project of a quiz about Fernando Pessoa, developed in Python with a **Pygame** graphical interface and data persistence in **MySQL**. Users can register, answer questions, save responses, and view a leaderboard.

---

## Game Demo

<table>
  <tr>
    <td align="center" valign="middle">
      <b>1. Main Menu</b><br>
      Initial quiz interface where the user can start the game or access the leaderboard.<br><br>
      <img src="docs\media\app\imagens\1_menu.png" height="400" >
    </td>
    <td align="center" valign="middle">
      <b>2. Leaderboard</b><br><br>
      Displays the top scores recorded by users.<br><br>
      <img src="docs\media\app\imagens\2_leaderboard.png" height="400">
    </td>
  </tr>

  <tr>
    <td align="center" valign="middle">
      <br><b>3. User Creation</b><br>
      Allows creating a new user by entering name and class.<br><br>
      <img src="docs\media\app\imagens\3_create_user.png" height="400">
    </td>
    <td align="center" valign="middle">
      <br><b>4. User Creation Info</b><br>
      Confirms registration with the filled user details.<br><br>
      <img src="docs\media\app\imagens\4_create_user_info.png" height="400">
    </td>
  </tr>

  <tr>
    <td align="center" valign="middle">
      <br><b>5. Questions and Answers</b><br>
      Displays a question with multiple choice answers to the user.<br><br>
      <img src="docs\media\app\imagens\5_questions_answers.png" height="400">
    </td>
    <td align="center" valign="middle">
      <br><b>6. Answered Questions</b><br>
      Shows the answers already selected by the user during the quiz.<br><br>
      <img src="docs\media\app\imagens\6_answered_questions.png" height="400">
    </td>
  </tr>

  <tr>
    <td colspan="2" align="center">
      <br><b>7. End of Game</b><br>
      Displays the user's final score after completing the quiz.<br><br>
      <img src="docs\media\app\imagens\7_game_over.png" height="400">
    </td>
  </tr>
</table>

---

## Features
- Menu screen, user registration (name + class), and quiz game.  
- Questions and options loaded from the MySQL database.  
- Recording of answers and scores.  
- Leaderboard with top scores.  
- Modular structure: `src/` for code, `assets/` for resources, `sql/` for SQL scripts.

---

## Project Structure

```

quiz_fernando_pessoa/
│
├─ database/                      # Database
│  └─ sql/                        # SQL code
│     ├─ schema/                  # DB structure (CREATE DATABASE, CREATE TABLE)
│     │  └─ tables.sql
│     │
│     ├─ inserts/                 # Test data (INSERT INTO ...)
│     │  ├─ opcao.sql
│     │  └─ pergunta.sql
│     │
│     └─ views/                   # Example views and queries
│        ├─ view.sql              # View creation
│        └─ queries.sql           # Test/example queries
│
├─ docs/                          # Documentation
│  └─ media/                      # Images / videos
│     ├─ app/                     # Application media (UI)
│     │  └─ imagens/
│     │
│     └─ db/                      # Database media
│        └─ imagens/
│
├─ src/                           # Python code
│  ├─ config.py                   # General functions or system logic (e.g., user creation, validations)
│  ├─ db.py                       # Database connection and operations (CRUD)
│  ├─ quiz.py                     # Main quiz logic (questions, answers, scoring)
│  ├─ run.py                      # Entry point of the application; initializes and runs the quiz
│  └─ ui.py                       # User interface (console or GUI), user interaction
│
├─ .gitignore
├─ LICENSE
└─ README.md

````

---

## Prerequisites
- Python 3.10+ (recommended)  
- MySQL Server (or MariaDB) installed and running  
- Pip

---

## Installation and Execution

1. **Clone the repository:**
```bash
git clone https://github.com/AndersonBrit/quiz-fernando-pessoa.git
cd quiz-fernando-pessoa
````

2. **Install dependencies:**

```bash
pip install -r requirements.txt
```

3. **Configure the MySQL database:**

```sql
source sql/sql.sql;
source sql/insert.sql;
```

Make sure to update `src/config.py` with your MySQL credentials.

4. **Run the game:**

```bash
python src/run.py
```

---

## Notes

This project was developed for educational purposes in the context of the PSI subject along with Portuguese studies.

---

## Authorship

Project developed as part of the professional course
**Management and Computer Systems Programming (GPSI)**

**School:** Escola Profissional Bento Jesus Caraça (EPBJC)
**Subject:** PSI
**Author:** Andérson Brito

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
