# Matlab-Object-Counting
Object counting in an image is a task where we need to identify the number of items inside an image. In our project, we introduced a few phases in completing the task.  The phases are read the image. This process required the use of imread() to read image files into an array.  

Next, we will need to convert an image to grayscale, thresholding image into binary. To do the global thresholding, we can first view the object in histogram form and determine which one is the best value to a threshold. Good threshold value allows us to separated the background and images efficiently, which is a great help in the later finding the centroid. In our system, we implement a user-friendly interface sliding windows that range from 0 to 255 to allow easy segmentation of the image. 

On top of that, we will apply the morphology opening and closing to clean up the images. Based on our observation, some images will perform better with only either one of the operations. Therefore, opening and closing also factor that affects the accuracy later in image counting. After the process, we will perform color inversion to invert the back and white pixels. 

Lastly, we will need to segment out the boundaries of the previous inverted color image. We will then use a looping structure to loop over all the blob found inside the image. Besides, we will also need to find the centroid of the blob and append the number 1 to n based on the blob found.  

In retrospect, we also have displayed the quantitative analysis details such as mean intensity, area, perimeter, centroid, and diameter. This information can be useful for the quantitative analysis required by the case study and rubrics. 
