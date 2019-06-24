#Austin Zavacky and Brian Barbu
#axz4jn and brb9da

# our first game

import pygame
import gamebox

camera = gamebox.Camera(800,600)
character = gamebox.from_color(50, 50, "red", 30, 60)
character.yspeed = 0

ground = gamebox.from_color(-100, 600, "black", 3000, 100)

def tick(keys):
    if pygame.K_RIGHT in keys:
        character.x += 5
    if pygame.K_LEFT in keys:
        character.x -= 5
    character.yspeed += 1
    character.y = character.y + character.yspeed
    if character.bottom_touches(ground):
        character.yspeed = 0
    if character.touches(ground):
        character.move_to_stop_overlapping(ground)
    camera.clear("cyan")
    camera.draw(character)
    camera.draw(ground)
    camera.display()
ticks_per_second = 30

# keep this line the last one in your program
gamebox.timer_loop(ticks_per_second, tick)