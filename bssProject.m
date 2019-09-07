
function varargout = bssProject(varargin)
% BSSPROJECT MATLAB code for bssProject.fig
%      BSSPROJECT, by itself, creates a new BSSPROJECT or raises the existing
%      singleton*.
%
%      H = BSSPROJECT returns the handle to a new BSSPROJECT or the handle to
%      the existing singleton*.
%
%      BSSPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BSSPROJECT.M with the given input arguments.
%
%      BSSPROJECT('Property','Value',...) creates a new BSSPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bssProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bssProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bssProject

% Last Modified by GUIDE v2.5 29-Aug-2019 22:50:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bssProject_OpeningFcn, ...
                   'gui_OutputFcn',  @bssProject_OutputFcn, ...
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

% --- Executes just before bssProject is made visible.
function bssProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bssProject (see VARARGIN)

% Choose default command line output for bssProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bssProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bssProject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function View_Callback(hObject, eventdata, handles)
% hObject    handle to View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
[file,path] = uigetfile('*.csv');
%if isequal(file,0)
%   disp('User selected Cancel');
%else
%   disp(['User selected ', fullfile(path,file)]);
%end
global firstHigh secondHigh firstLow secondLow age;
CSVData = csvread(file)
firstRow = CSVData(1,1:4)
pressureData = CSVData(2:end, 1:4)
age = CSVData(2:end, 5)
firstHigh = CSVData(2:end, 1)
firstLow = CSVData(2:end, 2)
secondHigh = CSVData(2:end, 3)
secondLow = CSVData(2:end, 4)
avgFirstHigh = mean(firstHigh)
avgSecondHigh = mean(secondHigh)
avgFirstLow = mean(firstLow)
avgSecondLow = mean(secondLow)
avg = mean(age);
humidity1 = CSVData(1, 5);
humidity2 = CSVData(1, 6);
set(handles.text5, 'String', firstRow(1));
set(handles.text6, 'String', firstRow(3));
set(handles.text9, 'String', firstRow(2));
set(handles.text10, 'String', firstRow(4));
set(handles.text15, 'String', strcat(strcat(num2str(avgFirstHigh),'/'),num2str(avgFirstLow)));
set(handles.text16, 'String', strcat(strcat(num2str(avgSecondHigh),'/'),num2str(avgSecondLow)));
set(handles.text19, 'String', num2str(avg));
set(handles.text24, 'String', strcat(num2str(humidity1), '%'));
set(handles.text25, 'String', strcat(num2str(humidity2), '%'));

%set(handles.editMaxRPM, 'Double', maxRPM);
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Pressure_dif_Callback(hObject, eventdata, handles)
global firstHigh secondHigh firstLow secondLow age;
resultHigh = firstHigh - secondHigh,
resultLow = firstLow - secondLow,
A = resultHigh;
B= unique(A);
subplot(2, 2, 3);
C = categorical(A,B,cellstr(num2str(B)));
histogram(C);
title('Razlike u gornjem pritisku');
xlabel('Razlika pritisaka')
ylabel('Broj ispitanika');
subplot(2, 2, 4);
D = resultLow;
E= unique(D),
F = categorical(D,E,cellstr(num2str(E)));
histogram(F);
title('Razlike u donjem pritisku');
xlabel('Razlika pritisaka')
ylabel('Broj ispitanika');


%h = histogram(resultHigh)

% hObject    handle to Pressure_dif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function meanbyage_Callback(hObject, eventdata, handles)
global firstHigh secondHigh firstLow secondLow age;

