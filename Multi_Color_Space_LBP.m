%%%%%%%%%%%%%%%%%%%%%%%%%% READ THE FOLDER PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dir = 'Directory Path';
%%%%%%%%%%%%%%%%%%%% LIST ALL IMAGES IN THE FOLDER %%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = dir(fullfile(Dir, '*.jpg'));
for K = 1:numel(S)
    F = fullfile(Dir, S(K).name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% READ AN IMAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = imread(F);
%%%%%%%%%%%%%%%%%%%%%%%%% RESIZE IMAGE [300 x 300] %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = imresize(I, [300, 300]);
%%%%%%%%%%%%%%%%%%%%%%% CONVERT RGB TO HSV and YCbCr %%%%%%%%%%%%%%%%%%%%%%%%%%
    rgb = im2double(I);
    hsv = rgb2hsv(rgb);
    ycbcr = rgb2ycbcr(rgb);
%%%%%%%%%%%%%%%%%% CONCATENATE ALL CHANNELS [RGB+HSV+YCbCr] %%%%%%%%%%%%%%%%%%%
    W = imadd(ycbcr, hsv);
    I = imadd(W, rgb);
%%%%%%%%%%%%%%%%%%% EXTRACT CHANNELS FROM THE PRODUCED ONE %%%%%%%%%%%%%%%%%%%%
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
%%%%%%%%%%%%%%%%%%%%%%%% GET THE SIZE OF IMAGE CHANNEL %%%%%%%%%%%%%%%%%%%%%%%%
    [m,n]=size(R); 
%%%%%%%%%%%%%%%%%%%%%% CREATE ZERO ARRAYS OF SIZE [8 x 1] %%%%%%%%%%%%%%%%%%%%%
    r=zeros(8,1);
    g=zeros(8,1);
    b=zeros(8,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%% CREATE 2D ARRAYS OF ZERO %%%%%%%%%%%%%%%%%%%%%%%%%%
    RED=zeros(m,n);
    GREEN=zeros(m,n);
    BLUE=zeros(m,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LBP CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=2:m-1
    for j=2:n-1        
        t=1;
        for k=-1:1
            for l=-1:1                
                if (k~=0)||(l~=0)
%%%%%%%%%%%%%%%%%%%%%%%%%%% THRESHOLD TO GENERATE BIT %%%%%%%%%%%%%%%%%%%%%%%%%
                if (R(i+k,j+l)-R(i,j)<0)
                    r(t)=0;
                else
                    r(t)=1;
                end
%%%%%%%%%%%%%%%%%%%%%%%%%% THRESHOLD TO GENERATE BIT %%%%%%%%%%%%%%%%%%%%%%%%%%
                if (G(i+k,j+l)-G(i,j)<0)
                    g(t)=0;
                else
                    g(t)=1;
                end
%%%%%%%%%%%%%%%%%%%%%%%%%% THRESHOLD TO GENERATE BIT %%%%%%%%%%%%%%%%%%%%%%%%%%
                if (B(i+k,j+l)-B(i,j)<0)
                    b(t)=0;
                else
                    b(t)=1;
                end
                t=t+1;
                end
            end
        end  
        for t=0:7
%%%%%%%%%%%%%%%%%%%%%%%% BINARY TO DECIMAL CONVERSION %%%%%%%%%%%%%%%%%%%%%%%%%%
           RED(i,j)=RED(i,j)+((2^t)*r(t+1));  
           GREEN(i,j)=GREEN(i,j)+((2^t)*g(t+1));
           BLUE(i,j)=BLUE(i,j)+((2^t)*b(t+1));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%% CONVERT PIXELS FROM double to uint8 %%%%%%%%%%%%%%%%%%%%%%
RED=uint8(RED);
GREEN=uint8(GREEN);
BLUE=uint8(BLUE);
%%%%%%%%%%%%%%%%%% JOIN ALL THREE CHANNELS TO GET FINAL ONE %%%%%%%%%%%%%%%%%%%%
I = cat(3, RED, GREEN, BLUE);
%%%%%%%%%%%%%%%%%%%%%%%%% WRITE FINAL IMAGE TO A FILE %%%%%%%%%%%%%%%%%%%%%%%%%%
imwrite(I, F);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%