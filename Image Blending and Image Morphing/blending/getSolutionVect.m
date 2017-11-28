function solVectorb = getSolutionVect(indexes, source, target, offsetX, offsetY)
    
    %take the laplacian of the source image with no padding. 
    laplacian = [0 -1 0; -1 4 -1; 0 -1 0];
    convolved = conv2(source,laplacian, 'same'); 

    [n,m] = size(indexes); 

    %create an empty b vector the size of the maximum index in the indexes
    %matrix 
    replacementPixels = size(find((indexes > 0)==1),1); %number of replacement pixels 
    solVectorb = zeros(replacementPixels,1); 

    for row = 1:n
        for col = 1:m-1 
            index = indexes(row,col); 
            %make sure that we're only taking convolution values for indexes >0
            %i.e., they are within omega mask. 
            if (index ~=0) 
                %get the convolved value of pixel row, col in the source image
                if (row-offsetY > 0 && col-offsetX > 0)
                    convolvedVal = convolved(row-offsetY, col-offsetX); %remember that along rows you you're going along y! 
                    bVal = convolvedVal;
                end
                %find all the boundaries on the target image 
                %check the left pixel
                if (row -1 > 0 && indexes(row-1,col)==0)
                    boundary = target(row-1,col);
                    bVal = bVal + boundary;
                end

                %check the right pixel
                if (row +1 <= n && indexes(row+1,col)==0)
                    boundary = target(row+1,col);
                    bVal = bVal + boundary;
                end 

                %check the pixel above 
                if (col-1 > 0 && indexes(row,col-1)==0)
                    boundary = target(row,col-1);
                    bVal = bVal + boundary;
                end    

                %check the pixel below 
                if (col+1 <= m && indexes(row,col+1)==0)
                    boundary = target(row,col+1);
                    bVal = bVal + boundary;
                end    

                solVectorb(index,1) = bVal; 

            end 
        end 
    end 
end
