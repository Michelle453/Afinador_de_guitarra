function varargout = afinador_guitarra(varargin)

% Last Modified by GUIDE v2.5 05-Dec-2021 19:11:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @afinador_guitarra_OpeningFcn, ...
                   'gui_OutputFcn',  @afinador_guitarra_OutputFcn, ...
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

%-----------------------------------------------------------
% --- Executes just before afinador_guitarra is made visible.
function afinador_guitarra_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = afinador_guitarra_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on selection change in seleccionNotaLista.
function seleccionNotaLista_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function seleccionNotaLista_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in afinarBoton.
function afinarBoton_Callback(hObject, eventdata, handles)
opcion = get(handles.seleccionNotaLista,'value');
frecuencia_muestreo = 44100; %frecuencia de muestreo
%Variacion de t 
dt=1/frecuencia_muestreo;
%Grabamos el archivo de sonido, usando la funcion audiorecorder(Fs, NBITS, numero de canales)
audio = audiorecorder(frecuencia_muestreo,8,1)
record(audio)
%El archivbo de sonido durará 1 s. 
pause(1)
pause(audio);
%Obtenemos los datos de la grabacion de audio r 
nota = getaudiodata(audio);
%Guardamos el archivo de sonido en formato wav
audiowrite('audio.wav',nota,frecuencia_muestreo);
%Leemos el archivo .wav 
[nota,fs]=audioread('audio.wav');
%Sabemos que T=n/f, entonces calculamos el tiempo. 
T=length(nota)/fs;
%Creamos un vector tiempo n=tiempo*fs 
vector_tiempo=linspace(0,T,T*fs); 
axes(handles.gra1)
plot(vector_tiempo,nota) 
xlabel('Tiempo') 
ylabel('f(t)')

   
%Aplicamos la transformada de fourier para obtener la frecuencia de la señal 
transformada_fourier=fft(nota);
%Calculamos la potencia espectral, de la señal g, para poder obtener la
%frecuencia predominante de la señal 
potencia=abs(transformada_fourier).^2;
%Calculamos el tamaños de cada intervalo de frecuencia 
df=1/(length(nota)*dt);
%Realizamos el vector frecuencia 
f=(0:length(nota)-1)*df;
%Obtenemos el valor y posicion maximo de la potencia espectral, siendo k la posicion de este elemento 
[audio,posicion]=max(potencia);
%Obtenemos el valor de frecuencia que corresponde a la posicion de la frecuencia maxima. 
frecuencia_maxima=f(posicion) 
axes(handles.axes2)
%Graficamos la potencia en funcion de la frecuencia 
plot(f,potencia)
axis([0 500 0 40000])
xlabel('Frecuencia')
ylabel('Potencia espectral') 
j=linspace(0,5);
switch opcion 
    case 1  %mi (1) E
        axes(handles.axes3)
        cla reset 
        error=(abs(frecuencia_maxima-329.63))*100/329.63;
        set(handles.errorTexto,'string',error); 
        set(handles.frecuencia_obtenida,'string',frecuencia_maxima);
        set(handles.frecuencia_deseada,'string',329.63);
        stem(329.63,329.63)
        axis([0 1200 0 5])
        hold on 
        stem(frecuencia_maxima,329.63)
        axis([0 1200 0 5])
    case 2 % Si (2) G
        axes(handles.axes3) 
        cla reset
        error=(abs(frecuencia_maxima-246.94))*100/246.94;
        set(handles.errorTexto,'string',error); 
        set(handles.frecuencia_obtenida,'string',frecuencia_maxima);
        set(handles.frecuencia_deseada,'string',246.94);
        stem(246.94,246.94)
        axis([0 500 0 5])
        hold on 
        stem(frecuencia_maxima,246.64)
        axis([0 1200 0 5])
    case 3 % sol
        axes(handles.axes3) 
        cla reset
        error=(abs(frecuencia_maxima-196.00))*100/196.00;
        set(handles.errorTexto,'string',error); 
        set(handles.frecuencia_obtenida,'string',frecuencia_maxima);
        set(handles.frecuencia_deseada,'string',196.00);
        stem(196.00,196.00)
        axis([0 1200 0 5])
        hold on 
        stem(frecuencia_maxima,196.00)
        axis([0 1200 0 5])
    case 4 % Re
        axes(handles.axes3) 
        cla reset
        error=(abs(frecuencia_maxima-146.83))*100/146.83;
        set(handles.errorTexto,'string',error);
        set(handles.frecuencia_obtenida,'string',frecuencia_maxima);
        set(handles.frecuencia_deseada,'string',146.83);
        stem(146.83,146.83)
        axis([0 1200 0 5])
        hold on
        stem(frecuencia_maxima,146.83)
        axis([0 1200 0 5])
     case 5 %La (5) A
        axes(handles.axes3) 
        cla reset
        error=(abs(frecuencia_maxima-110.00))*100/110.00;
        set(handles.errorTexto,'string',error); 
        set(handles.frecuencia_obtenida,'string',frecuencia_maxima);
        set(handles.frecuencia_deseada,'string',110.00);
        stem(110.00,110.00)
        axis([0 1200 0 5])
        hold on
        stem(frecuencia_maxima,110.00)
        axis([0 1200 0 5])
      case 6 %mi (6) E
        axes(handles.axes3) 
        cla reset
        error=(abs(frecuencia_maxima-82.41))*100/82.41;
        set(handles.errorTexto,'string',error); 
        set(handles.frecuencia_obtenida,'string',frecuencia_maxima);
        set(handles.frecuencia_deseada,'string',82.41);
        stem(82.41,82.41)
        axis([0 1200 0 5])
        hold on 
        stem(frecuencia_maxima,82.41)
        axis([0 1200 0 5])
      otherwise
        disp('Su seleccion es incorrecta');
end
% --- Executes during object creation, after setting all properties.
function errorTexto_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
