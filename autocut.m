
clear;  
clc;

I=imread('rmb4.jpg');  
I2=rgb2gray(I);
%% 
%迭代式阈值分割,如果背景较亮可能需要调节二值化阈值
% zmax=max(max(I2));
% zmin=min(min(I2));
% tk=(zmax+zmin)/2;  
% bcal=1;  
% [m,n]=size(I2);  
% while(bcal)  
%      
%     iforeground=0;  
%     ibackground=0;  
%      
%     foregroundsum=0;  
%     backgroundsum=0;  
%     for i=1:m  
%         for j=1:n  
%             tmp=I(i,j);
%             if(tmp>=tk) 
%                 iforeground=iforeground+1;  
%                 foregroundsum=foregroundsum+double(tmp);  
%             else  
%                 ibackground=ibackground+1;  
%                 backgroundsum=backgroundsum+double(tmp);  
%             end  
%         end  
%     end  
%     z1=foregroundsum/iforeground;  
%     z2=backgroundsum/ibackground;  
%     tktmp=uint8((z1+z2)/2); 
%     if(tktmp==tk)  
%         bcal=0;  
%     else  
%         tk=tktmp;  
%     end  
% 
% end   
% newI=im2bw(I2,double(tk)/255);
%% 
newI=im2bw(I2);
[width, hight]=size(I2);
threpixels=width*hight*0.1;
newI2=bwareaopen(newI,threpixels);%去除背景白色噪点

[r,c]=find(newI2==1);
% 'a'是按面积算的最小矩形，如果按边长用'p'
[rectx,recty,area,perimeter] = minboundrect(c,r,'a'); 
subplot(1,2,1);
imshow(I);
line(rectx,recty);
theta=atan((recty(2)-recty(1))/(rectx(2)-rectx(1)))*180/pi;%获得旋转值,目前旋转值未考虑正负号

%%
A=imrotate(newI2,theta);
[r2,c2]=find(A==1);
[rectx2,recty2,area2,perimeter2]=minboundrect(c2,r2,'a');
cropx=rectx2(1);
cropy=recty2(1);
wi=rectx2(2)-rectx2(1);
hi=recty2(4)-recty2(1);%旋转后的坐标以及长宽进行裁剪
I3=imrotate(I,theta);
cropim=imcrop(I3,[cropx cropy wi hi]);
subplot(1,2,2);
imshow(cropim);