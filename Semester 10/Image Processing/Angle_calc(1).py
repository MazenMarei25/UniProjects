import time
import cv2
from pygame import mixer
from multiprocessing.shared_memory import SharedMemory
import cv2
import numpy as np
import time
import mediapipe as mp
from pygame import mixer
import sys
import serial

arduino = serial.Serial(port='COM6', baudrate=9600)
mp_drawing = mp.solutions.drawing_utils
mp_holistic = mp.solutions.holistic
mp_pose = mp.solutions.pose

curr_shared = SharedMemory(name='curr_cor')
prev_shared = SharedMemory(name='prev_cor')
curr_pixel_shared = SharedMemory(name='curr_cor_pixel')
dif = SharedMemory(name='dif')
flag = SharedMemory(name='off')
midx_shared=SharedMemory(name='midx')
midy_shared=SharedMemory(name='midy')
sweep_shared = SharedMemory(name='sweep')

curr_cor = np.ndarray([12, 2], dtype='float64', buffer=curr_shared.buf)
curr_cor_pixel = np.ndarray([12, 2], dtype='float64', buffer=curr_pixel_shared.buf)
prev_cor = np.ndarray([12, 2], dtype='float64', buffer=prev_shared.buf)
differ = np.ndarray([12, 2], dtype='float64', buffer=dif.buf)
midx=np.ndarray([1,1], dtype='float64', buffer=midx_shared.buf)
midy=np.ndarray([1,1], dtype='float64', buffer=midy_shared.buf)
sweep=np.ndarray([1,1], dtype='float64', buffer=sweep_shared.buf)

mixer.init()
RedLight = False
motion_detected = False

def angle_calc():
    global RedLight
    global motion_detected
    while True:
        if np.any(curr_cor) == True:
            t_end = time.time() + 5
            while time.time() < t_end:
                mixer.music.load(r"C:\Users\Lenovo\Desktop\RedGreen.mp3")
                mixer.music.set_volume(0.7)
                mixer.music.play()
                time.sleep(7)
                mixer.music.stop()
                RedLight = True

            t_end_red = time.time() + 5
            while not mixer.music.get_busy() and time.time() < t_end_red:
                if RedLight:
                    if differ.any():
                        print('MOTION DETECTED!')
                        motion_detected = True
                    if motion_detected:
                       # sweep_angle = round(degrees(atan2(midy[0,0], midx[0,0])))
                        x=int(sweep[0,0])
                        print(x)
                        arduino.write(bytes([x]))
                        #arduino.write(bytes([180]))
                        flag.buf[0] = 1
                        sys.exit()
    RedLight = False
    motion_detected = False


angle_calc()
