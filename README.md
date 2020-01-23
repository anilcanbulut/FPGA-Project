# FPGA-Project
Image Processing in FPGA

-This project is made by students of Marmara University Electrical and Electronics Engineering.

In this project, we've tried to make an image processing application by using an FPGA board (EP4CE6E22C8N Altera Cyclone IV). Since the board we've used does not have enough memory to store big resolution images, and also an output of the VGA port of this card allows 1-bit data for each color (RGB-3 bits). 

# PROJECT STEPS
- First, we find an image and convert it to a binary image by using the provided python code.
- After converting the image, we store it in a memory location in FPGA, then we output each pixel by using the VGA module and see the result on the screen.
- For a grayscale image, we need an RGB image which we already have. Formula for RGB to gray image is this: ((0.3 * R) + (0.59 * G) + (0.11 * B)). We have done it by just simply shifting bits of each color space.
- After obtaining the grayscale image, we apply the same things for the grayscale image as we did in RGB, then show it on the screen.

These are all steps that we have done during this project. 

# Project Files
- Training.v: The top module of the project
- vga.v: The module that is used for sending pixel values to the screen
- sram.v: Static image storage. We store both RGB and grayscale images in this module and call them in the Training module.
- binary2.mem: This is the memory file that contains binary data of the "bird.jpg" image. If you use this file in the project, you will see the bird picture on the screen. 
