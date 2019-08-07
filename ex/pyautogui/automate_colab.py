import pyautogui as pyautogui
import os, time, threading
from datetime import datetime
import numpy as np

'returning position (x,y) of mouse'
def get_pos():
    return tuple(pyautogui.position())

'Movements of Mouse Absolute & Relative'
def move(x,y,abs=True,duration=0):
    if abs:
        pyautogui.moveTo(  x,y,duration=duration )
    else:
        pyautogui.moveRel( x,y,duration=duration )

'Dragging with Mouse Absolute & Relative'
def drag(x,y,abs=True,duration=0.1):
    if abs:
        pyautogui.dragTo(  x,y,duration=duration )
    else:
        pyautogui.dragRel( x,y,duration=duration )

'Various types of clicks to be done'
def click(x,y,typ='left'):
    # ['left','down','up','middle','right','double']
    if typ=='left':
        pyautogui.click(x,y)
    elif typ=='down':
        pyautogui.mouseDown(x,y)
    elif typ=='up':
        pyautogui.mouseUp(x,y)
    elif typ=='middle':
        pyautogui.middleClick(x,y)
    elif typ=='right':
        pyautogui.rightClick(x,y)
    elif typ=='double':
        pyautogui.doubleClick(x,y)

'Scrolling with Mouse, +ve gives up-scroll'
def scroll(x):
    pyautogui.scroll(x)

'keyboard function'
def write(st,delay=0.1):
    'st can be atring or list of special keys'
    pyautogui.typewrite(st,delay=delay)
def key(st,state='press'):
    if state=='down':
        pyautogui.keyDown(st)
    elif state=='up':
        pyautogui.keyUp(st)
    elif state=='press':
        pyautogui.press(st)
def hotkey(*ls):
    pyautogui.hotkey(*ls)
def get_all_keys():
    return pyautogui.KEYBOARD_KEYS

'Screenshot & Image processing function'
def ss():
    return pyautogui.screenshot()
def pixel_value(im,x,y):
    return im.getpixel((x,y))
def match_color(im,x,y,val):
    return pyautogui.pixelMatchesColor(x,y,val)
def locate(img): # None if that cannot be found
    'return bounding box in form of (LX,LY,dX,dY)'
    pyautogui.locateOnScreen(img)
def locateAll(img):
    return list( pyautogui.locateAllOnScreen(img) )
def center(tpl):
    return pyautogui.center(tpl)



class AutomateColab(threading.Thread):
    def __init__(self,action_images_dir='.',PAUSE=1,FAILSAFE=True):
        self.main_running, self.auto_thread_running = True, False
        self.action_images_dir = action_images_dir
        self.W, self.H  = pyautogui.size()
        # Seconds of Pause after each function of pyautogui call
        pyautogui.PAUSE = PAUSE
        # Enabling FAILSAFE, moving to (0,0) raises 'pyautogui.FailSafeException'
        pyautogui.FAILSAFE = True 
        # Ideally should return (1366,768)
    
    def run(self):
        'Entire code to automate Google-Colab in this function, as a thread'
        try:
            action = {x:os.path.join(self.action_images_dir,x) for x in os.listdir(self.action_images_dir)}
            while self.main_running:
                self.auto_thread_running = True

                click_pos = center(locateAll(action['toolbar_runtime.PNG'])[0])        ; click(*click_pos)
                click_pos = center(locateAll(action['list_reset_all_runtime.PNG'])[0]) ; click(*click_pos)
                click_pos = center(locateAll(action['dialogue_yes.PNG'])[0])           ; click(*click_pos)

                while not locateAll(action['vm_ready.PNG']):
                    ls_connect = locateAll(action['colab_connect.PNG'])
                    if ls_connect:
                        click_pos = center(ls_connect[0])    ; click(*click_pos)
                    ls_reconnect = locateAll(action['colab_reconnect.PNG'])
                    if ls_reconnect:
                        click_pos = center(ls_reconnect[0])  ; click(*click_pos)

                click_pos = center(locateAll(action['toolbar_runtime.PNG'])[0])        ; click(*click_pos)
                click_pos = center(locateAll(action['list_run_all.PNG'])[0])           ; click(*click_pos)

                while True:
                    ls_connect     = locateAll( action['colab_connect.PNG']      )
                    ls_reconnect   = locateAll( action['colab_reconnect.PNG']    )
                    ls_d_close     = locateAll( action['dialogue_close.PNG']     )
                    ls_d_reconnect = locateAll( action['dialogue_reconnect.PNG'] )
                    if any(ls_connect,ls_reconnect):
                        click_pos = center(ls_d_close[0])  ; click(*click_pos)
                        break
                    if any(ls_connect,ls_reconnect):
                        break

        # except pyautogui.FailSafeException as exc:
        except Exception as exc:
            self.auto_thread_running = False
        
if __name__=='__main__':
    colab = AutomateColab('images')
    assert (colab.W,colab.H)==(1366,768)
    colab.start()