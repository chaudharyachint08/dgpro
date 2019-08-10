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
    def __init__(self,action_images_dir='.',PAUSE=1,FAILSAFE=True,sleep_duration=15,drag_limit=1,out_center=0.3):
        super(AutomateColab, self).__init__()
        self.main_running, self.auto_thread_running = True, False
        self.action_images_dir = action_images_dir
        self.WIDTH, self.HEIGHT  = pyautogui.size()
        # Seconds of Pause after each function of pyautogui call
        pyautogui.PAUSE = PAUSE
        # Enabling FAILSAFE, moving to (0,0) raises 'pyautogui.FailSafeException'
        pyautogui.FAILSAFE = True 
       
        self.sleep_duration = sleep_duration
        self.drag_limit = drag_limit
        self.out_center = out_center
    
    def mcenter(self,tpl):
        tmp = pyautogui.center(tpl)
        return ( tmp[0]+tpl[2]*np.random.random()*self.out_center , tmp[1]+tpl[3]*np.random.random()*self.out_center )

    def mclick(self,*arg):
        delay = self.drag_limit*np.random.random()
        move(*arg,duration=delay) ; click(*arg)

    def wait_find_click(self,image):
        while True:
            tmp = locateAll(self.action[image])
            if tmp:
                break
        click_pos = self.mcenter(tmp[0]) ; self.mclick(*click_pos)
        
    def authenticate(self,action):
        self.wait_find_click( 'drive_url.PNG'  )
        self.wait_find_click( 'drive_user.PNG' )
        pyautogui.scroll(-5000) # Very high Down-scroll
        self.wait_find_click( 'drive_allow_button.PNG' )
        self.wait_find_click( 'drive_copy_button.PNG'  )
        pyautogui.hotkey('ctlrleft','altleft','\t')
        self.wait_find_click( 'drive_input_box.PNG'    )
        pyautogui.hotkey('ctlrleft','v','\t')
        pyautogui.hotkey('enterleft')

    def run(self):
        'Entire code to automate Google-Colab in this function, as a thread'
        self.action = action = {x:os.path.join(self.action_images_dir,x) for x in os.listdir(self.action_images_dir)}
        pyautogui.hotkey('altleft','\t')
        pyautogui.scroll(5000) # Very high Up-scroll
        Colab_Count = 0
        self.auto_thread_running = True

        if locateAll(action['drive_import.PNG']):
            authentication_flag = True
        else:
            authentication_flag = False

        while self.main_running:
            while self.auto_thread_running:
                try:    
                    while True:
                        tmp = locateAll(action['toolbar_runtime.PNG'])
                        if tmp:
                            click_pos = self.mcenter(tmp[0]) ; self.mclick(*click_pos) ; break
                        time.sleep(self.sleep_duration)
                    click_pos = self.mcenter(locateAll(action['list_reset_all_runtime.PNG'])[0]) ; self.mclick(*click_pos)
                    click_pos = self.mcenter(locateAll(action['dialogue_yes.PNG'          ])[0]) ; self.mclick(*click_pos)

                    # with open('BEFORE_VM_READY','w') as ftmp:
                    #     pass

                    while not locateAll(action['vm_ready.PNG']):
                        # Checks if VM is ready
                        continue
                        '''
                        ls_connect = locateAll(action['colab_connect.PNG'])
                        if ls_connect:
                            click_pos = self.mcenter(ls_connect[0])    ; self.mclick(*click_pos)
                        ls_reconnect = locateAll(action['colab_reconnect.PNG'])
                        if ls_reconnect:
                            click_pos = self.mcenter(ls_reconnect[0])  ; self.mclick(*click_pos)
                        '''
                    # with open('AFTER_VM_READY','w') as ftmp:
                    #     pass

                    while True:
                        tmp = locateAll(action['toolbar_runtime.PNG'])
                        if tmp:
                            click_pos = self.mcenter(tmp[0]) ; self.mclick(*click_pos) ; break
                        time.sleep(self.sleep_duration)
                    click_pos = self.mcenter(locateAll(action['list_run_all.PNG'])[0]) ; self.mclick(*click_pos)

                    if authentication_flag:
                        self.authenticate()

                    init = datetime.now()
                    # Wait till VM shows BUSY
                    while not locateAll(action['vm_busy.PNG']):
                        time.sleep(self.sleep_duration)
                    # with open('VM_READY_AFTER_EXECUTION','w') as ftmp:
                    # 	pass
                    # Either VM ready after execution of 10 seconds or any button/dialogue is on screen
                    while not locateAll(action['vm_ready.PNG']):
                        ls_d_close     = locateAll( action['dialogue_close.PNG']     )
                        ls_d_reconnect = [] # locateAll( action['dialogue_reconnect.PNG'] )
                        if any((ls_d_close,ls_d_reconnect)):
                            click_pos = self.mcenter(ls_d_close[0])  ; self.mclick(*click_pos)
                            break
                        ls_connect     = locateAll( action['colab_connect.PNG']      )
                        ls_reconnect   = locateAll( action['colab_reconnect.PNG']    )
                        if any((ls_connect,ls_reconnect)):
                            break
                        time.sleep(self.sleep_duration)

                    with open('Colab_Count.txt','a') as file:
                        Colab_Count += 1
                        print( Colab_Count, datetime.now()-init, file=file,flush=True )
                except pyautogui.FailSafeException as exc:
                    self.auto_thread_running = False
                except Exception as exc:
                    with open('Colab_Log.txt','w') as file: # Delete log file to continue
                        print( str(exc), file=file,flush=True )
                        print( Colab_Count+1, file=file,flush=True )
                    while  'Colab_Log.txt' in os.listdir():
                        time.sleep(self.sleep_duration)
                        if 'Colab_End.txt' in os.listdir(): # Create this file to end Automation
                            self.auto_thread_running = False
                            break
                    else:
                        self.auto_thread_running = True
