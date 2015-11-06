function varargout = data_lib(varargin)
%function varargout = data_lib(nr,refractionData,d,L,p,varargin)
% DATA_LIB M-file for data_lib.fig
%      DATA_LIB, by itself, creates a new DATA_LIB or raises the existing
%      singleton*.
%
%      H = DATA_LIB returns the handle to a new DATA_LIB or the handle to
%      the existing singleton*.
%
%      DATA_LIB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATA_LIB.M with the given input arguments.
%
%      DATA_LIB('Property','Value',...) creates a new DATA_LIB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before data_lib_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to data_lib_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help data_lib

% Last Modified by GUIDE v2.5 08-Mar-2010 12:53:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @data_lib_OpeningFcn, ...
                   'gui_OutputFcn',  @data_lib_OutputFcn, ...
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


% --- Executes just before data_lib is made visible.
function data_lib_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to data_lib (see VARARGIN)
global refractionData;
global nr;
global d;
global L;
global p;
global name;

% Choose default command line output for data_lib
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


set(handles.bg_tri,'Value',1);
set(handles.singlelayer_text,'Visible','off');
set(handles.singlelayer_dmax,'Visible','off');
set(handles.singlelayer_dmin,'Visible','off');
set(handles.singlelayer_step,'Visible','off');
set(handles.singlelayer_load,'Visible','off');
set(handles.singlelayer_spec,'Visible','off');

set(handles.layer1_text,'Visible','off');
set(handles.layer1_dmax,'Visible','off');
set(handles.layer1_dmin,'Visible','off');
set(handles.layer1_step,'Visible','off');
set(handles.layer1_load,'Visible','off');
set(handles.layer1_spec,'Visible','off');

set(handles.layer2_text,'Visible','off');
set(handles.layer2_dmax,'Visible','off');
set(handles.layer2_dmin,'Visible','off');
set(handles.layer2_step,'Visible','off');
set(handles.layer2_load,'Visible','off');
set(handles.layer2_spec,'Visible','off');

set(handles.tri_layer1_text,'Visible','on');
set(handles.tri_layer1_dmax,'Visible','on');
set(handles.tri_layer1_dmin,'Visible','on');
set(handles.tri_layer1_step,'Visible','on');
set(handles.tri_layer1_load,'Visible','on');
set(handles.tri_layer1_spec,'Visible','on');

set(handles.tri_layer2_text,'Visible','on');
set(handles.tri_layer2_dmax,'Visible','on');
set(handles.tri_layer2_dmin,'Visible','on');
set(handles.tri_layer2_step,'Visible','on');
set(handles.tri_layer2_load,'Visible','on');
set(handles.tri_layer2_spec,'Visible','on');

set(handles.tri_layer3_text,'Visible','on');
set(handles.tri_layer3_dmax,'Visible','on');
set(handles.tri_layer3_dmin,'Visible','on');
set(handles.tri_layer3_step,'Visible','on');
set(handles.tri_layer3_load,'Visible','on');
set(handles.tri_layer3_spec,'Visible','on');
% UIWAIT makes data_lib wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = data_lib_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function singlelayer_dmin_Callback(hObject, eventdata, handles)
% hObject    handle to singlelayer_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of singlelayer_dmin as text
%        str2double(get(hObject,'String')) returns contents of singlelayer_dmin as a double


% --- Executes during object creation, after setting all properties.
function singlelayer_dmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singlelayer_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function singlelayer_step_Callback(hObject, eventdata, handles)
% hObject    handle to singlelayer_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of singlelayer_step as text
%        str2double(get(hObject,'String')) returns contents of singlelayer_step as a double


% --- Executes during object creation, after setting all properties.
function singlelayer_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singlelayer_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer1_dmax_Callback(hObject, eventdata, handles)
% hObject    handle to layer1_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer1_dmax as text
%        str2double(get(hObject,'String')) returns contents of layer1_dmax as a double


