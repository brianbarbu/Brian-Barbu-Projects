#Brian Barbu (brb9da)

import pygame
import gamebox
import random

camera = gamebox.Camera(800,600)
character = gamebox.from_color(600, 500, "red", 20, 40)
character.yspeed = 0


ground = gamebox.from_color(-100, 600, "black", 3000, 150)

plat1 = gamebox.from_color(100, 500, "blue", 100, 20)
plat2 = gamebox.from_color(400, 400, "blue", 150, 20)
plat3 = gamebox.from_color(500, 300, "blue", 100, 20)
platforms = [ground, plat1, plat2, plat3]
platforms2 = [plat1, plat1, plat3]
count = 0
time = 0
gameOn = True

def tick(keys):
    global count,gameOn, time
    if gameOn == True:
        camera.clear('cyan')
        if pygame.K_RIGHT in keys:
            character.x += 15
        if pygame.K_LEFT in keys:
            character.x -= 15
        character.yspeed += 1
        character.y = character.y + character.yspeed
        if character.x > 800:
            character.x = 0
        if character.x < 0:
            character.x= 800
        for x in platforms:
            camera.draw(x)
            if character.bottom_touches(x):
                character.yspeed = 0
                character.move_to_stop_overlapping(x)
            if character.bottom_touches(x) and pygame.K_SPACE in keys:
                character.yspeed = -20
            #if character.touches(x):
                #character.move_to_stop_overlapping(x)
        count += 1
        if count % 20 == 0:
            newWall = gamebox.from_color(random.randint(100, 700), camera.y -random.randint(0,100), "blue", random.randint(100, 300), 10)
            platforms.append(newWall)
            platforms2.append(newWall)
        if character.__getattr__('bottom')>= camera.__getattr__('bottom'):
            gameOn = False
        camera.y -=3
        camera.draw(character)
        time +=1
        seconds = str(int((time / ticks_per_second)%60)).zfill(2)
        minutes = str(int((time/ticks_per_second)/60))
        clock = gamebox.from_text(650,camera.y-250,"Time Alive: "+minutes + ":" + seconds, "Comic Sans MS",30,"black")
        camera.draw(clock)
    if gameOn is False:
        end = gamebox.from_text(camera.x, camera.y, "Game Over", "Comic Sans MS", 100, "black")
        camera.draw(end)
    camera.display()
ticks_per_second = 40

# keep this line the last one in your program
gamebox.timer_loop(ticks_per_second, tick)