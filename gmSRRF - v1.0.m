% gmSRRF - v1.0
clear
[readtitle,readpath] = uigetfile('*.tif');
imInfo = imfinfo([readpath,readtitle]);
Width = imInfo.Width;
Height = imInfo.Height; 
Size = size(imInfo,1);
Io = zeros(Height,Width,Size);
for i=1:Size
    Io(:,:,i) =imread([readpath,readtitle],i); % read grayscale stack
    Io(:,:,i) = Io(:,:,i) - min(min(Io(:,:,i)));
end

 % interpolation
mag = 2 ;
Io = imresize(Io,mag,'bicubic');  
[Height,Width,Size] = size(Io);

% variance analysis
[Gx,Gy] = gradient(Io);
Gy_ave = sum(Gy,3)/Size;    Gy_var = Varience(Gy,Gy_ave);
Gx_ave = sum(Gx,3)/Size;    Gx_var = Varience(Gx,Gx_ave);
Gr_var = Gx_var + Gy_var;

Io_ave = sum(Io,3)/Size;
Io_var = Varience(Io, Io_ave);

% thresholding
th = getThreshold(1,Io_var,0.1);
I = Reweighting(Io, Io_var, Gr_var,th);
[savetitle,savepath] = uiputfile('*.tif');
I = uint16(I);
imwrite(I(:,:,1),[savepath,savetitle]);
for s=2:Size
    imwrite(I(:,:,s),[savepath,savetitle],'WriteMode','append');
end