% --- Executes during object creation, after setting all properties.
function layer1_dmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer1_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer1_dmin_Callback(hObject, eventdata, handles)
% hObject    handle to layer1_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer1_dmin as text
%        str2double(get(hObject,'String')) returns contents of layer1_dmin as a double


% --- Executes during object creation, after setting all properties.
function layer1_dmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer1_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function singlelayer_dmax_Callback(hObject, eventdata, handles)
% hObject    handle to singlelayer_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of singlelayer_dmax as text
%        str2double(get(hObject,'String')) returns contents of singlelayer_dmax as a double


% --- Executes during object creation, after setting all properties.
function singlelayer_dmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singlelayer_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer1_step_Callback(hObject, eventdata, handles)
% hObject    handle to layer1_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer1_step as text
%        str2double(get(hObject,'String')) returns contents of layer1_step as a double


% --- Executes during object creation, after setting all properties.
function layer1_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer1_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer2_dmax_Callback(hObject, eventdata, handles)
% hObject    handle to layer2_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer2_dmax as text
%        str2double(get(hObject,'String')) returns contents of layer2_dmax as a double


% --- Executes during object creation, after setting all properties.
function layer2_dmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer2_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer2_dmin_Callback(hObject, eventdata, handles)
% hObject    handle to layer2_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer2_dmin as text
%        str2double(get(hObject,'String')) returns contents of layer2_dmin as a double


% --- Executes during object creation, after setting all properties.
function layer2_dmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer2_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer2_step_Callback(hObject, eventdata, handles)
% hObject    handle to layer2_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer2_step as text
%        str2double(get(hObject,'String')) returns contents of layer2_step as a double


% --- Executes during object creation, after setting all properties.
function layer2_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer2_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function singlelayer_dl_Callback(hObject, eventdata, handles)
% hObject    handle to singlelayer_dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of singlelayer_dl as text
%        str2double(get(hObject,'String')) returns contents of singlelayer_dl as a double


% --- Executes during object creation, after setting all properties.
function singlelayer_dl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singlelayer_dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer1_dl_Callback(hObject, eventdata, handles)
% hObject    handle to layer1_dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer1_dl as text
%        str2double(get(hObject,'String')) returns contents of layer1_dl as a double


% --- Executes during object creation, after setting all properties.
function layer1_dl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer1_dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function layer2_dl_Callback(hObject, eventdata, handles)
% hObject    handle to layer2_dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer2_dl as text
%        str2double(get(hObject,'String')) returns contents of layer2_dl as a double


% --- Executes during object creation, after setting all properties.
function layer2_dl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer2_dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in c_data.
function c_data_Callback(hObject, eventdata, handles)
% hObject    handle to c_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global refractionData;
global nr;
global d;
global L;
global p;
global name;
global dir_name;

load('datalib.mat', 'nr', 'name', 'refractionData', 'd', 'L', 'p');
al_nr = get_absorber_layer_nr(name);

    single_dmin = str2num(get(handles.singlelayer_dmin,'String'));
    single_dmax = str2num(get(handles.singlelayer_dmax,'String'));
    single_step = str2num(get(handles.singlelayer_step,'String'));
    single_spec = get(handles.singlelayer_spec,'String');

    layer1_dmin = str2num(get(handles.layer1_dmin,'String'));
    layer1_dmax = str2num(get(handles.layer1_dmax,'String'));
    layer1_step = str2num(get(handles.layer1_step,'String'));
    layer1_spec = get(handles.layer1_spec,'String');
    layer2_dmin = str2num(get(handles.layer2_dmin,'String'));
    layer2_dmax = str2num(get(handles.layer2_dmax,'String'));
    layer2_step = str2num(get(handles.layer2_step,'String'));
    layer2_spec = get(handles.layer2_spec,'String');
    
    tri_layer1_dmin = str2num(get(handles.tri_layer1_dmin,'String'));
    tri_layer1_dmax = str2num(get(handles.tri_layer1_dmax,'String'));
    tri_layer1_step = str2num(get(handles.tri_layer1_step,'String'));
    tri_layer1_spec = get(handles.tri_layer1_spec,'String');
    tri_layer2_dmin = str2num(get(handles.tri_layer2_dmin,'String'));
    tri_layer2_dmax = str2num(get(handles.tri_layer2_dmax,'String'));
    tri_layer2_step = str2num(get(handles.tri_layer2_step,'String'));
    tri_layer2_spec = get(handles.tri_layer2_spec,'String');
    tri_layer3_dmin = str2num(get(handles.tri_layer3_dmin,'String'));
    tri_layer3_dmax = str2num(get(handles.tri_layer3_dmax,'String'));
    tri_layer3_step = str2num(get(handles.tri_layer3_step,'String'));
    tri_layer3_spec = get(handles.tri_layer3_spec,'String');
    
