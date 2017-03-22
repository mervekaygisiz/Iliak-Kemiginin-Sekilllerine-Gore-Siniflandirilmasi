clear all;
close all;
%a = load('(5).mat');
%a = struct2array(a);
userpath('/Users/merveezgikaygisiz/Documents/MATLAB/segmentation')
%a = imread('dsp (7).jpg');

%figure(10)

%imshow(a,[]);

I = imread('dsp (5).jpg');

I = mat2gray(I);
im(:,:,1)=I;
im(:,:,2)=I;
im(:,:,3)=I;
imshow(im);figure();

%Ib = im2bw(im,0.2);
%imshow(Ib);figure();


SE1 = strel('square',3);
I2 = imdilate(im,SE1);
imshow(I2);figure();


%a = mat2gray(a);


figure(363737);
imshow(im);

[l, Am, C] = slic(I2, 10, 10, 1, 'mean');
%disp(l); slic parcalarinin labellari
figure()
imshow(drawregionboundaries(l, I2, [255 255 255]))



BW=im2bw(I2); %binary formata ceviriyor
I=BW;

%Structuring element
B=strel('square',3);
A=I;
%Find a non-zero element's position.
p=find(A==1);
p=p(1);
Label=zeros([size(A,1) size(A,2)]);
N=0;
while(~isempty(p))
    N=N+1;%Label for each component
    p=p(1);
X=false([size(A,1) size(A,2)]);
X(p)=1;
Y=A&imdilate(X,B);
while(~isequal(X,Y))
    X=Y;
    Y=A&imdilate(X,B);
end
Pos=find(Y==1);
A(Pos)=0;
%Label the components
Label(Pos)=N;
p=find(A==1);
end
imtool(Label);
%Extracting the components
Im=zeros([size(A,1) size(A,2)]);
ele=find(Label==23);
Im(ele)=1;
figure,imshow(Im);title('Label:1');
%Extracting the characters 'I M A G E'
ele=find(Label==2|Label==3|Label==6|Label==7|Label==9);
Im1=zeros([size(A,1) size(A,2)]);
Im1(ele)=1;
figure,imshow(Im1);title('Specific components');
%Differentiate each component with a specific color
RGBIm=zeros([size(Label,1) size(Label,2) 3]);
R=zeros([size(Label,1) size(Label,2)]);
G=zeros([size(Label,1) size(Label,2)]);
B=zeros([size(Label,1) size(Label,2)]);
U=64;
V=255;
W=128;
for i=1:N
    Pos=find(Label==i);
    R(Pos)=mod(i,2)*V;
    G(Pos)=mod(i,5)*U;
    B(Pos)=mod(i,3)*W;
   
   
 end
RGBIm(:,:,1)=R;
RGBIm(:,:,2)=G;
RGBIm(:,:,3)=B;
RGBIm=uint8(RGBIm);
figure,imshow(RGBIm);title('Labelled Components');



s=unique(Label);
out=[s, histc(Label(:),s)];
disp(out);


%out=sort(out);
%disp(out);
[m,n]=size(out);

%disp(out(m-1,2));

%[m,n]=size(l)

[values, order] = sort(out(:,2));
sortedmatrix = out(order,:)
disp(sortedmatrix);

disp(sortedmatrix(m-1,1));
la=sortedmatrix(m-1,1); %ilgili kemik labeli tutuyor


[as,sa]=size(Label)
image=im;
for i=1:as
    for j=1:sa
        if Label(i,j) ~= la
            %Label(i,j)=1
            image(i,j,1)=0;
            image(i,j,2)=0;
            image(i,j,3)=0;
        end
           
    end
end


figure(333),imshow(image);
imwrite(image, 'ali.jpg');
I='ali.jpg';
%roi = [1;101;1;101];bin=8;angle=360;L=3;
%p = anna_phog(I,bin,angle,L,roi);


