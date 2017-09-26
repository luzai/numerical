%%
% Hello!
% This is an app for predicting a baby's height and weights between 1 to 81
% months age old. 

function varargout = MainGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainGUI_OpeningFcn, ...
    'gui_OutputFcn',  @MainGUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


%% --------------------------------------------------------------------------
function MainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
global Now
format long; clc;
[yeN,moN,daN]=calendarGUI(0,0,'create',gcf);
Now=datetime([yeN,moN,daN]);
set(handles.text25,'String',[get(handles.text25,'String'), '  ' , datestr(Now)]);
handles.output = hObject;
movegui(hObject,'onscreen')              % To display application onscreen
movegui(hObject,'center')                % To display application in the center of screen
set(handles.gridopt,'checked','off')     % To check the grid option
handles.Leg = [];                        % Initialize Leg variable for later use
guidata(hObject, handles);

%% --------------------------------------------------------------------------
function varargout = MainGUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

%% --------------------------------------------------------------------------
function run_wave_Callback(hObject, eventdata, handles)
global Now
[yeB,moB,daB] = calendarGUI(0,0,'get');
Bir=datetime([yeB,moB,daB]);
set(handles.text26,'String',[ 'Baby Birthday is  ' , datestr(Bir)]);
% formatIn = 'mm/dd/yyyy';
% datenum(DateString,formatIn)
age=(datenum(Now)-datenum(Bir))/30;
if age<0
     msgbox('Are You Sure Your Baby has been born QAQ ?', ...
            'Warning','None','modal')    
        return
elseif age>100
    msgbox('Month age is suggested <=81, otherwise the result maybe inaccurate! ', ...
            'Warning','None','modal')
        return
end    

if get(handles.boyOr,'value') == 1 && get(handles.heightOr,'value') == 1     % loop for B-Splines
   opt='boyHeight';
    
elseif get(handles.boyOr,'Value') == 1 && get(handles.heightOr,'Value')==2      % loop for Cardinal Spline
   opt='boyWeight';
    
elseif get(handles.boyOr,'Value') == 2 && get(handles.heightOr,'Value') ==  1    % loop for Naive Basis Function
   opt='girlHeight';
    
elseif get(handles.boyOr , 'Value' ) ==2 && get(handles.heightOr,'Value') == 2
   opt='girlWeight';
end
[mupp,sigpp]=myPre(age,opt);
mu=ppval(mupp,age);
sig=ppval(sigpp,age);    
xx=linspace(mu-3*sig,mu+3*sig,500);
yy=normpdf(xx,mu,sig);
plot(xx,yy);
res=mu;
if strfind(opt,'Height')
    set(handles.text28,'String',['Baby"s standard Height is ',num2str(res),'(',num2str(res-2*sig),' , ',num2str(res+2*sig),')','(with 95% confidence interval)']);
elseif strfind(opt,'Weight')
    set(handles.text28,'String',['baby"s standard Weight is ',num2str(res),'(',num2str(res-2*sig),' , ',num2str(res+2*sig),')','(with 95% confidence interval)']);
end
if strcmp(get(handles.gridopt,'checked'),'off')
    set(handles.display_plot,'XGrid','Off','YGrid','Off','ZGrid','Off') % Make the grid invisible
else
    set(handles.display_plot,'XGrid','On','YGrid','On','ZGrid','On')   % Make the grid visible
end
%handles.Leg = LegendVar;
guidata(hObject, handles);

%% --------------------------------------------------------------------------
function info_Callback(hObject, eventdata, handles)
helpwin('MainGUI.m')

%% --------------------------------------------------------------------------
function close_button_Callback(hObject, eventdata, handles)
close(gcbf) % to close GUI

%% --------------------------------------------------------------------------
% Executes on button press in save_plot.
function save_plot_Callback(hObject, eventdata, handles)

h = get(gcf,'CurrentAxes');
figure(1);
copyobj(h,gcf);
set(gca,'FontSize',12);
c = copyobj(handles.Leg,gcf);
set(gcf, 'PaperPosition', [2 1 8 4]);
print( gcf, '-dpng', 'plot.png' );
close(1);