if(get(handles.bg_single,'Value') == 1)
    
    if(~ isempty(single_spec))

        fn = load(single_spec);
        refractionData(:,(al_nr(1)*2-1)) = fn(:,1); refractionData(:,(al_nr(1)*2)) = fn(:,2);
        name{al_nr(1)} = regexprep(single_spec, '.txt', '');
        
        save('matvalgui.txt', 'refractionData', '-ASCII')
        
        for m = single_dmin : single_step : single_dmax
            d(al_nr(1)) = m*1e-9;
            eval(['save layernames.mat name d L p dir_name al_nr']);
            OpticsCalcegalwas(d);
            IscQEegalwas(L,p);
            load Currentsgui.txt;
            prof = GenExProfile;
        end
        
    end
elseif(get(handles.bg_bi,'Value') == 1)
    
    if((~ isempty(layer1_spec)) && (~ isempty(layer2_spec)))
        fn = load(layer1_spec);
        refractionData(:,(al_nr(1)*2-1)) = fn(:,1); refractionData(:,(al_nr(1)*2)) = fn(:,2); 
        fn = load(layer2_spec);
        refractionData(:,(al_nr(2)*2-1)) = fn(:,1); refractionData(:,(al_nr(2)*2)) = fn(:,2);

        name{al_nr(1)} = regexprep(layer1_spec, '.txt', '')
        name{al_nr(2)} = regexprep(layer2_spec, '.txt', '')

        save('matvalgui.txt', 'refractionData', '-ASCII');
        if(layer1_step == 0) layer1_step = 1; end
        if(layer2_step == 0) layer2_step = 1; end

        for k = layer1_dmin : layer1_step : layer1_dmax
            for j = layer2_dmin : layer2_step : layer2_dmax
                d(al_nr(1)) = (k*1e-9);
                d(al_nr(2)) = (j*1e-9);
                eval(['save layernames.mat name d L p dir_name al_nr']);
                OpticsCalcegalwas(d);
                IscQEegalwas(L,p);
                load Currentsgui.txt;
                prof = GenExProfile;
            end
        end
    end
elseif(get(handles.bg_tri,'Value') == 1)
    
    if((~ isempty(tri_layer1_spec)) && (~ isempty(tri_layer2_spec)) && (~ isempty(tri_layer3_spec)))
        
        fn = load(tri_layer1_spec);
        refractionData(:,(al_nr(1)*2-1)) = fn(:,1); refractionData(:,(al_nr(1)*2)) = fn(:,2); 
        fn = load(tri_layer2_spec);
        refractionData(:,(al_nr(2)*2-1)) = fn(:,1); refractionData(:,(al_nr(2)*2)) = fn(:,2);
        fn = load(tri_layer3_spec);
        refractionData(:,(al_nr(3)*2-1)) = fn(:,1); refractionData(:,(al_nr(3)*2)) = fn(:,2);
        
        name{al_nr(1)} = regexprep(tri_layer1_spec, '.txt', '')
        name{al_nr(2)} = regexprep(tri_layer2_spec, '.txt', '')
        name{al_nr(3)} = regexprep(tri_layer3_spec, '.txt', '')

        save('matvalgui.txt', 'refractionData', '-ASCII');
        if(tri_layer1_step == 0) tri_layer1_step = 1; end
        if(tri_layer2_step == 0) tri_layer2_step = 1; end
        if(tri_layer3_step == 0) tri_layer3_step = 1; end

        for k = tri_layer1_dmin : tri_layer1_step : tri_layer1_dmax
            for j = tri_layer2_dmin : tri_layer2_step : tri_layer2_dmax
                for l = tri_layer3_dmin : tri_layer3_step : tri_layer3_dmax
                    d(al_nr(1)) = (k*1e-9);
                    d(al_nr(2)) = (j*1e-9);
                    d(al_nr(3)) = (l*1e-9);
                    eval(['save layernames.mat name d L p dir_name al_nr']);
                    OpticsCalcegalwas(d);
                    IscQEegalwas(L,p);
                    load Currentsgui.txt;
                    prof = GenExProfile;
                end
            end
        end
    end
