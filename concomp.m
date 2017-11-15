%% Connected Components Labelling 

%ALGORITHM
% Let Y represents a connected component contained in A and the point p of the Y is known.
%The following procedure iteratively finds all the elements of Y:   
%   1) Start from a known point p and taking X0= p,
%   2) Then taking the next values of Xk as: 
%        Xk  = (Xk-1 Dialation B) intersection A
%   3) B is a suitable structuring element B=ones(3,3)  
%   4) Algorithm converges if Xk = Xk-1  
%   5) The component Y is given as Y = X


clc
close all
clear all

%load input image
input = imread('input.bmp');

subplot(1,2,1)
imshow(input)
title('Input Image')

intermediateMatrix=zeros(size(input));

%matrix to store connected components labels
labelledImage=zeros(size(input));

%the structuring element
SE = ones(3,3);

%size of input image
[r c] = size(input);

%number of connnected componenets
labels=0;

fprintf('Processing Image ... \n')


%iterate over image
for i=1:r
    for j=1:c
        
        %detect non zero pixel
        if input(i,j)==1
            
            %Start from a known point p and set it to 1,
            intermediateMatrix(i,j)=1;
            
            xk1=intermediateMatrix;
            xk2=zeros(size(input));
            flag = 0;
            
            % Xk  = (Xk-1 Dialation B) intersection A
            while sum(sum(xk1 ~= xk2))
                
                if flag==1
                    xk1=xk2;
                end
                
                xk2=imdilate(xk1,SE).*input;
                
                flag = 1;
            end
            
            labels=labels+1;
            labelledImage(xk2==1)=labels;
            input=input.* (~xk2);
            
        end
    end
end 

%print total connected componets detected 
fprintf('Total connected components detected: %x \n', labels)

%color code the connected components 
colorCodedImage = label2rgb(labelledImage);
subplot(1,2,2)
imshow(colorCodedImage)
title('Connected Components Labelled')




