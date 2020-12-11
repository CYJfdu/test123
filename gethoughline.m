clear;  
clc;

I=imread('rmb2.jpg');  
I2=rgb2gray(I);
% % 迭代式阈值分割,如果背景较亮可能需要调节二值化阈值
zmax=max(max(I2));
zmin=min(min(I2));
tk=(zmax+zmin)/2;  
bcal=1;  
[m,n]=size(I2);  
while(bcal)  
     
    iforeground=0;  
    ibackground=0;  
     
    foregroundsum=0;  
    backgroundsum=0;  
    for i=1:m  
        for j=1:n  
            tmp=I(i,j);
            if(tmp>=tk) 
                iforeground=iforeground+1;  
                foregroundsum=foregroundsum+double(tmp);  
            else  
                ibackground=ibackground+1;  
                backgroundsum=backgroundsum+double(tmp);  
            end  
        end  
    end  
    z1=foregroundsum/iforeground;  
    z2=backgroundsum/ibackground;  
    tktmp=uint8((z1+z2)/2); 
    if(tktmp==tk)  
        bcal=0;  
    else  
        tk=tktmp;  
    end  

end   
newI=im2bw(I2,double(tk)/255);
[width, hight]=size(I2);
threpixels=width*hight*0.1;
newI2=bwareaopen(newI,threpixels);
figure;
subplot(1,2,1);
imshow(newI2);
%% 
thresh=[0.01,0.17];
sigma=2;
f=edge(newI2);

[H,T,R]=hough(f,'RhoResolution',2);
P=houghpeaks(H,5);
lines=houghlines(f,T,R,P);
subplot(1,2,2);
imshow(f);
hold on;
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
