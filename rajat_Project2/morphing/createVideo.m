function [] = createVideo(morphed_im)

h_avi = VideoWriter('FinalVideo2.avi', 'Uncompressed AVI');
h_avi.FrameRate = 10;
h_avi.open();

for i = 1:size(morphed_im,1)
    morphed_im{i} = imresize(morphed_im{i}, [796 800]);
    writeVideo(h_avi,uint8(morphed_im{i}))
end 

close(h_avi);

end