% --------------------------------------------------------------------------
% function i_CreateFcn(hObject, eventdata, handles)
% 
% %% --------------------------------------------------------------------------
% function i_Callback(hObject, eventdata, handles)
% 
% %% --------------------------------------------------------------------------
% function k_CreateFcn(hObject, eventdata, handles)
% 
% --------------------------------------------------------------------------
% function k_Callback(hObject, eventdata, handles)

%% --------------------------------------------------------------------
function Gridmenu_Callback(hObject, eventdata, handles)

%% --------------------------------------------------------------------
function grid_onoff_Callback(hObject, eventdata, handles)
if strcmp(get(handles.gridopt,'checked'),'on')
    set(handles.gridopt,'checked','off')           % To uncheck the grid option
    set(handles.display_plot,'XGrid','Off','YGrid','Off','ZGrid','Off') % Make the grid invisible
else
    set(handles.gridopt,'checked','on')            % To check the grid option
    set(handles.display_plot,'XGrid','On','YGrid','On','ZGrid','On')   % Make the grid visible
end

%% --------------------------------------------------------------------
function boyOr_CreateFcn(hObject, eventdata, handles)

%% --------------------------------------------------------------------
function boyOr_Callback(hObject, eventdata, handles)

%--------------------------------------------------------------------
% function n_CreateFcn(hObject, eventdata, handles)
% 
% % --------------------------------------------------------------------
% function n_Callback(hObject, eventdata, handles)

%% --- Executes on selection change in heightOr.
function heightOr_Callback(hObject, eventdata, handles)

%% --- Executes during object creation, after setting all properties.
function heightOr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%  
function [year,month,day] = calendarGUI(~,index,action,input)
% Simple calendar GUI which can be incorporated into a figure, a uipanel or
% a uitab.
% In order to use it into a different figure, uipanel or uitab just set
% input as the handle like :
% [year,month,day] = calendarGUI(0,0,'create',handle)
% to only get values use the same function calling :
% [year,month,day] = calendarGUI(0,0,'get')
% the 4 parameters in the beginning can be set to other values :
% the start_year is the first year in the Year popupmenu box
% the year_offset is the number of year after the current year
% xpos and ypos are the position of the calendar from left corner of the
% handle element
% It also can be used simply by calling :
% [year,month,day] = calendarGUI(0,0,'create')
% and will output the year, month and day when closing the figure.
% Using it this way does not allow to use the 'get' action functionality


start_year = 2005;
year_offset = 5;
xpos = 20;
ypos = 20;

