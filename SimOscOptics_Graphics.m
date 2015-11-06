function varargout = SimOscOptics_Graphics(varargin)
% SIMOSCOPTICS_GRAPHICS M-file for SimOscOptics_Graphics.fig
%      SIMOSCOPTICS_GRAPHICS, by itself, creates a new SIMOSCOPTICS_GRAPHICS or raises the existing
%      singleton*.
%
%      H = SIMOSCOPTICS_GRAPHICS returns the handle to a new SIMOSCOPTICS_GRAPHICS or the handle to
%      the existing singleton*.
%
%      SIMOSCOPTICS_GRAPHICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMOSCOPTICS_GRAPHICS.M with the given input arguments.
%
%      SIMOSCOPTICS_GRAPHICS('Property','Value',...) creates a new SIMOSCOPTICS_GRAPHICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimOscOptics_Graphics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimOscOptics_Graphics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimOscOptics_Graphics

% Last Modified by GUIDE v2.5 09-Feb-2010 14:07:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimOscOptics_Graphics_OpeningFcn, ...
                   'gui_OutputFcn',  @SimOscOptics_Graphics_OutputFcn, ...
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


% --- Executes just before SimOscOptics_Graphics is made visible.
function SimOscOptics_Graphics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimOscOptics_Graphics (see VARARGIN)

% Choose default command line output for SimOscOptics_Graphics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimOscOptics_Graphics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SimOscOptics_Graphics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function files_text_Callback(hObject, eventdata, handles)
% hObject    handle to files_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of files_text as text
%        str2double(get(hObject,'String')) returns contents of files_text as a double