end
msgbox('Calculations complete');




% --- Executes on button press in check_single.
function check_single_Callback(hObject, eventdata, handles)
% hObject    handle to check_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_single
if (get(handles.check_single,'Value') ==1)
    set(handles.singlelayer_text,'Visible','on');
    set(handles.singlelayer_dl,'Visible','on');
    set(handles.singlelayer_dmax,'Visible','on');
    set(handles.singlelayer_dmin,'Visible','on');
    set(handles.singlelayer_step,'Visible','on');
    set(handles.singlelayer_load,'Visible','on');
    set(handles.singlelayer_spec,'Visible','on');
    
    set(handles.layer1_text,'Visible','off');
    set(handles.layer1_dl,'Visible','off');
    set(handles.layer1_dmax,'Visible','off');
    set(handles.layer1_dmin,'Visible','off');
    set(handles.layer1_step,'Visible','off');
    set(handles.layer1_load,'Visible','off');
    set(handles.layer1_spec,'Visible','off');
    
    set(handles.layer2_text,'Visible','off');
    set(handles.layer2_dl,'Visible','off');
    set(handles.layer2_dmax,'Visible','off');
    set(handles.layer2_dmin,'Visible','off');
    set(handles.layer2_step,'Visible','off');
    set(handles.layer2_load,'Visible','off');
    set(handles.layer2_spec,'Visible','off');
else
    set(handles.singlelayer_text,'Visible','off');
    set(handles.singlelayer_dl,'Visible','off');
    set(handles.singlelayer_dmax,'Visible','off');
    set(handles.singlelayer_dmin,'Visible','off');
    set(handles.singlelayer_step,'Visible','off');
    set(handles.singlelayer_load,'Visible','off');
    set(handles.singlelayer_spec,'Visible','off');
    
    set(handles.layer1_text,'Visible','on');
    set(handles.layer1_dl,'Visible','on');
    set(handles.layer1_dmax,'Visible','on');
    set(handles.layer1_dmin,'Visible','on');
    set(handles.layer1_step,'Visible','on');
    set(handles.layer1_load,'Visible','on');
    set(handles.layer1_spec,'Visible','on');
    
    set(handles.layer2_text,'Visible','on');
    set(handles.layer2_dl,'Visible','on');
    set(handles.layer2_dmax,'Visible','on');
    set(handles.layer2_dmin,'Visible','on');
    set(handles.layer2_step,'Visible','on');
    set(handles.layer2_load,'Visible','on');
    set(handles.layer2_spec,'Visible','on');
end

