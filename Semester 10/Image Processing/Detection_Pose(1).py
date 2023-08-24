from multiprocessing.shared_memory import SharedMemory
import cv2
import numpy as np
import mediapipe as mp
import sys
from math import atan2, degrees
mp_drawing = mp.solutions.drawing_utils
mp_holistic = mp.solutions.holistic
mp_pose = mp.solutions.pose

curr_shared = SharedMemory(name='curr_cor', create=True, size=8 * 24)
prev_shared = SharedMemory(name='prev_cor', create=True, size=8 * 24)
curr_pixel_shared = SharedMemory(name='curr_cor_pixel', create=True, size=8 * 24)
sweep_shared = SharedMemory(name='sweep', create=True, size=8 * 24)
dif = SharedMemory(name='dif', create=True, size=8 * 24)
flag = SharedMemory(name='off', create=True, size=1)
midx_shared=SharedMemory(name='midx', create=True, size=8 * 24)
midy_shared=SharedMemory(name='midy', create=True, size=8 * 24)
flag.buf[0] = 0


curr_cor = np.ndarray([12, 2], dtype='float64', buffer=curr_shared.buf)
curr_cor[:] = np.zeros(curr_cor.shape)[:]

curr_cor_pixel = np.ndarray([12, 2], dtype='float64', buffer=curr_pixel_shared.buf)
curr_cor_pixel[:] = np.zeros(curr_cor_pixel.shape)[:]

prev_cor = np.ndarray([12, 2], dtype='float64', buffer=prev_shared.buf)
prev_cor[:] = np.zeros(prev_cor.shape)[:]

differ = np.ndarray([12, 2], dtype='float64', buffer=dif.buf)
differ[:] = np.zeros(differ.shape)[:]

midx=np.ndarray([1,1], dtype='float64', buffer=midx_shared.buf)
midx[:] = np.zeros(midx.shape)[:]
midy=np.ndarray([1,1], dtype='float64', buffer=midy_shared.buf)
midy[:] = np.zeros(midy.shape)[:]

sweep=np.ndarray([1,1], dtype='float64', buffer=sweep_shared.buf)
sweep[:] = np.zeros(sweep.shape)[:]



def estimation():
    cap = cv2.VideoCapture(0)
    with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
        while flag.buf[0] == 0:
            ret, frame = cap.read()
            image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = holistic.process(image)
            image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
            drw = results.pose_landmarks
            mp_drawing.draw_landmarks(image, drw, mp_holistic.POSE_CONNECTIONS)
            h, w = image.shape[:2]
            cx = w // 2
            cy = h // 2
            cv2.line(image, [cx, 0], [cx, h], [0, 0, 0], 2)
            cv2.line(image, [0, cy], [w, cy], [0, 0, 0], 2)

            cv2.imshow('Raw Webcam Feed', image)
            if cv2.waitKey(10) & 0xFF == ord('q'):
                sys.exit()

            index = 11
            if results.pose_landmarks is not None:
                for i in range(12):
                    prev_cor[i, 0] = curr_cor[i, 0]
                    prev_cor[i, 1] = curr_cor[i, 1]
                    curr_cor[i, 0] = results.pose_landmarks.landmark[index].x
                    curr_cor[i, 1] = results.pose_landmarks.landmark[index].y
                    if index == 16:
                        index = 22
                    index += 1

                for z in range(12):
                    curr_cor_pixel[z, 0] = (curr_cor[z, 0] * w) - cx
                    curr_cor_pixel[z, 1] = (-1 * curr_cor[z, 1] * h) + cy

                for k in range(12):
                    differ[k, 0] = round(((curr_cor[k, 0]) - (prev_cor[k, 0]))*100)
                    differ[k, 1] = round(((curr_cor[k, 1]) - (prev_cor[k, 1]))*100)

                midx[0,0] = round((curr_cor_pixel[0, 0] + curr_cor_pixel[1, 0]) / 2)
                midy[0,0] = round((curr_cor_pixel[0, 1] + curr_cor_pixel[1, 1]) / 2)
                sweep[0,0] = round(degrees(atan2(midy[0, 0], midx[0, 0])))
                print(midx[0,0],midy[0,0])

        cap.release()
        cv2.destroyAllWindows()


estimation()