% --- Executes during object creation, after setting all properties.
function files_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to files_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in create_graphics.
function create_graphics_Callback(hObject, eventdata, handles)
global files;
global path;
% hObject    handle to create_graphics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('running SimOscOptics_Graphics');
if(~ isempty(files))
    if(ischar(files) == 1)
        size_files = 1;
    else
        size_files = length(files)
    end
    profile = get(handles.gen_profile, 'Value');
    map = get(handles.color_map, 'Value');

    a = 1;
    b = 1;
    colorvec = ['b','c','r'];
    max_d = 0;
    actual_d = 0;
    help_x = 0;
    help_y = 0;
    
    for i = 1 : size_files
        if(size_files == 1)
            filename = files;
        else
            filename = char(files(i));
        end
        str = filename;
        str = regexprep(str, '.*_D', '');
        str = regexprep(str, 'L', '');
        str = regexprep(str, '.mat', '');
        values = regexp(str, '_', 'split');        
        if(regexp(filename, 'single'))
            actual_d = str2num(char(values(1)));
        elseif(regexp(filename, 'bilayer'))
            actual_d = str2num(char(values(1))) + str2num(char(values(2)));
            help_x(i) = str2num(char(values(1)));
            help_y(i) = str2num(char(values(2)));
        elseif(regexp(filename, 'trilayer'))
            actual_d = str2num(char(values(1))) + str2num(char(values(2))) + str2num(char(values(3)));
        end
        if(actual_d > max_d) max_d = actual_d; end
    end
    
    map_mat_x1 = unique(help_x)
    map_mat_y1 = unique(help_y)
    map_mat_z = 0;
    tri = 0;
    gen1='';
    gen2='';
    gen3='';
    
    fid = fopen('iv_data\gen_rates.txt', 'w');
    for i = 1 : size_files
        if(size_files == 1)
            filename = files;
        else
            filename = char(files(i));
        end
        str = filename;
        str = regexprep(str, 'bilayer__.*_D', '');
        str = regexprep(str, 'single__.*_D', '');
        str = regexprep(str, 'trilayer__.*_D', '');
        str = regexprep(str, 'L', '');
        str = regexprep(str, '.mat', '');
        values = regexp(str, '_', 'split');
        str2 = filename;
        str2 = regexprep(str2, '.*__', '');
        str2 = regexprep(str2, '_D.*', '');
        if(regexp(filename, 'single'));
            
            name = [path, filename];
            load(name, 'Var', 'res', 'gen');
            layer_d = str2num(char(values(1)));
            if(profile == 1)
                x1 = linspace(0,layer_d);
                
                figure(i);
                hold all
                line([layer_d layer_d],[0 3e+28],'Color','k','LineStyle','-','LineWidth',2);
                text(0, 2.9e+28,[' ' str2],'FontSize',12);
                
                axis([0 max_d 0 3e+28])
                
                plot(x1, Var, 'LineWidth', 2, 'Color', colorvec(1));
                if(~ isempty(res))
                    plot(x1, res, 'LineWidth', 2, 'Color', colorvec(2));
                end
                hold off
                
                name = regexprep(filename, '.mat', '');
                savename = strcat(path, name);
                saveas(gcf, savename, 'tiffn');
            end
            map_mat_x2(i) = layer_d;
            if(isempty(gen))
                map_mat_y2(i) = layer_d/100*trapz(Var);
            else
                map_mat_y2(i) = gen;
            end
            textline = [filename, '\t', num2str(map_mat_y2(i)), '\t', num2str(layer_d), '\t\r\n'];
            
        elseif(regexp(filename, 'bilayer'))
            
            name = [path, filename];
            % auskommentierungen und änderung darunter für blend/c60
           % load(name, 'Var1', 'Var2','res1', 'res2','gen1','gen2');
           load(name, 'Var1', 'Var2', 'res2','gen2');
            layer1_d = str2num(char(values(1)));
            layer2_d = str2num(char(values(2)));
            if(profile == 1)
                x1 = linspace(0,layer1_d);
                x2 = layer1_d + linspace(0,layer2_d);
                
                figure(i);
                hold all
                line([layer1_d layer1_d],[0 3e+28],'Color','k','LineStyle','- -','LineWidth',2);
                line([layer1_d+layer2_d layer1_d+layer2_d],[0 3e+28 ],'Color','k','LineStyle','-','LineWidth',2);
                
                values2 = regexp(str2, '-', 'split');
                text(0, 2.9e+28,[' ' values2(1)],'FontSize',12);
                text(layer1_d, 2.9e+28,[' ' values2(2)],'FontSize',12);

                axis([0 max_d 0 3e+28]);

                plot(x1, Var1, 'LineWidth', 2, 'Color', colorvec(1));
                %if(~ isempty(res1))
                %    plot(x1, res1, 'LineWidth', 2, 'Color', colorvec(2));
                %end
                plot(x2, Var2, 'LineWidth', 2, 'Color', colorvec(3));
                if(~ isempty(res2))
                    plot(x2, res2, 'LineWidth', 2, 'Color', [1 0.5 0]);
                end
                hold off


                name = regexprep(filename, '.mat', '');
                savename = strcat(path, name);
                saveas(gcf, savename, 'tiffn');
            elseif(map == 1)
                b = find(map_mat_x1 == layer1_d);
                a = find(map_mat_y1 == layer2_d);
                gen1 = layer1_d/100*trapz(Var1)*1e-9;
                gen2
                map_mat_z(a,b) = gen1 + gen2;
                
                map_mat_x(i) = layer1_d;
                map_mat_y(i) = layer2_d;
            end
            textline = [filename, '\t%e\t', num2str(layer1_d), '\t', num2str(layer2_d), '\t\r\n'];
        elseif(regexp(filename, 'trilayer'))
            tri = 1;
            name = [path, filename];
            load(name, 'Var1', 'Var2','Var3','res1', 'res3','gen1','gen3');
            layer1_d = str2num(char(values(1)));
            layer2_d = str2num(char(values(2)));
            layer3_d = str2num(char(values(3)));
            gen2 = layer2_d/100*trapz(Var2)*1e-9;
            if(profile == 1)
                x1 = linspace(0,layer1_d);
                x2 = layer1_d + linspace(0,layer2_d);
                x3 = layer1_d + layer2_d + linspace(0,layer3_d);
                
                figure(i);
                hold all
                line([layer1_d layer1_d],[0 3e+28],'Color','k','LineStyle','- -','LineWidth',2);
                line([layer1_d+layer2_d layer1_d+layer2_d],[0 3e+28],'Color','k','LineStyle','- -','LineWidth',2);
                line([layer1_d+layer2_d+layer3_d layer1_d+layer2_d+layer3_d],[0 3e+28],'Color','k','LineStyle','-','LineWidth',2);
                
                values2 = regexp(str2, '-', 'split');
                text(0, 2.9e+28,[' ' values2(1)],'FontSize',12);
                text(layer1_d, 2.9e+28,[' ' values2(2)],'FontSize',12);
                text(layer1_d+layer2_d, 2.9e+28,[' ' values2(3)],'FontSize',12);

                axis([0 max_d 0 3e+28]);

                plot(x1, Var1, 'LineWidth', 2, 'Color', colorvec(1));
                plot(x1, res1, 'LineWidth', 2, 'Color', colorvec(2));
                plot(x2, Var2, 'LineWidth', 2, 'Color', colorvec(3));
                plot(x3, Var3, 'LineWidth', 2, 'Color', colorvec(1));
                plot(x3, res3, 'LineWidth', 2, 'Color', colorvec(2));
                hold off


                name = regexprep(filename, '.mat', '');
                savename = strcat(path, name);
                saveas(gcf, savename, 'tiffn');

            end
            textline = [filename, '\t%e\t%e\t%e\t', num2str(layer1_d), '\t', num2str(layer2_d), '\t', num2str(layer3_d), '\t\r\n'];
        end
        fprintf(fid,textline,gen1,gen2,gen3);
    end
    fclose(fid);
    
    if(map == 1 && tri == 0)
        figure(1);
        if(sum(map_mat_z) == 0)
            plot(map_mat_x2,map_mat_y2);
            str2 = regexprep(str2, '_', '');
            k = ['thickness ', str2];
            set(get(gca,'XLabel'),'String',k,'FontSize',16);
            set(get(gca,'YLabel'),'String','','FontSize',16);      
        else
            [m,n] = size(map_mat_z);
            if(m == 1 || n == 1)
                k = unique(map_mat_x);
                l = unique(map_mat_y);
                if(size(k) == 1)
                    map_mat = map_mat_y;
                elseif(size(l) == 1)
                    map_mat = map_mat_x;
                end
                plot(map_mat,map_mat_z);
            else
                surf(map_mat_x1,map_mat_y1, map_mat_z);
                values2 = regexp(str2, '-', 'split');
                values2(1) = regexprep(values2(1), '_', '');
                k = ['thickness ', values2(1)];
                values2(2) = regexprep(values2(2), '_', '');
                j= ['thickness ', values2(2)];
                set(get(gca,'XLabel'),'String',k,'FontSize',16);
                set(get(gca,'YLabel'),'String',j,'FontSize',16);   
            end
        end
        colormap(jet)
    end
end


% --- Executes on button press in load_data.
function load_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global files;
global path;

[files, path, filterindex] = uigetfile( ...
{  '*.mat','Mat-Files (*.mat)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Select Files...', ...
   'MultiSelect', 'on')
if isequal(files,0) %cancel 
else
    set(handles.files_text,'String',files);

end


% --- Executes on button press in fixed_axis.
function fixed_axis_Callback(hObject, eventdata, handles)
% hObject    handle to fixed_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fixed_axis
