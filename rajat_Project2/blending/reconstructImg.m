function resultImg = reconstructImg(indexes, red, green, blue, targetImg)
%% Enter Your Code Here
    [n,m] = size(indexes); 
    
    %instantiate an empty nxmx3 matrix for the result image 
    resultImg = targetImg;
    
    %loop over all the pixels in the indexes
    for row = 1:n
        for col = 1:m
            %find the value of the index 
            index = indexes(row,col); 
            %see if the value of the index > 0, i.e., it's in our omega and
            %we want to copy the intensities over to the source image 
            if (index>0)
                %find the intensity values of the red, green, and blue
                %pixels of the source image 
                redChannel = red(index,1); 
                greenChannel = green(index,1); 
                blueChannel = blue(index,1); 
        
                %replace the target image intensities for the respective
                %chanel. 
                resultImg(row,col,1) = redChannel; 
                resultImg(row,col,2) = greenChannel; 
                resultImg(row,col,3) = blueChannel; 
            end
        end 
    end 


end