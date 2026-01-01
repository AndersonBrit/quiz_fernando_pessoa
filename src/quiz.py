# src/quiz.py

import pygame
import sys
from ui import *
from db import DB
from config import *


# =====================================================
# QuizGame Class
# =====================================================
# Handles the quiz game:
# - Menu, input, questions, leaderboard, and game over screens
# - Player input (keyboard & mouse)
# - Question flow and scoring
# =====================================================
class QuizGame:
    def __init__(self, db: DB, max_questions=20):
        # Initialize Pygame
        pygame.init()
        pygame.font.init()

        # Window setup
        self.screen = pygame.display.set_mode((SCREEN_W, SCREEN_H))
        pygame.display.set_caption("Quiz Fernando Pessoa")
        self.clock = pygame.time.Clock()
        self.running = True

        # Fonts
        self.FONT_TITLE = pygame.font.SysFont(None, 40, bold=True)
        self.FONT_MED = pygame.font.SysFont(None, 26)
        self.FONT_SMALL = pygame.font.SysFont(None, 20)
        self.FONT_INPUT = pygame.font.SysFont(None, 28)

        # Game state
        self.db = db
        self.state = "menu"
        self.name_text = ""
        self.turma = None
        self.user_id = None
        self.current = None
        self.option_rects = []
        self.score = 0
        self.question_count = 0
        self.max_questions = max_questions

        # Avoid repeating questions
        self.used_question_ids = set()

        # Feedback / selection
        self.show_feedback = False
        self.selected_index = None
        self.correct_index = None
        self.feedback_timer = 0
        self.FEEDBACK_DURATION = 1200  # milliseconds

        # Menu buttons
        self.menu_buttons = {
            "play": Button((80, 260, SCREEN_W - 160, 70), "Jogar", self.FONT_MED, COL_BUTTON, COL_BUTTON_HOVER),
            "leader": Button((80, 360, SCREEN_W - 160, 70), "Leadboard", self.FONT_MED, COL_BUTTON, COL_BUTTON_HOVER),
            "quit": Button((80, 460, SCREEN_W - 160, 70), "Sair", self.FONT_MED, (200, 60, 60), (230, 90, 90))
        }

        # Class options
        self.turma_options = ['GPSI', 'IG', 'COM', 'ASC']
        start_y = 240
        self.turma_rects = [pygame.Rect(80, start_y + i*68, SCREEN_W - 160, 56) for i in range(len(self.turma_options))]

    # --------------------------
    # Drawing Methods
    # --------------------------
    def draw(self):
        """Draw the current screen based on the game state."""
        self.screen.fill(COL_BG)
        if self.state == "menu":
            self.draw_menu()
        elif self.state == "input_name":
            self.draw_input_name()
        elif self.state == "question":
            self.draw_question()
        elif self.state == "leaderboard":
            self.draw_leaderboard()
        elif self.state == "game_over":
            self.draw_game_over()
        pygame.display.flip()

    def draw_menu(self):
        draw_text_center(self.screen, "Quiz Fernando Pessoa", self.FONT_TITLE, COL_PRIMARY, SCREEN_W//2, 100)
        for btn in self.menu_buttons.values():
            btn.update()
            btn.draw(self.screen)
        draw_text_center(self.screen, "Selecione com o rato ou teclas 1/2/3", self.FONT_SMALL, COL_SEC, SCREEN_W//2, SCREEN_H-40)   

    def draw_input_name(self):
        """Draw name input and class selection screen."""
        draw_text_center(self.screen, "Insira o seu nome", self.FONT_TITLE, COL_TEXT, SCREEN_W//2, 60)
        box = pygame.Rect(60, 100, SCREEN_W - 120, 56)
        draw_card(self.screen, box)
        pygame.draw.rect(self.screen, COL_PRIMARY, box, 2, border_radius=10)
        name_disp = self.name_text if self.name_text else "Name..."
        col = COL_TEXT if self.name_text else COL_SEC
        surf = self.FONT_INPUT.render(name_disp, True, col)
        self.screen.blit(surf, (box.x + 12, box.y + (box.height - surf.get_height())//2))

        draw_text_center(self.screen, "Selecione a sua turma (rato ou 1..4)", self.FONT_SMALL, COL_SEC, SCREEN_W//2, box.bottom + 24)
        mouse = pygame.mouse.get_pos()
        for i, rect in enumerate(self.turma_rects):
            label = self.turma_options[i]
            hover = rect.collidepoint(mouse)
            color = COL_PRIMARY if self.turma == label else (COL_BUTTON_HOVER if hover else COL_CARD)
            pygame.draw.rect(self.screen, color, rect, border_radius=10)
            draw_text_center(self.screen, label, self.FONT_MED, COL_TEXT, rect.centerx, rect.centery)

        draw_text_center(self.screen, "ENTER para começar (nome + turma obrigatórios). ESC para voltar", self.FONT_SMALL, COL_SEC, SCREEN_W//2, self.turma_rects[-1].bottom + 28)

    def draw_question(self):
        """Draw the current question and its options."""
        if not self.current:
            self.next_question()
            if not self.current:
                self.state = "game_over"
                return

        header = f"Score: {self.score}   Question: {self.question_count}/{self.max_questions}"
        draw_text_center(self.screen, header, self.FONT_SMALL, COL_SEC, SCREEN_W//2, 28)

        q_text = self.current.get("Conteudo", "—")
        lines = wrap_text(q_text, self.FONT_MED, SCREEN_W - 160)
        y = 100
        for l in lines:
            draw_text_center(self.screen, l, self.FONT_MED, COL_TEXT, SCREEN_W//2, y)
            y += 30

        opts = self.current.get("opcoes", [])
        mouse = pygame.mouse.get_pos()

        if not opts:
            r = pygame.Rect(40, 320, SCREEN_W - 80, 64)
            draw_card(self.screen, r)
            draw_text_center(self.screen, "Nenhuma opção disponível para esta pergunta (corrigir na BD).", self.FONT_MED, COL_CORRECT, SCREEN_W//2, r.centery)
            return

        # Determine the correct option index
        self.correct_index = None
        for i, o in enumerate(opts):
            v = o.get("Certa")
            is_corr = False
            if isinstance(v, (int, float)):
                is_corr = int(v) == 1
            elif isinstance(v, str):
                is_corr = v.strip().lower() in ("1", "true", "t", "yes", "y")
            elif isinstance(v, bool):
                is_corr = bool(v)
            if is_corr:
                self.correct_index = i
                break

        # Draw options
        self.option_rects = []
        top = 320
        h = 64
        margin = 16
        for i, opt in enumerate(opts):
            rect = pygame.Rect(40, top + i*(h + margin), SCREEN_W - 80, h)
            color = COL_OPTION
            if self.show_feedback:
                if self.selected_index is not None and i == self.selected_index:
                    color = COL_CORRECT if i == self.correct_index else COL_WRONG
                elif self.selected_index is not None and i == self.correct_index and self.selected_index != self.correct_index:
                    color = COL_CORRECT
                else:
                    color = (50, 60, 90)
            else:
                if rect.collidepoint(mouse):
                    color = COL_OPTION_HOVER
                else:
                    color = COL_OPTION

            pygame.draw.rect(self.screen, color, rect, border_radius=12)
            txt = opt.get("Conteudo", "—")
            surf = self.FONT_MED.render(txt, True, COL_TEXT)
            self.screen.blit(surf, (rect.x + 18, rect.y + (rect.height - surf.get_height())//2))
            self.option_rects.append(rect)

        draw_text_center(self.screen, "ESC para voltar | 1..4 para selecionar a opção", self.FONT_SMALL, COL_SEC, SCREEN_W//2, SCREEN_H - 30)

    def draw_leaderboard(self):
        """Draw the leaderboard screen."""
        draw_text_center(self.screen, "Leaderboard", self.FONT_TITLE, COL_PRIMARY, SCREEN_W//2, 60)
        rows = []
        try:
            rows = self.db.get_leaderboard(10)
        except Exception:
            rows = []

        list_rect = pygame.Rect(40, 110, SCREEN_W - 80, SCREEN_H - 220)
        draw_card(self.screen, list_rect)
        y = list_rect.y + 18

        if not rows:
            draw_text_center(self.screen, "Sem pontuações ainda", self.FONT_MED, COL_SEC, SCREEN_W//2, list_rect.y + 80)
        else:
            for i, r in enumerate(rows):
                name = r.get("Nome") or "Anonymous"
                score = r.get("Pontuacao_Total") or 0
                rank = f"{i+1}."
                surf = self.FONT_MED.render(rank, True, COL_PRIMARY)
                self.screen.blit(surf, (list_rect.x + 16, y))
                surf2 = self.FONT_MED.render(name, True, COL_TEXT)
                self.screen.blit(surf2, (list_rect.x + 64, y))
                surf3 = self.FONT_MED.render(str(score), True, COL_TEXT)
                self.screen.blit(surf3, (list_rect.right - 16 - surf3.get_width(), y))
                y += 36

        back_rect = pygame.Rect(SCREEN_W//2 - 90, SCREEN_H - 80, 180, 50)
        pygame.draw.rect(self.screen, COL_BUTTON_HOVER, back_rect, border_radius=12)
        draw_text_center(self.screen, "Voltar", self.FONT_MED, COL_TEXT, back_rect.centerx, back_rect.centery)

    def draw_game_over(self):
        """Draw the game over screen."""
        draw_text_center(self.screen, "Fim do Jogo", self.FONT_TITLE, COL_PRIMARY, SCREEN_W//2, 140)
        draw_text_center(self.screen, f"Pontuação Final: {self.score}", self.FONT_MED, COL_TEXT, SCREEN_W//2, 200)
        draw_text_center(self.screen, "Pressione ESC para voltar ao menu", self.FONT_SMALL, COL_SEC, SCREEN_W//2, 260)

    # --------------------------
    # Event Handling
    # --------------------------
    def handle_events(self):
        """Handle all user input (keyboard and mouse) and timing events."""
        dt = self.clock.get_time()

        # Handle feedback timer
        if self.show_feedback:
            self.feedback_timer += dt
            if self.feedback_timer >= self.FEEDBACK_DURATION:
                self.show_feedback = False
                self.feedback_timer = 0
                self.selected_index = None
                # Move to next question after feedback
                self.next_question()
                return

        # Process events
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                self.running = False

            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    self.reset_to_menu()

                # Menu navigation via keyboard
                if self.state == "menu":
                    if event.unicode == "1":
                        self.state = "input_name"
                        self.name_text = ""
                        self.turma = None
                    elif event.unicode == "2":
                        self.state = "leaderboard"
                    elif event.unicode == "3":
                        self.running = False

                # Name input and class selection
                elif self.state == "input_name":
                    if event.unicode in ("1", "2", "3", "4"):
                        idx = int(event.unicode) - 1
                        if 0 <= idx < len(self.turma_options):
                            self.turma = self.turma_options[idx]
                    elif event.key == pygame.K_RETURN:
                        # Start quiz if name and class are provided
                        if self.name_text.strip() and self.turma:
                            self.user_id = self.db.create_or_get_user(self.name_text.strip(), self.turma)
                            self.state = "question"
                            self.score = 0
                            self.question_count = 0
                            self.used_question_ids.clear()  # clear history at start
                            self.next_question()
                    elif event.key == pygame.K_BACKSPACE:
                        self.name_text = self.name_text[:-1]
                    else:
                        if len(self.name_text) < 30 and event.unicode.isprintable():
                            self.name_text += event.unicode

                # Question input via number keys
                elif self.state == "question":
                    if self.show_feedback:
                        return
                    if event.unicode.isdigit():
                        idx = int(event.unicode) - 1
                        if 0 <= idx < len(self.option_rects):
                            self.process_selection(idx)

            elif event.type == pygame.MOUSEBUTTONDOWN and event.button == 1:
                mx, my = event.pos
                # Menu buttons
                if self.state == "menu":
                    if self.menu_buttons["play"].handle_event(event):
                        self.state = "input_name"
                        self.name_text = ""
                        self.turma = None
                    elif self.menu_buttons["leader"].handle_event(event):
                        self.state = "leaderboard"
                    elif self.menu_buttons["quit"].handle_event(event):
                        self.running = False
                # Class selection click
                elif self.state == "input_name":
                    for i, rect in enumerate(self.turma_rects):
                        if rect.collidepoint((mx, my)):
                            self.turma = self.turma_options[i]
                            break
                # Leaderboard back button
                elif self.state == "leaderboard":
                    back_rect = pygame.Rect(SCREEN_W//2 - 90, SCREEN_H - 80, 180, 50)
                    if back_rect.collidepoint((mx, my)):
                        self.reset_to_menu()
                # Question option click
                elif self.state == "question":
                    if self.show_feedback:
                        return
                    for i, rect in enumerate(self.option_rects):
                        if rect.collidepoint((mx, my)):
                            self.process_selection(i)
                            break

    # --------------------------
    # Process Selection
    # --------------------------
    def process_selection(self, index):
        """Handle selection of a quiz option, update score and feedback."""
        opts = self.current.get("opcoes", [])
        if index >= len(opts):
            return

        opt = opts[index]
        v = opt.get("Certa")
        acertou = False
        if isinstance(v, (int, float)):
            acertou = int(v) == 1
        elif isinstance(v, str):
            acertou = v.strip().lower() in ("1", "true", "t", "yes", "y")
        elif isinstance(v, bool):
            acertou = bool(v)

        # Find correct option index
        self.correct_index = None
        for i, o in enumerate(opts):
            vv = o.get("Certa")
            is_corr = False
            if isinstance(vv, (int, float)):
                is_corr = int(vv) == 1
            elif isinstance(vv, str):
                is_corr = vv.strip().lower() in ("1", "true", "t", "yes", "y")
            elif isinstance(vv, bool):
                is_corr = bool(vv)
            if is_corr:
                self.correct_index = i
                break

        # Show feedback
        self.selected_index = index
        self.show_feedback = True
        self.feedback_timer = 0

        # Update score if correct
        if acertou:
            self.score += 1

        # Save answer in database
        try:
            id_opcao = opt.get("ID_Opcao")
            if id_opcao is not None:
                self.db.save_answer(id_opcao, acertou, 1 if acertou else 0)
        except Exception:
            pass

    # --------------------------
    # Next Question
    # --------------------------
    def next_question(self):
        """Load the next random question, avoiding repetition."""
        if self.show_feedback:
            return

        # End game if maximum questions reached
        if self.question_count >= self.max_questions:
            self.state = "game_over"
            try:
                self.db.save_total_score(self.score)
            except Exception:
                pass
            return

        # Attempt to fetch a new question avoiding duplicates
        q = None
        total_questions = None
        try:
            if hasattr(self.db, "count_questions"):
                total_questions = int(self.db.count_questions())
        except Exception:
            total_questions = None

        max_attempts = max(20, total_questions * 2) if total_questions else 100
        attempts = 0
        while attempts < max_attempts:
            attempts += 1
            try:
                q = self.db.get_random_question()
            except Exception:
                q = None

            if not q:
                break

            pid = q.get("ID_Pergunta") if isinstance(q, dict) else None
            if pid is None or pid not in self.used_question_ids:
                break

            if total_questions and len(self.used_question_ids) >= total_questions:
                q = None
                break

        # If no question found, end game
        if not q:
            self.state = "game_over"
            try:
                self.db.save_total_score(self.score)
            except Exception:
                pass
            return

        # Save question ID to avoid repetition
        pid = q.get("ID_Pergunta")
        if pid is not None:
            self.used_question_ids.add(pid)

        self.current = q
        self.question_count += 1
        self.option_rects = []

    # --------------------------
    # Reset to Menu
    # --------------------------
    def reset_to_menu(self):
        """Reset all game states and return to the main menu."""
        self.state = "menu"
        self.current = None
        self.option_rects = []
        self.name_text = ""
        self.turma = None
        self.score = 0
        self.question_count = 0
        self.show_feedback = False
        self.selected_index = None
        self.correct_index = None
        self.feedback_timer = 0
        self.used_question_ids.clear()

    # --------------------------
    # Main Loop
    # --------------------------
    def run(self):
        """Main game loop."""
        while self.running:
            self.handle_events()
            self.draw()
            self.clock.tick(FPS)

        # Close DB and exit
        try:
            self.db.close()
        except:
            pass
        pygame.quit()
        sys.exit()
