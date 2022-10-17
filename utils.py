import numpy as np

def extract_keypoints(corner_image):
    indices = np.where(np.all(corner_image == (1, 1, 1), axis=-1))
    return list(zip(indices[0], indices[1]))