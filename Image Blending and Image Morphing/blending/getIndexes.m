function indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY)
%% Enter Your Code Here
    %resizedImage = imresize(mask, [targetH targetW]);
    %add the x and y offset 
    %translatedImage = imtranslate(resizedImage, [offsetX, offsetY]);
    %index
    resizedImage = zeros(targetH, targetW); 
    [p,q] = size(mask); 
    resizedImage(offsetY:offsetY + p-1, offsetX:offsetX + q-1) = mask; 
    [n,m] = size(resizedImage); 
    indexes = zeros(n,m); 
    counter = 1; 
    for row = offsetY:n
        for col = offsetX:m 
            if(resizedImage(row,col)) %if there's a one 
                indexes(row,col) = counter;
                counter = counter + 1; 
            end
        end
    end
     
end