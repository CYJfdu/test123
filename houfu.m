I=imread("fudan1_digimarc_S5.jpg");
BW=im2bw(I);
BW2=bwperim(BW);
figure;
imshow(BW2);
IBW = ~BW;
F1 = imfill(IBW,'holes');
SE = ones(3);
F2 = imdilate(F1,SE,'same');
BW3 = bwperim(F2);
BW4=edge(BW,'canny');


subplot(1,2,1);
figure;
imshow(I);
title('original iamge');
subplot(1,2,2), imshow(BW4);
title('operated bwperim'); 


