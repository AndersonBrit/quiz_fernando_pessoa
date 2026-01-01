# src/ui.py

import pygame
from config import COL_CARD, COL_TEXT  # Import colors defined in the configuration file


# -----------------------------
# Class to create an interactive button
# -----------------------------
class Button:
    def __init__(self, rect, text, font, color=(40,120,200), hover_color=(60,150,230), icon=""):
        # rect: button position and size (x, y, width, height)
        # text: text displayed on the button
        # font: font used to render the text
        # color: default button color
        # hover_color: button color when mouse hovers over it
        # icon: optional icon displayed next to the text
        self.rect = pygame.Rect(rect)  # create button rectangle
        self.text = text
        self.font = font
        self.color = color
        self.hover_color = hover_color
        self.icon = icon
        self.hover = False   # indicates whether the mouse is hovering over the button
        self.pressed = False # indicates whether the button was clicked

    # Update button state (hover detection)
    def update(self):
        mouse = pygame.mouse.get_pos()              # get current mouse position
        self.hover = self.rect.collidepoint(mouse) # True if mouse is over the button

    # Draw the button on the screen
    def draw(self, surface):
        col = self.hover_color if self.hover else self.color  # change color on hover
        pygame.draw.rect(surface, col, self.rect, border_radius=10)  # draw button rectangle
        txt = f"{self.icon} {self.text}" if self.icon else self.text # combine icon and text if provided
        surf = self.font.render(txt, True, COL_TEXT)            # render text surface
        r = surf.get_rect(center=self.rect.center)              # center text inside the button
        surface.blit(surf, r)                                   # draw text on screen

    # Check if the button was clicked
    def handle_event(self, event):
        if event.type == pygame.MOUSEBUTTONDOWN and event.button == 1:  # left mouse button
            if self.rect.collidepoint(event.pos):  # click inside button area
                return True                         # button clicked
        return False                                # otherwise, not clicked


# -----------------------------
# Utility drawing functions
# -----------------------------

# Draw centered text at a given position
def draw_text_center(surface, text, font, color, x, y):
    surf = font.render(text, True, color)     # render text surface
    rect = surf.get_rect(center=(x, y))       # calculate centered position
    surface.blit(surf, rect)                  # draw text on screen
    return rect                               # return rect (useful for click detection)

# Split text into multiple lines to fit within a maximum width
def wrap_text(text, font, max_width):
    words = text.split()  # split text into words
    lines = []
    cur = []
    for w in words:
        test = " ".join(cur + [w])                # test line with next word
        if font.size(test)[0] <= max_width:       # if it fits, keep adding
            cur.append(w)
        else:
            if cur:
                lines.append(" ".join(cur))       # store completed line
            cur = [w]                             # start new line
    if cur:
        lines.append(" ".join(cur))               # add last line
    return lines

# Draw a rounded rectangle (card-style container)
def draw_card(surface, rect, color=COL_CARD):
    pygame.draw.rect(surface, color, rect, border_radius=12)
