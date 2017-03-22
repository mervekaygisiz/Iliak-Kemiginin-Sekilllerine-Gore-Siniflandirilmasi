clear all;
close all;

userpath('/Users/merveezgikaygisiz/Documents/MATLAB/segmentation')

 filenames = dir('/Users/merveezgikaygisiz/Documents/MATLAB/segmentation/*.jpg'); %# get information of all .png files in work dir
 %filenames2=struct2array(filenames);
 n  = numel(filenames);    %# number of .png files

roi = [1;101;1;101];bin=8;angle=360;L=3;

% 
 for i = 1:n
   % userpath('/Users/merveezgikaygisiz/Documents/MATLAB/segmentation');
     I = filenames(i).name; %file ismini al?yor
%I = imread('dsp (1).jpg' );
   % figure(),imshow(I);
    disp(I);
    %I = struct2array(I);

    p(:,i) = anna_phog(I,bin,angle,L,roi);
    %figure(),imshow(p);
 end

