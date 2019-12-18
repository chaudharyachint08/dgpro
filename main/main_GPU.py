# [1]
import os
# Using GDrive storage as file-system for experimentation
from google.colab import drive
try:
    drive.mount('/content/gdrive')
    os.chdir('gdrive/My Drive')
except:
    pass
os.getcwd()

# Removing Permission if you want to unmount
# https://myaccount.google.com/permissions




# [2]
'Entire Code for GPU processing Below'
import os, sys

myutils = 'myutils'
sys.path.insert(1,'myutils')