Mean1 = grpstats(firstHigh', age', {'mean'});
subplot(3,2,3)
bar( unique(age),Mean1)
title('Gornji pritisak prvog mjerenja(avg)');
xlabel('Godine')
ylabel('Pritisak');
unAge = unique(age)
for i=1:size(unique(age))
    text(unAge(i),Mean1(i),num2str(Mean1(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
ylim([0 200])

Mean2 = grpstats(firstLow', age', {'mean'});
subplot(3,2,4)
bar( unique(age),Mean2)
title('Donji pritisak prvog mjerenja(avg)');
xlabel('Godine')
ylabel('Pritisak');
unAge = unique(age)
for i=1:size(unique(age))
    text(unAge(i),Mean2(i),num2str(Mean2(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
ylim([0 200])

Mean3 = grpstats(secondHigh', age', {'mean'});
subplot(3,2,5)
bar( unique(age),Mean3)
title('Gornji pritisak drugog mjerenja(avg)');
xlabel('Godine')
ylabel('Pritisak');
unAge = unique(age)
for i=1:size(unique(age))
    text(unAge(i),Mean3(i),num2str(Mean3(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
ylim([0 200])

Mean4 = grpstats(secondLow', age', {'mean'});
subplot(3,2,6)
bar( unique(age),Mean4)
title('Donji pritisak drugog mjerenja(avg)');
xlabel('Godine')
ylabel('Pritisak');
unAge = unique(age)
for i=1:size(unique(age))
    text(unAge(i),Mean4(i),num2str(Mean4(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
ylim([0 200])


%text([min(age):max(age)], Mean1', num2str(Mean1'),'HorizontalAlignment','center','VerticalAlignment','bottom')

% hObject    handle to meanbyage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MDBA_Callback(hObject, eventdata, handles)
global firstHigh secondHigh firstLow secondLow age;

Mean1 = grpstats((firstHigh-secondHigh)', age', {'mean'});
subplot(2,2,3)
bar( unique(age),Mean1)
title('Razlika prosjecnog gornjeg pritiska po godinama');
xlabel('Godine')
ylabel('Razlika pritiska');
unAge = unique(age)
for i=1:size(unique(age))
    if Mean1(i) >= 0 
    text(unAge(i),Mean1(i),num2str(Mean1(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
    else
        text(unAge(i),Mean1(i),num2str(Mean1(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','top')
    end
end
ylim([-10 10])

Mean2 = grpstats((firstLow-secondLow)', age', {'mean'});
subplot(2,2,4)
bar( unique(age),Mean2)
title('Razlika prosjecnog donjeg pritiska po godinama');
xlabel('Godine')
ylabel('Razlika pritiska');
unAge = unique(age)
for i=1:size(unique(age))
    if Mean2(i) >= 0
        text(unAge(i),Mean2(i),num2str(Mean2(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
     else
        text(unAge(i),Mean2(i),num2str(Mean2(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','top')
    end
end
ylim([-10 10])
% hObject    handle to MDBA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pmt_Callback(hObject, eventdata, handles)
global firstHigh secondHigh firstLow secondLow age;
subplot(3,2,3)
histogram(firstHigh);
title('Rezultati gornjeg pritiska prvog mjerenja');
xlabel('Rezultat mjerenja')
ylabel('Broj ispitanika');
subplot(3,2,4)
histogram(secondHigh);
title('Rezultati gornjeg pritiska drugog mjerenja');
xlabel('Rezultat mjerenja')
ylabel('Broj ispitanika');
subplot(3,2,5)
histogram(firstLow);
title('Rezultati donjeg pritiska prvog mjerenja');
xlabel('Rezultat mjerenja')
ylabel('Broj ispitanika');
subplot(3,2,6)
histogram(secondLow);
title('Rezultati donjeg pritiska drugog mjerenja');
xlabel('Rezultat mjerenja')
ylabel('Broj ispitanika');
% hObject    handle to pmt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function apbd_Callback(hObject, eventdata, handles)
global firstHigh secondHigh firstLow secondLow age;

Mean1 = mean(firstHigh)
Mean2 = mean(secondHigh)
values = {'Dan 1', 'Dan 2'}
MeanArray = [Mean1, Mean2]
subplot(2,2,3)
bar(categorical( values), MeanArray)
title('Prosjecan gornji pritisak po danima');
for i=1:2
text(i, MeanArray(i),num2str(MeanArray(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
ylim([0 150])

Mean3 = mean(firstLow)
Mean4 = mean(secondLow)
values2 = {'Dan 1', 'Dan 2'}
MeanArray2 = [Mean3, Mean4]
subplot(2,2,4)
bar(categorical( values2), MeanArray2);
title('Prosjecan donji pritisak po danima');
for i=1:2
text(i, MeanArray2(i),num2str(MeanArray2(i),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
ylim([0 110])
% hObject    handle to apbd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pba_Callback(hObject, eventdata, handles)
global firstHigh secondHigh firstLow secondLow age;
subplot(3,2,3)
plot(age, firstHigh, '.');
title('Rezultati prvog mjerenja gornjeg pritiska po godinama');
xlabel('Godine')
ylabel('Rezultat mjerenja');
xlim([15, 45])
ylim([70, 160])

subplot(3,2,4)
plot(age, secondHigh, '.');
title('Rezultati drugog mjerenja gornjeg pritiska po godinama');
xlabel('Godine')
ylabel('Rezultat mjerenja');
xlim([15, 45])
ylim([70, 160])

subplot(3,2,5)
plot(age, firstLow, '.');
title('Rezultati prvog mjerenja donjeg pritiska po godinama');
xlabel('Godine')
ylabel('Rezultat mjerenja');
xlim([15, 45])
ylim([40, 110])

subplot(3,2,6)
plot(age, secondLow, '.');
title('Rezultati drugog mjerenja donjeg pritiska po godinama');
xlabel('Godine')
ylabel('Rezultat mjerenja');
xlim([15, 45])
ylim([40, 110])
% hObject    handle to pba (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
