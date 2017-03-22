clear all;
close all;

% userpath('C:\Users\Aysun\Desktop\Deep_dataset\data'); 
filenames = dir('/Users/merveezgikaygisiz/Documents/MATLAB/segmentation/mat'); %# get information of all .png files in work dir

n  = numel(filenames);    %# number of .png files
disp(n);
roi = [1;96;1;131];bin=8;angle=360;L=3;

for i = 1:n
    userpath('/Users/merveezgikaygisiz/Documents/MATLAB/segmentation');
    I = load( filenames(i).name );
    disp(I);
    % I = struct2array(I);
   % p(i,:) = anna_phog(I,bin,angle,L,roi);
    %figure(),imshow(p);
end



