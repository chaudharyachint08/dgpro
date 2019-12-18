from pynput.mouse import Button, Controller

mouse = Controller()

mouse.position



mouse.position = (640,480)

mouse.move = (20,300)

mouse.click = (Button.left,300)

mouse.press(Button.left)
mouse.release(Button.left)

mouse.scroll(5,40) # (dx,dy)