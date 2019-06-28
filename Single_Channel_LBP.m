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
    I = im2double(rgb2gray(I));
%%%%%%%%%%%%%%%%%%%%%%%% GET THE SIZE OF IMAGE CHANNEL %%%%%%%%%%%%%%%%%%%%%%%%
    [m,n] = size(I); 
%%%%%%%%%%%%%%%%%%%%%% CREATE ZERO ARRAY OF SIZE [8 x 1] %%%%%%%%%%%%%%%%%%%%%
    g = zeros(8,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%% CREATE 2D ARRAY OF ZERO %%%%%%%%%%%%%%%%%%%%%%%%%%
    GRAY = zeros(m,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LBP CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=2:m-1
    for j=2:n-1        
        t=1;
        for k=-1:1
            for l=-1:1                
                if (k~=0)||(l~=0)
%%%%%%%%%%%%%%%%%%%%%%%%%% THRESHOLD TO GENERATE BIT %%%%%%%%%%%%%%%%%%%%%%%%%%
                if (G(i+k,j+l)-G(i,j)<0)
                    g(t)=0;
                else
                    g(t)=1;
                end
                t=t+1;
                end
            end
        end  
        for t=0:7
%%%%%%%%%%%%%%%%%%%%%%%% BINARY TO DECIMAL CONVERSION %%%%%%%%%%%%%%%%%%%%%%%%%%
           GRAY(i,j)=GRAY(i,j)+((2^t)*g(t+1));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%% CONVERT PIXELS FROM double to uint8 %%%%%%%%%%%%%%%%%%%%%%
GRAY = uint8(GRAY);
%%%%%%%%%%%%%%%%%%%%%%%%% WRITE FINAL IMAGE TO A FILE %%%%%%%%%%%%%%%%%%%%%%%%%%
imwrite(I, F);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%