% --- Executes on button press in check_quenching.
function check_quenching_Callback(hObject, eventdata, handles)
% hObject    handle to check_quenching (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_quenching




% --- Executes on button press in singlelayer_load.
function singlelayer_load_Callback(hObject, eventdata, handles)
% hObject    handle to singlelayer_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
{  '*.txt','Textfiles (*.txt)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Load n-k-Values for layer', ...
   'MultiSelect', 'off')
if isequal(filename,0) %cancel 
else
    set(handles.singlelayer_spec,'String',filename);

end

function al_nr = get_absorber_layer_nr(name)
    layercount = 1;
    al_nr = 0;
    for i = 1:length(name)
        if(isempty(char(name(i))))
            al_nr(layercount) = i;
            layercount = layercount + 1;
        end
    end
    
    
        
    




function singlelayer_spec_Callback(hObject, eventdata, handles)
% hObject    handle to singlelayer_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of singlelayer_spec as text
%        str2double(get(hObject,'String')) returns contents of singlelayer_spec as a double


% --- Executes during object creation, after setting all properties.
function singlelayer_spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singlelayer_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in layer2_load.
function layer2_load_Callback(hObject, eventdata, handles)
% hObject    handle to layer2_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
{  '*.txt','Textfiles (*.txt)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Load n-k-Values for layer', ...
   'MultiSelect', 'off')
if isequal(filename,0) %cancel 
else
    set(handles.layer2_spec,'String',filename);

end


function layer2_spec_Callback(hObject, eventdata, handles)
% hObject    handle to layer2_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer2_spec as text
%        str2double(get(hObject,'String')) returns contents of layer2_spec as a double


% --- Executes during object creation, after setting all properties.
function layer2_spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer2_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in layer1_load.
function layer1_load_Callback(hObject, eventdata, handles)
% hObject    handle to layer1_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
{  '*.txt','Textfiles (*.txt)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Load n-k-Values for layer', ...
   'MultiSelect', 'off')
if isequal(filename,0) %cancel 
else
    set(handles.layer1_spec,'String',filename);

end


function layer1_spec_Callback(hObject, eventdata, handles)
% hObject    handle to layer1_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layer1_spec as text
%        str2double(get(hObject,'String')) returns contents of layer1_spec as a double


% --- Executes during object creation, after setting all properties.
function layer1_spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layer1_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in path_select.
function path_select_Callback(hObject, eventdata, handles)
% hObject    handle to path_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dir_name;
dir_name = uigetdir('Select path');



function tri_layer2_dmin_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer2_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer2_dmin as text
%        str2double(get(hObject,'String')) returns contents of tri_layer2_dmin as a double


% --- Executes during object creation, after setting all properties.
function tri_layer2_dmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer2_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer2_dmax_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer2_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer2_dmax as text
%        str2double(get(hObject,'String')) returns contents of tri_layer2_dmax as a double


% --- Executes during object creation, after setting all properties.
function tri_layer2_dmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer2_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer2_step_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer2_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer2_step as text
%        str2double(get(hObject,'String')) returns contents of tri_layer2_step as a double


% --- Executes during object creation, after setting all properties.
function tri_layer2_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer2_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer1_dmin_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer1_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer1_dmin as text
%        str2double(get(hObject,'String')) returns contents of tri_layer1_dmin as a double


% --- Executes during object creation, after setting all properties.
function tri_layer1_dmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer1_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer1_dmax_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer1_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer1_dmax as text
%        str2double(get(hObject,'String')) returns contents of tri_layer1_dmax as a double


% --- Executes during object creation, after setting all properties.
function tri_layer1_dmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer1_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer1_step_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer1_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer1_step as text
%        str2double(get(hObject,'String')) returns contents of tri_layer1_step as a double


% --- Executes during object creation, after setting all properties.
function tri_layer1_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer1_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tri_layer2_load.
function tri_layer2_load_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer2_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
{  '*.txt','Textfiles (*.txt)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Load n-k-Values for layer', ...
   'MultiSelect', 'off')
if isequal(filename,0) %cancel 
else
    set(handles.tri_layer2_spec,'String',filename);

end


function tri_layer2_spec_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer2_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer2_spec as text
%        str2double(get(hObject,'String')) returns contents of tri_layer2_spec as a double


% --- Executes during object creation, after setting all properties.
function tri_layer2_spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer2_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tri_layer1_load.
function tri_layer1_load_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer1_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
{  '*.txt','Textfiles (*.txt)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Load n-k-Values for layer', ...
   'MultiSelect', 'off')
if isequal(filename,0) %cancel 
else
    set(handles.tri_layer1_spec,'String',filename);

end


function tri_layer1_spec_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer1_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer1_spec as text
%        str2double(get(hObject,'String')) returns contents of tri_layer1_spec as a double


% --- Executes during object creation, after setting all properties.
function tri_layer1_spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer1_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer3_dmin_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer3_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer3_dmin as text
%        str2double(get(hObject,'String')) returns contents of tri_layer3_dmin as a double


% --- Executes during object creation, after setting all properties.
function tri_layer3_dmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer3_dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer3_dmax_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer3_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer3_dmax as text
%        str2double(get(hObject,'String')) returns contents of tri_layer3_dmax as a double


% --- Executes during object creation, after setting all properties.
function tri_layer3_dmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer3_dmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tri_layer3_step_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer3_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer3_step as text
%        str2double(get(hObject,'String')) returns contents of tri_layer3_step as a double


% --- Executes during object creation, after setting all properties.
function tri_layer3_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer3_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tri_layer3_load.
function tri_layer3_load_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer3_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
{  '*.txt','Textfiles (*.txt)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Load n-k-Values for layer', ...
   'MultiSelect', 'off')
if isequal(filename,0) %cancel 
else
    set(handles.tri_layer3_spec,'String',filename);

end


function tri_layer3_spec_Callback(hObject, eventdata, handles)
% hObject    handle to tri_layer3_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tri_layer3_spec as text
%        str2double(get(hObject,'String')) returns contents of tri_layer3_spec as a double


% --- Executes during object creation, after setting all properties.
function tri_layer3_spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tri_layer3_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel3.
function uipanel3_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel3 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.bg_single, 'Value') == 1)
    set(handles.singlelayer_text,'Visible','on');
    set(handles.singlelayer_dmax,'Visible','on');
    set(handles.singlelayer_dmin,'Visible','on');
    set(handles.singlelayer_step,'Visible','on');
    set(handles.singlelayer_load,'Visible','on');
    set(handles.singlelayer_spec,'Visible','on');

    set(handles.layer1_text,'Visible','off');
    set(handles.layer1_dmax,'Visible','off');
    set(handles.layer1_dmin,'Visible','off');
    set(handles.layer1_step,'Visible','off');
    set(handles.layer1_load,'Visible','off');
    set(handles.layer1_spec,'Visible','off');

    set(handles.layer2_text,'Visible','off');
    set(handles.layer2_dmax,'Visible','off');
    set(handles.layer2_dmin,'Visible','off');
    set(handles.layer2_step,'Visible','off');
    set(handles.layer2_load,'Visible','off');
    set(handles.layer2_spec,'Visible','off');

    set(handles.tri_layer1_text,'Visible','off');
    set(handles.tri_layer1_dmax,'Visible','off');
    set(handles.tri_layer1_dmin,'Visible','off');
    set(handles.tri_layer1_step,'Visible','off');
    set(handles.tri_layer1_load,'Visible','off');
    set(handles.tri_layer1_spec,'Visible','off');

    set(handles.tri_layer2_text,'Visible','off');
    set(handles.tri_layer2_dmax,'Visible','off');
    set(handles.tri_layer2_dmin,'Visible','off');
    set(handles.tri_layer2_step,'Visible','off');
    set(handles.tri_layer2_load,'Visible','off');
    set(handles.tri_layer2_spec,'Visible','off');

    set(handles.tri_layer3_text,'Visible','off');
    set(handles.tri_layer3_dmax,'Visible','off');
    set(handles.tri_layer3_dmin,'Visible','off');
    set(handles.tri_layer3_step,'Visible','off');
    set(handles.tri_layer3_load,'Visible','off');
    set(handles.tri_layer3_spec,'Visible','off');
