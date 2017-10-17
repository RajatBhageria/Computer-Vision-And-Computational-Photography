function indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY)
%% Enter Your Code Here
    resizedImage = imresize(mask, [targetH targetW]);
    figure;imshow(resizedImage);    
    %add the x offset 
    translatedImage = imtranslate(resizedImage, [offsetX, offsetY]);
    figure;imshow(translatedImage);
    %index
    [n,m] = size(translatedImage); 
    indexes = zeros(n,m); 
    counter = 1; 
    for row = 1:n
        for col = 1:m 
            if(translatedImage(1:n,1:m)) %if there's a one 
                indexes(row,col) = counter;
                counter = counter + 1; 
            end
        end
    end
     
end