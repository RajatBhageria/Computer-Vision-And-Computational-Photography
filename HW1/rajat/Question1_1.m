I = [0.5, 2.0, 1.5; 0.5, 1.0, 0.0; 2.0, 0.5, 1.0];
f = [0.5, 1.0, 0.0; 0.0, 1.0, 0.5; 0.5, 0.0, 0.5];

%% I filtered with f;
same = filter2(I,f,'same');

%% f filtered with I;
