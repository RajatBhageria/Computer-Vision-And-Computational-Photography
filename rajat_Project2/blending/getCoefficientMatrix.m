function coeffA = getCoefficientMatrix(indexes)
%% Enter Your Code Here
n = size(find((indexes > 0)==1),1); %number of replacement pixels 

coeffA = eye(n,n);

%make all the items along diagonal = 4 
coeffA = 4*coeffA;

for index=1:n;
    
    %calculate all the linear indexes of the pixels right next to index 
    %left and right 
    leftIndex = index-1; 
    rightIndex = index+1;
    
    try
        %find the row and col of index 
        [row,col] = find(indexes == index);
    catch 
        row = -1; 
        col = -1; 
    end

    %find the up and down indexes 
    try
        %find up index
        upIndex = indexes(row-1,col);
    catch 
        upIndex = 0; 
    end
    
    try
        %find dowm index
        downIndex = indexes(row+1,col); 
    catch 
        downIndex = 0; 
    end 
 
    %assign -1s to the left, right, up and down indexes
    if (leftIndex > 0 && leftIndex <= n)
        coeffA(index,leftIndex) = -1;
    end
    if (rightIndex > 0 && rightIndex <= n)
        coeffA(index,rightIndex) = -1;
    end
    if (upIndex > 0 && upIndex<n)
        coeffA(index,upIndex) = -1;
    end
    if (downIndex > 0 && downIndex <n)
        coeffA(index,downIndex) = -1;
    end
    
end
    
end