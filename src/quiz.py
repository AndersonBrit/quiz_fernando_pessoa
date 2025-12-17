# quiz.py
import pygame
import sys
from ui import *
from db import DB
from config import *


class QuizGame:
    def __init__(self, db: DB, max_questions=20):
        pygame.init()
        pygame.font.init()

        self.screen = pygame.display.set_mode((SCREEN_W, SCREEN_H))
        pygame.display.set_caption("Quiz Fernando Pessoa")
        self.clock = pygame.time.Clock()
        self.running = True

        # Fontes
        self.FONT_TITLE = pygame.font.SysFont(None, 40, bold=True)
        self.FONT_MED = pygame.font.SysFont(None, 26)
        self.FONT_SMALL = pygame.font.SysFont(None, 20)
        self.FONT_INPUT = pygame.font.SysFont(None, 28)

        # Estado do jogo
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

        # Evitar repetições
        self.used_question_ids = set()  # guarda IDs das perguntas já mostradas

        # Feedback/seleção
        self.show_feedback = False
        self.selected_index = None
        self.correct_index = None
        self.feedback_timer = 0
        self.FEEDBACK_DURATION = 1200

        # Botões do menu
        self.menu_buttons = {
            "play": Button((80, 260, SCREEN_W - 160, 70), "Jogar", self.FONT_MED, COL_BUTTON, COL_BUTTON_HOVER),
            "leader": Button((80, 360, SCREEN_W - 160, 70), "Leaderboard", self.FONT_MED, COL_BUTTON, COL_BUTTON_HOVER),
            "quit": Button((80, 460, SCREEN_W - 160, 70), "Sair", self.FONT_MED, (200, 60, 60), (230, 90, 90))
        }

        # Opções de turma
        self.turma_options = ['GPSI', 'IG', 'COM', 'ASC']
        start_y = 240
        self.turma_rects = [pygame.Rect(80, start_y + i*68, SCREEN_W - 160, 56) for i in range(len(self.turma_options))]

    # --------------------------
    # Desenho
    # --------------------------
    def draw(self):
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
        draw_text_center(self.screen, "Escolhe com rato ou teclas 1/2/3", self.FONT_SMALL, COL_SEC, SCREEN_W//2, SCREEN_H-40)

    def draw_input_name(self):
        draw_text_center(self.screen, "Insere o teu nome", self.FONT_TITLE, COL_TEXT, SCREEN_W//2, 60)
        box = pygame.Rect(60, 100, SCREEN_W - 120, 56)
        draw_card(self.screen, box)
        pygame.draw.rect(self.screen, COL_PRIMARY, box, 2, border_radius=10)
        name_disp = self.name_text if self.name_text else "Nome..."
        col = COL_TEXT if self.name_text else COL_SEC
        surf = self.FONT_INPUT.render(name_disp, True, col)
        self.screen.blit(surf, (box.x + 12, box.y + (box.height - surf.get_height())//2))

        draw_text_center(self.screen, "Escolhe a tua turma (rato ou 1..4)", self.FONT_SMALL, COL_SEC, SCREEN_W//2, box.bottom + 24)
        mouse = pygame.mouse.get_pos()
        for i, rect in enumerate(self.turma_rects):
            label = self.turma_options[i]
            hover = rect.collidepoint(mouse)
            color = COL_PRIMARY if self.turma == label else (COL_BUTTON_HOVER if hover else COL_CARD)
            pygame.draw.rect(self.screen, color, rect, border_radius=10)
            draw_text_center(self.screen, label, self.FONT_MED, COL_TEXT, rect.centerx, rect.centery)

        draw_text_center(self.screen, "ENTER para começar (nome + turma obrigatórios). ESC para voltar", self.FONT_SMALL, COL_SEC, SCREEN_W//2, self.turma_rects[-1].bottom + 28)

    def draw_question(self):
        # Se por algum motivo não tivermos pergunta actual, tenta obter uma
        if not self.current:
            self.next_question()
            if not self.current:
                # Sem perguntas -> fim de jogo
                self.state = "game_over"
                return

        header = f"Pontos: {self.score}   Pergunta: {self.question_count}/{self.max_questions}"
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
            draw_text_center(self.screen, "Sem opções para esta pergunta (corrige na BD).", self.FONT_MED, COL_CORRECT, SCREEN_W//2, r.centery)
            return

        # recalcula índice correcto
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

        # reset rects e desenha opções
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

        draw_text_center(self.screen, "Esc para voltar | 1..4 para escolher opção", self.FONT_SMALL, COL_SEC, SCREEN_W//2, SCREEN_H - 30)

    def draw_leaderboard(self):
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
            draw_text_center(self.screen, "Nenhuma pontuação ainda", self.FONT_MED, COL_SEC, SCREEN_W//2, list_rect.y + 80)
        else:
            for i, r in enumerate(rows):
                name = r.get("Nome") or "Anónimo"
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
        draw_text_center(self.screen, "Fim de Jogo", self.FONT_TITLE, COL_PRIMARY, SCREEN_W//2, 140)
        draw_text_center(self.screen, f"Pontos finais: {self.score}", self.FONT_MED, COL_TEXT, SCREEN_W//2, 200)
        draw_text_center(self.screen, "Pressiona ESC para voltar ao menu", self.FONT_SMALL, COL_SEC, SCREEN_W//2, 260)

    # --------------------------
    # Eventos
    # --------------------------
    def handle_events(self):
        dt = self.clock.get_time()

        if self.show_feedback:
            self.feedback_timer += dt
            if self.feedback_timer >= self.FEEDBACK_DURATION:
                self.show_feedback = False
                self.feedback_timer = 0
                self.selected_index = None
                # pede próxima pergunta após feedback
                self.next_question()
                return

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                self.running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    self.reset_to_menu()

                if self.state == "menu":
                    if event.unicode == "1":
                        self.state = "input_name"
                        self.name_text = ""
                        self.turma = None
                    elif event.unicode == "2":
                        self.state = "leaderboard"
                    elif event.unicode == "3":
                        self.running = False

                elif self.state == "input_name":
                    if event.unicode in ("1", "2", "3", "4"):
                        idx = int(event.unicode) - 1
                        if 0 <= idx < len(self.turma_options):
                            self.turma = self.turma_options[idx]
                    elif event.key == pygame.K_RETURN:
                        if self.name_text.strip() and self.turma:
                            self.user_id = self.db.create_or_get_user(self.name_text.strip(), self.turma)
                            self.state = "question"
                            self.score = 0
                            self.question_count = 0
                            self.used_question_ids.clear()  # limpa histórico ao iniciar
                            self.next_question()
                    elif event.key == pygame.K_BACKSPACE:
                        self.name_text = self.name_text[:-1]
                    else:
                        if len(self.name_text) < 30 and event.unicode.isprintable():
                            self.name_text += event.unicode

                elif self.state == "question":
                    if self.show_feedback:
                        return
                    if event.unicode.isdigit():
                        idx = int(event.unicode) - 1
                        if 0 <= idx < len(self.option_rects):
                            self.process_selection(idx)

            elif event.type == pygame.MOUSEBUTTONDOWN and event.button == 1:
                mx, my = event.pos
                if self.state == "menu":
                    if self.menu_buttons["play"].handle_event(event):
                        self.state = "input_name"
                        self.name_text = ""
                        self.turma = None
                    elif self.menu_buttons["leader"].handle_event(event):
                        self.state = "leaderboard"
                    elif self.menu_buttons["quit"].handle_event(event):
                        self.running = False
                elif self.state == "input_name":
                    for i, rect in enumerate(self.turma_rects):
                        if rect.collidepoint((mx, my)):
                            self.turma = self.turma_options[i]
                            break
                elif self.state == "leaderboard":
                    back_rect = pygame.Rect(SCREEN_W//2 - 90, SCREEN_H - 80, 180, 50)
                    if back_rect.collidepoint((mx, my)):
                        self.reset_to_menu()
                elif self.state == "question":
                    if self.show_feedback:
                        return
                    for i, rect in enumerate(self.option_rects):
                        if rect.collidepoint((mx, my)):
                            self.process_selection(i)
                            break

    # --------------------------
    # Processar seleção
    # --------------------------
    def process_selection(self, index):
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

        # encontra índice correcto
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

        self.selected_index = index
        self.show_feedback = True
        self.feedback_timer = 0

        if acertou:
            self.score += 1

        try:
            id_opcao = opt.get("ID_Opcao")
            if id_opcao is not None:
                self.db.save_answer(id_opcao, acertou, 1 if acertou else 0)
        except Exception:
            pass

    # --------------------------
    # Próxima pergunta (sem repetições)
    # --------------------------
    def next_question(self):
        # não avança se estivermos a mostrar feedback
        if self.show_feedback:
            return

        # fim se atingimos o limite definido pelo jogo
        if self.question_count >= self.max_questions:
            self.state = "game_over"
            try:
                self.db.save_total_score(self.score)
            except Exception:
                pass
            return

        # tenta obter pergunta nova evitando repetição
        q = None

        # tenta obter número total de perguntas na BD se o método existir
        total_questions = None
        try:
            if hasattr(self.db, "count_questions"):
                total_questions = int(self.db.count_questions())
        except Exception:
            total_questions = None

        # define número máximo de tentativas (mais seguro se poucas perguntas)
        if total_questions and total_questions > 0:
            max_attempts = max(20, total_questions * 2)
        else:
            max_attempts = 100  # fallback

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
            # se não conseguimos obter ID, aceitamos a pergunta (não há como verificar repetição)
            if pid is None:
                break

            # se a pergunta ainda não foi usada, aceitamos
            if pid not in self.used_question_ids:
                break

            # se já usámos todas as perguntas conhecidas, saímos
            if total_questions and len(self.used_question_ids) >= total_questions:
                q = None
                break

        # se não obtivemos pergunta nova -> fim de jogo
        if not q:
            self.state = "game_over"
            try:
                self.db.save_total_score(self.score)
            except Exception:
                pass
            return

        # grava ID como usada (se existir) e define pergunta actual
        pid = q.get("ID_Pergunta")
        if pid is not None:
            self.used_question_ids.add(pid)

        self.current = q
        self.question_count += 1
        self.option_rects = []

    # --------------------------
    # Reset para menu
    # --------------------------
    def reset_to_menu(self):
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
    # Loop principal
    # --------------------------
    def run(self):
        while self.running:
            self.handle_events()
            self.draw()
            self.clock.tick(FPS)

        try:
            self.db.close()
        except:
            pass
        pygame.quit()
        sys.exit()