switch action
    case 'create'
        if nargin < 4
            parent = figure('Position',[750   520   xpos+215   ypos+170],...
                'MenuBar','none','Name','** Calendar **',...
                'DockControls','off','Toolbar','none','NumberTitle','off',...
                'CloseRequestFcn',{@calendarGUI,'fcnClose'},...
                'Resize','off','Tag','SelfRunning');
        else
            parent = input;
        end
        
        % Create the calendar
        [year,month,day] = datevec(now());
        ht = uitable('Parent',parent,...
            'TooltipString','Calendar Date',...
            'Tag','Day','ColumnEditable',false,...
            'CellSelectionCallback',...
            {@calendarGUI,'fcnDay'});
        set(ht,'RowName',[])
        set(ht,'ColumnName',{'Sun' 'Mon' 'Tue' 'Wed' 'Thu' 'Fri' 'Sat'})
        set(ht,'ColumnWidth',{30 30 30 30 30 30 30})
        set(ht,'Units','Pixels');
        set(ht,'Position',[xpos ypos 211.1 130])
        date = produce_date_array(year,month,day);
        set(ht,'Data',date);
        set(ht,'UserData',[year,month,day]);
        
        % create Month box
        uicontrol('Parent',parent,'Style','popupmenu',...
            'Position',[xpos+130 ypos+145 80 20],...
            'Callback',{@calendarGUI,'fcnMonth'},...
            'Tag','Month',...
            'String',{'January' 'February' 'March' 'April' 'May'...
            'June' 'July' 'August' 'September' 'October' 'November'...
            'December'},...
            'Value',month);
        
        % create Today pushbutton
        htoday = uicontrol('Parent',parent,'Style','pushbutton',...
            'Position',[xpos ypos+145 55 20],...
            'Callback',{@calendarGUI,'fcnToday'},...
            'Tag','Today','String','TODAY');
        
        % Create Year box
        y_vector = start_year:year + year_offset;
        y = {};
        for ii = 1:length(y_vector)
            y = [y {mat2str(y_vector(ii))}];
        end
        uicontrol('Parent',parent,'Style','popupmenu',...
            'Position',[xpos+65 ypos+145 55 20],...
            'Callback',{@calendarGUI,'fcnYear'},...
            'Tag','Year',...
            'String', y,...
            'Value',year-(start_year-1));
        
        if strcmp(get(parent,'Tag'),'SelfRunning')
            waitfor(htoday)
            [year,month,day] = calendarGUI(0,0,'get');
            delete(parent)
        end
        
        
    case 'fcnYear'
        hy = findobj('Tag','Year');
        ht = findobj('Tag','Day');
        ymd = get(ht,'UserData');
        month = ymd(2);
        day = ymd(3);
        year = get(hy,'Value');
        year = year + (start_year-1);
        date = produce_date_array(year,month,day);
        set(ht,'Data',date);
        set(ht,'UserData',[year month day]);
        
    case 'fcnMonth'
        hm = findobj('Tag','Month');
        ht = findobj('Tag','Day');
        ymd = get(ht,'UserData');
        year = ymd(1);
        day = ymd(3);
        month = get(hm,'Value');
        date = produce_date_array(year,month,day);
        set(ht,'Data',date);
        set(ht,'UserData',[year month day]);
        
    case 'fcnToday'
        [year,month,day] = datevec(now());
        date = produce_date_array(year,month,day);
        ht = findobj('Tag','Day');
        hm = findobj('Tag','Month');
        set(hm,'Value',month);
        hy = findobj('Tag','Year');
        set(hy,'Value',year-(start_year-1));
        set(ht,'Data',date);
        set(ht,'UserData',[year month day]);
        
    case 'fcnDay'
        if ~isempty(index.Indices) % because the function runs 2 times
            xi = index.Indices(1);
            yi = index.Indices(2);
            ht = findobj('Tag','Day');
            data = get(ht,'Data');
            get(ht,'UserData');
            ymd = get(ht,'UserData');
            year = ymd(1);
            month = ymd(2);
            day = data(xi,yi);
            day = strrep(day,'*','');
            day = str2double(day);
            date = produce_date_array(year,month,day);
            set(ht,'Data',date);
            set(ht,'UserData',[year month day]);
        end
        
    case 'get'
        ht = findobj('Tag','Day');
        ymd = get(ht,'UserData');
        %ymd=ymd(end);
        %ymd=ymd{:};
        year = ymd(1);
        month = ymd(2);
        day = ymd(3);
        
    case 'fcnSetDate'
        if size(input,2) == 3
            year = input(1);
            month = input(2);
            day = input(3);
            date = produce_date_array(year,month,day);
            ht = findobj('Tag','Day');
            hm = findobj('Tag','Month');
            set(hm,'Value',month);
            hy = findobj('Tag','Year');
            set(hy,'Value',year-(start_year-1));
            set(ht,'Data',date);
            set(ht,'UserData',[year month day]);
        else
            msgbox('Input must be a 1x3 vector [year month day]')
        end
        
    case 'fcnClose'
        htoday = findobj('Tag','Today');
        delete(htoday);
end
  
%% _______________________________________
% function to get date     
function [date] = produce_date_array(year,month,day)
    
date = calendar(year,month);
date = mat2cell(date(:),ones(size(date,1)*size(date,2),1));
for i = 1:length(date)
    if date{i} == 0
        date{i} = '-';
    elseif date{i} == day
        date{i} = sprintf('*%d',date{i});
    else
        date{i} = mat2str(date{i});
    end
end
date = reshape(date,6,7);