elseif(get(handles.bg_bi, 'Value') == 1)
    set(handles.singlelayer_text,'Visible','off');
    set(handles.singlelayer_dmax,'Visible','off');
    set(handles.singlelayer_dmin,'Visible','off');
    set(handles.singlelayer_step,'Visible','off');
    set(handles.singlelayer_load,'Visible','off');
    set(handles.singlelayer_spec,'Visible','off');

    set(handles.layer1_text,'Visible','on');
    set(handles.layer1_dmax,'Visible','on');
    set(handles.layer1_dmin,'Visible','on');
    set(handles.layer1_step,'Visible','on');
    set(handles.layer1_load,'Visible','on');
    set(handles.layer1_spec,'Visible','on');

    set(handles.layer2_text,'Visible','on');
    set(handles.layer2_dmax,'Visible','on');
    set(handles.layer2_dmin,'Visible','on');
    set(handles.layer2_step,'Visible','on');
    set(handles.layer2_load,'Visible','on');
    set(handles.layer2_spec,'Visible','on');

    set(handles.tri_layer1_text,'Visible','off');
    set(handles.tri_layer1_dmax,'Visible','off');
    set(handles.tri_layer1_dmin,'Visible','off');
    set(handles.tri_layer1_step,'Visible','off');
    set(handles.tri_layer1_load,'Visible','off');
    set(handles.tri_layer1_spec,'Visible','off');

    set(handles.tri_layer2_text,'Visible','off');
    set(handles.tri_layer2_dmax,'Visible','off');
    set(handles.tri_layer2_dmin,'Visible','off');
    set(handles.tri_layer2_step,'Visible','off');
    set(handles.tri_layer2_load,'Visible','off');
    set(handles.tri_layer2_spec,'Visible','off');

    set(handles.tri_layer3_text,'Visible','off');
    set(handles.tri_layer3_dmax,'Visible','off');
    set(handles.tri_layer3_dmin,'Visible','off');
    set(handles.tri_layer3_step,'Visible','off');
    set(handles.tri_layer3_load,'Visible','off');
    set(handles.tri_layer3_spec,'Visible','off');
