function [] = createVideo(I, TI, order)    
    [n,m] = size (order);
    
    %find the toal number of pixels that were removed 
    numberPixelsRemoved = n+m;
    
    %counter variables 
    row = n; 
    col = m; 

    %create the order of which the images were removed 
    output = cell(numberPixelsRemoved,1); 

    %retrieve the order of the images from which they were removed 
    for num = numberPixelsRemoved:-1:1
        nextImg = [];
        if (row > 0 && col > 0) 
            if order(row,col) == 1
                %removed a vert pixel! 
                nextImg = TI{row,col};
                row = row - 1; 
            elseif order(row,col) == 0
                %remoed a horz pixel!
                nextImg = TI{row,col};
                col = col - 1; 
            end
            output{num,1} = nextImg;
        end
    end 
    
    %create the gif output 
    filename = 'finalVideo.gif';
    [imind1,cm1] = rgb2ind(I,256);
    imwrite(imind1,cm1,filename,'gif', 'Loopcount',inf);
    for n = 2:size(output,1)
        im = output{n,1};
        [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end

