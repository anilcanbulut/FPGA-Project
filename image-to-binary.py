import cv2
import argparse 

#argument parser is for cmd usage.
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="image path")
args = vars(ap.parse_args())

def map(x, in_min, in_max, out_min, out_max):
    return int((x-in_min) * (out_max-out_min) / (in_max-in_min) + out_min)

#reading image by opencv and changing its resolution to 120*120
img = cv2.imread(args["image"])
img = cv2.resize(img, (120,120))


file = open("binary2.mem", "w")		#open the file
for i in range(img.shape[0]):
	for j in range(img.shape[1]):
		if(img[i][j][0] < 127):
			img[i][j][0] = 0
		else:
			img[i][j][0] = 255
			
		if(img[i][j][1] < 127):
			img[i][j][1] = 0
		else:
			img[i][j][1] = 255
			
		if(img[i][j][2] < 127):
			img[i][j][2] = 0
		else:
			img[i][j][2] = 255
			
		#scale RGB values from 0-255 to 0-15. Because we want them 4 bits since min and max values in four bits are 0-15.
		R = map(img[i][j][0], 0, 255, 0, 15)
		G = map(img[i][j][1], 0, 255, 0, 15)
		B = map(img[i][j][2], 0, 255, 0, 15)
		
		#format function converts the decimal number to binary. '04b' is making its length 4 bits.
		file.write(str(format(R,'04b') + str(format(G,'04b') + str(format(B,'04b')))))
		file.write("\n")		#write to our file
		
cv2.imwrite("result.jpg", img)
file.close()		#closing the file after process


