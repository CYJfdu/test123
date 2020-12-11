% lena_oringin=imread("lena512color.tiff");
% lena_embed=imread("lena512color_digimarc_s5.tif");
% chazhi=lena_oringin-lena_embed;
% Gembed=lena_embed(:,:,2);
% Rcha=chazhi(:,:,1);
% Gcha=chazhi(:,:,2);
% Bcha=chazhi(:,:,3);
% 
% Ireve=imcomplement(chazhi);
% % I=imread("5555.png");
% thre=graythresh(Ireve);
% I2=im2bw(Ireve,thre);
% figure;
% imshow(I2);  
% % imshow(chazhi(:,:,2));
% img_x = "123.png";
% img_y = "123124.png";
% x = imread(img_x);	% 读取图像x
% y = imread(img_y);	% 读取图像y
% figure;
% subplot(1, 2, 1); imshow(x);	% 显示图像x
% subplot(1, 2, 2); imshow(y);	% 显示图像y
% set(gcf, "outerposition", get(0, "screensize")); 	% 将图像全萤幕显示
% [x0,y0] = ginput(3);	% 通过鼠标点击三次取得三个坐标点
% [x1,y1] = ginput(3);	% 通过鼠标点击三次取得目标图中对应的三个坐标点
% close all;	% 关闭图像显示
% in_points = [x0,y0];
% out_points = [x1,y1];
% tform2 = maketform('affine', in_points, out_points);	% 计算变换矩阵
% T = affine2d(tform2.tdata.T);	% 将变换矩阵转化为仿射变换矩阵类型
% z = imwarp(x,T,'OutputView',imref2d(size(y)));	% 进行仿射变换
% img_result = "./3.png";
% imwrite(z, img_result);	% 存储结果