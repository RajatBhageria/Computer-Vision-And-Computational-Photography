function coeffA = getCoefficientMatrix(indexes)
%% Enter Your Code Here
maxIndex = size(find((indexes > 0)==1),1); %number of replacement pixels 

coeffA = speye(maxIndex,maxIndex);

%make all the items along diagonal = 4 
coeffA = 4*coeffA;

[n,m] = size(indexes); 

for row=1:n
    for col = 1:m
        %get the index of the pixel in the current row and co
        index = indexes(row,col); 
        %make sure that the index of the pixel is not one (i.e., not in
        %omega)
        if (index ~=0)   
            %check the left pixel
            if (row -1 > 0)
                %get the left index 
                leftIndex = indexes(row-1,col); 
                %make sure the left index is not edge
                if leftIndex >0
                    coeffA(index,leftIndex)=-1;
                end 
            end

            %check the right pixel
            if (row +1 <= n)
                %get the right index 
                rightIndex = indexes(row+1,col); 
                %make sure the right index is not edge
                if rightIndex >0
                    coeffA(index,rightIndex)=-1;
                end 
            end
            
            %check the pixel above 
            if (col-1 > 0)
                %get the up index 
                upIndex = indexes(row,col-1); 
                %make sure the up index is not edge
                if upIndex >0
                    coeffA(index,upIndex)=-1;
                end 
            end    

            %check the pixel below 
            if (col +1 <= n)
                %get the down index 
                downIndex = indexes(row,col+1); 
                %make sure the down index is not edge
                if downIndex >0
                    coeffA(index,downIndex)=-1;
                end 
            end 
        end 
    end 
end 

end