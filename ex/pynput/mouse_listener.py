from pynput.mouse import Listener


verbose = int(input('Enter 1 for verbose, 0 otherwise\n').strip())


if verbose:
	import logging
	logging.basicConfig(file_name='mouse_log.txt',level=logging.DEBUG,format='%{asctime}s: {message}s')
	mprint = logging.info
else:
	mprint = print


def on_move(x,y):
	mprint('Moved to ({},{})'.format(x,y))

def on_click(x,y,button,pressed):
	mprint('Clicked at ({},{}) with {} button and {} pressed'.format(x,y,button,pressed))

def on_scroll(x,y,dx,dy):
	mprint('Scrolled at ({},{}) for ({},{})'.format(x,y,dx,dy))
	listener.stop()


with Listener(on_move=on_move, on_click=on_click, on_scroll=on_scroll) as listener:
	listener.join()