# src/run.py

from db import DB              # Imports the DB class to manage the database
from quiz import QuizGame      # Imports the main Quiz game class
from config import DB_CONFIG   # Imports the database configuration


# -----------------------------
# Main function to start the game
# -----------------------------
def main():
    db = DB(config=DB_CONFIG)               # Creates a database instance using the configuration
    game = QuizGame(db, max_questions=20)  # Creates a QuizGame instance with a maximum of 20 questions
    
    try:
        game.run()  # Starts the main game loop (handles events, drawing, and game logic)
    except KeyboardInterrupt:  # Allows the program to be interrupted with Ctrl+C
        print("Program terminated by the user.")
    finally:  # Ensures the database is closed at the end, even if an error occurs
        try:
            db.close()
        except:
            pass  # Ignores errors when closing the database


# -----------------------------
# Program entry point
# -----------------------------
if __name__ == "__main__":
    main()  # Calls the main function when the script is executed directly
