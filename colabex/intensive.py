from datetime import datetime
i,init = 0,datetime.now()
init, state = init.replace(second=0,microsecond=999999), True
print(init)
while True:
  _ = datetime.now()
  #print('{}\r'.format((_-init).seconds),end='')
  if not ((_-init).seconds%60):
    if state:
      print('{}\r'.format(_-init),end='')
      state = False
  else:
    state = True  
    
