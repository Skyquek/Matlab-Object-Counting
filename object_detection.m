clc, clear;
imgName = "images/lego1.png";

% Read Image
image = imread(imgName);
subplot(3,3,1), imshow(image), title('Original');

% convert to grayscale
grayscale=rgb2gray(image);

% Find the histogram
hist = imhist(grayscale);
binaryImg = grayscale > 170;

se=strel('disk', 4);

% Use Image Opening Method
afterOpening=imopen(binaryImg,se);
subplot(3,3,2), imshow(afterOpening), title('After Opening');

% Use Image Closing method
afterClosing=imclose(afterOpening,se);
subplot(3,3,3), imshow(afterClosing), title('After Closing');

[ColorInverted,num] = bwlabel(~afterClosing,4);
subplot(3,3,4), imshow(ColorInverted), title('Inverted Colour');

labeledImage = bwlabel(ColorInverted, 8);

subplot(3, 3, 5), imshow(labeledImage, []), title('Labeled Image, from bwlabel()');
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels

subplot(3, 3, 6), imshow(coloredLabels);
axis image;
title('Colour Label');

blobMeasurements = regionprops(labeledImage, grayscale, 'all');
numberOfBlobs = size(blobMeasurements, 1);

subplot(3, 3, 7);
imshow(grayscale);
title('Segment out the boundaries, then find centroid. Then we can count the object in the image.'); 
axis image;
hold on;
boundaries = bwboundaries(ColorInverted);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;

textFontSize = 14;	% Used to control size of "blob number" labels put atop the image.
labelShiftX = -7;	
blobECD = zeros(1, numberOfBlobs);
fprintf(1,'Blob #      Mean Intensity  Area   Perimeter    Centroid       Diameter\n');
for k = 1 : numberOfBlobs           % Loop through all blobs.
	thisBlobsPixels = blobMeasurements(k).PixelIdxList;  % Get list of pixels in current blob.
	meanGL = mean(grayscale(thisBlobsPixels)); % Find mean intensity (in original image!)
	meanGL2008a = blobMeasurements(k).MeanIntensity;
	
	blobArea = blobMeasurements(k).Area;		% Get area.
	blobPerimeter = blobMeasurements(k).Perimeter;		% Get perimeter.
	blobCentroid = blobMeasurements(k).Centroid;		% Get centroid one at a time
	blobECD(k) = sqrt(4 * blobArea / pi);					% Compute ECD - Equivalent Circular Diameter.
	fprintf(1,'#%2d %17.1f %11.1f %8.1f %8.1f %8.1f % 8.1f\n', k, meanGL, blobArea, blobPerimeter, blobCentroid, blobECD(k));

    text(blobCentroid(1) + labelShiftX, blobCentroid(2), num2str(k), 'FontWeight', 'Bold', 'Color','red','FontSize', 24);
end
