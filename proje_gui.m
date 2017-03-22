function varargout = proje_gui(varargin)
% PROJE_GUI MATLAB code for proje_gui.fig
%      PROJE_GUI, by itself, creates a new PROJE_GUI or raises the existing
%      singleton*.
%
%      H = PROJE_GUI returns the handle to a new PROJE_GUI or the handle to
%      the existing singleton*.
%
%      PROJE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJE_GUI.M with the given input arguments.
%
%      PROJE_GUI('Property','Value',...) creates a new PROJE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proje_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proje_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proje_gui

% Last Modified by GUIDE v2.5 19-Jan-2017 14:44:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proje_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @proje_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before proje_gui is made visible.
function proje_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proje_gui (see VARARGIN)

% Choose default command line output for proje_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proje_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proje_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
axes(handles.axes2);

%I = imread('dsp (5).jpg');
[filename pathname] = uigetfile({'*.jpg'},'File Selector');
ab = strcat(pathname, filename)
set(handles.edit2, 'string', ab);
I = imread(filename);
I = mat2gray(I);
im(:,:,1)=I;
im(:,:,2)=I;
im(:,:,3)=I;
imshow(im);

SE1 = strel('square',3);
I2 = imdilate(im,SE1);

[l, Am, C] = slic(I2, 10, 10, 1, 'mean');
axes(handles.axes3);
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
%imtool(Label);
%Extracting the components
Im=zeros([size(A,1) size(A,2)]);
ele=find(Label==23);
Im(ele)=1;

%Extracting the characters 'I M A G E'
ele=find(Label==2|Label==3|Label==6|Label==7|Label==9);
Im1=zeros([size(A,1) size(A,2)]);
Im1(ele)=1;
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

axes(handles.axes4);
imshow(RGBIm);

s=unique(Label);
out=[s, histc(Label(:),s)];
disp(out);


[m,n]=size(out);


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

axes(handles.axes5);
imshow(image);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
