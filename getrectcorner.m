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
[hight, width]=size(I2);
threpixels=width*hight*0.1;
newI2=bwareaopen(newI,threpixels);
figure;

imshow(newI2);
leftup=[0,0];leftdown=[0,0];rightup=[0,0];rightdown=[0,0];
max_disten=width+hight;
minlu=max_disten;minld=max_disten;minru=max_disten;minrd=max_disten;
for i=1:hight
    for j=1:width
        if(newI2(i,j)==1)
            if(i+j-2<minlu)
                minlu=i+j-2;
                leftup=[i,j];
            end
            if(width-j+i-1<minru)
                minru=width-j+i-1;
                rightup=[i,j];
            end
            if(width-j+hight-i<minrd)
                minrd=width-j+hight-i;
                rightdown=[i,j];
            end
            if(hight-i+width-1<minld)
                minld=hight-i+width-1;
                leftdown=[i,j];
            end
        end
    end
end
