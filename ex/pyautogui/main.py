from AutomateColab import AutomateColab

if __name__=='__main__':
    '                      directory, PAUSE, FAIL_SAFE, SLEEP_DURATION, DRAG_DELAY_LIMIT, OUT_CENTER'
    colab = AutomateColab( 'images',    1,      True,         1,               1,            0.25 )
    assert (colab.WIDTH,colab.HEIGHT)==(1366,768)
    colab.start()
    st = input('Enter string to end process')
    colab.auto_thread_running = False