from pynput.keyboard import Key, Listener


verbose = int(input('Enter 1 for verbose, 0 otherwise\n').strip())


if verbose:
    import logging
    logging.basicConfig(file_name='mouse_log.txt',level=logging.DEBUG,format='%{asctime}s: {message}s')
    mprint = logging.info
else:
    mprint = print


def on_press(key):
    mprint(key)


with Listener(on_move=on_move, on_click=on_click, on_scroll=on_scroll) as listener:
    listener.join()