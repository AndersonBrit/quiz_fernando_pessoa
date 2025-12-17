import pygame
from config import COL_CARD, COL_TEXT  # Importa cores definidas no ficheiro de configuração

# -----------------------------
# Classe para criar um botão interativo
# -----------------------------
class Button:
    def __init__(self, rect, text, font, color=(40,120,200), hover_color=(60,150,230), icon=""):
        # rect: posição e tamanho do botão (x, y, largura, altura)
        # text: texto que aparece no botão
        # font: fonte usada para desenhar o texto
        # color: cor normal do botão
        # hover_color: cor quando o rato passa por cima
        # icon: opcional, ícone a colocar junto ao texto
        self.rect = pygame.Rect(rect)  # cria retângulo do botão
        self.text = text
        self.font = font
        self.color = color
        self.hover_color = hover_color
        self.icon = icon
        self.hover = False   # indica se o rato está por cima
        self.pressed = False # indica se o botão foi clicado

    # Atualiza estado do botão (hover)
    def update(self):
        mouse = pygame.mouse.get_pos()  # obtém posição atual do rato
        self.hover = self.rect.collidepoint(mouse)  # True se o rato estiver dentro do botão

    # Desenha o botão na tela
    def draw(self, surface):
        col = self.hover_color if self.hover else self.color  # muda a cor se estiver hover
        pygame.draw.rect(surface, col, self.rect, border_radius=10)  # desenha retângulo do botão
        txt = f"{self.icon} {self.text}" if self.icon else self.text  # junta ícone ao texto
        surf = self.font.render(txt, True, COL_TEXT)  # cria superfície com o texto
        r = surf.get_rect(center=self.rect.center)   # centraliza o texto dentro do botão
        surface.blit(surf, r)  # desenha o texto na tela

    # Verifica se o botão foi clicado
    def handle_event(self, event):
        if event.type == pygame.MOUSEBUTTONDOWN and event.button == 1:  # botão esquerdo do rato
            if self.rect.collidepoint(event.pos):  # se o clique estiver dentro do botão
                return True  # devolve True (clicado)
        return False  # caso contrário, devolve False

# -----------------------------
# Funções utilitárias de desenho
# -----------------------------

# Desenha texto centrado em determinada posição
def draw_text_center(surface, text, font, color, x, y):
    surf = font.render(text, True, color)  # cria superfície com o texto
    rect = surf.get_rect(center=(x, y))   # calcula posição central
    surface.blit(surf, rect)              # desenha na tela
    return rect                           # retorna retângulo (pode ser útil para detetar clique)

# Divide um texto em várias linhas para caber dentro de largura máxima
def wrap_text(text, font, max_width):
    words = text.split()  # separa palavras
    lines = []
    cur = []
    for w in words:
        test = " ".join(cur + [w])          # testa se a palavra cabe na linha
        if font.size(test)[0] <= max_width: # se cabe, adiciona à linha
            cur.append(w)
        else:
            if cur:
                lines.append(" ".join(cur)) # adiciona linha concluída
            cur = [w]                       # inicia nova linha
    if cur:
        lines.append(" ".join(cur))         # adiciona última linha
    return lines

# Desenha um retângulo com bordas arredondadas (tipo "card")
def draw_card(surface, rect, color=COL_CARD):
    pygame.draw.rect(surface, color, rect, border_radius=12)
