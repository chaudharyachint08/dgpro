import os, sys

myutils = 'myutils'
sys.path.insert(1,'myutils')


from GDrive import GDrive
from SchemaGraph import SchemaGraph
from AutomateColab import AutomateColab


AutomateColab_obj = AutomateColab(
    os.path.join(myutils,'images'), # directory to take images for colab (dark mode)
    1,                              # PAUSE after each pyautogui call
    True,                           # FAIL_SAFE
    1,                              # SLEEP_DURATION
    1,                              # DRAG_DELAY_LIMIT
    0.25 )                          # OUT_CENTER
# Code if Fragile for Fix Image Resolution & 
assert (AutomateColab_obj.WIDTH,AutomateColab_obj.HEIGHT)==(1366,768)
# Thread for Google Colab & Drive Automation Loop
# AutomateColab_obj.start() 
# AutomateColab_obj.auto_thread_running = False

'Code for Managing & Collecting Data on Master System'
pass