elseif(get(handles.bg_tri, 'Value') == 1)
    set(handles.singlelayer_text,'Visible','off');
    set(handles.singlelayer_dmax,'Visible','off');
    set(handles.singlelayer_dmin,'Visible','off');
    set(handles.singlelayer_step,'Visible','off');
    set(handles.singlelayer_load,'Visible','off');
    set(handles.singlelayer_spec,'Visible','off');

    set(handles.layer1_text,'Visible','off');
    set(handles.layer1_dmax,'Visible','off');
    set(handles.layer1_dmin,'Visible','off');
    set(handles.layer1_step,'Visible','off');
    set(handles.layer1_load,'Visible','off');
    set(handles.layer1_spec,'Visible','off');

    set(handles.layer2_text,'Visible','off');
    set(handles.layer2_dmax,'Visible','off');
    set(handles.layer2_dmin,'Visible','off');
    set(handles.layer2_step,'Visible','off');
    set(handles.layer2_load,'Visible','off');
    set(handles.layer2_spec,'Visible','off');

    set(handles.tri_layer1_text,'Visible','on');
    set(handles.tri_layer1_dmax,'Visible','on');
    set(handles.tri_layer1_dmin,'Visible','on');
    set(handles.tri_layer1_step,'Visible','on');
    set(handles.tri_layer1_load,'Visible','on');
    set(handles.tri_layer1_spec,'Visible','on');

    set(handles.tri_layer2_text,'Visible','on');
    set(handles.tri_layer2_dmax,'Visible','on');
    set(handles.tri_layer2_dmin,'Visible','on');
    set(handles.tri_layer2_step,'Visible','on');
    set(handles.tri_layer2_load,'Visible','on');
    set(handles.tri_layer2_spec,'Visible','on');

    set(handles.tri_layer3_text,'Visible','on');
    set(handles.tri_layer3_dmax,'Visible','on');
    set(handles.tri_layer3_dmin,'Visible','on');
    set(handles.tri_layer3_step,'Visible','on');
    set(handles.tri_layer3_load,'Visible','on');
    set(handles.tri_layer3_spec,'Visible','on');
end
