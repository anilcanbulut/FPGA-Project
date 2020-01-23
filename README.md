# FPGA-Project
Image Processing in FPGA

-This project is made by students of Marmara University Electrical and Electronics Engineering.

In this project, we've tried to make an image processing application by using a FPGA board (EP4CE6E22C8N Altera Cyclone IV). Since the board we've used does not have enough memory to story big resolution images, and also output of the VGA port of this card allows 1 bit data for each color (RGB-3 bits). 

# PROJECT STEPS
- First we find an image and convert it to binary image by using provided python code.
- After converting the image, we store it in a memory location in FPGA, then we output each pixel by using VGA module and see the result on the screen.
- For grayscale image, we need RGB image which we already have. Formula for RGB to gray image is this: ((0.3 * R) + (0.59 * G) + (0.11 * B)). We have done it by just simply shifting bits of each color space.
- After obtaining gray scale image, we apply the same things for gray scale image as we did in RGB, then show it on the screen.

These are the all steps that we have done during this project. 

# Project Files
- Training.v: Top module of the project
- vga.v: Module that is used for sending pixel values to the screen
- sram.v: Static image storage. We store both RGB and gray scale images in this module and call them in the Training module.
- binary2.mem: This is the memory file that contains binary data of the "bird.jpg" image. If you use this file in the project, you will see the bird picture on the screen.
