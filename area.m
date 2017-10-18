%OTSU'S
close all;
clear;
clc;

%esto es conflicto
%nueva linea
I = imread('bife_opt.JPG');
%contar la cantidad de pixeles negros
I = I(:,:,2);
I = double(I);
I= (I - min(I(:))) / (max(I(:)) - min(I(:)));
pixeles_fondo = numel(find(I>0.34));
pixeles_fondo
I = medfilt2(I, [3 3]);
imshow(I>0.34);
%% Umbralado con OTSU
GT = imread('bife_opt.JPG');

%aplico dos veces OTSU
level = graythresh(I);
BW = im2bw(I,level);
level2 = graythresh(I(BW));
BW2 = im2bw(I,level2);
filtrada = medfilt2(I, [20 20]);

%cantidad de pixeles negros 
%mat = [1 0 0 0]; para probar el calculo de pixeles negros
pixeles_ojo = numel(find(BW2==0))
pixeles_fondo - pixeles_ojo
%%
%mostrar imagenes
figure('Name','Otsu Method');
%imagen original
subplot(1,3,1); imshow(GT);
%imagen con un solo filtro OTSU
subplot(1,3,2); imshow(BW);
%imagen con OTSU dos veces
subplot(1,3,3); imshow(filtrada);

%%
%Snakes


y=[121 239 349 245 135];
x=[216 188 218 295 273];
P=[x(:) y(:)];

% Opciones
Options=struct;
Options.Verbose=true;

%Variar un solo valor a la vez
Options.Alpha = 0.2; %2.0
Options.Beta = 0.2; %0.2
Options.Kappa = 6; %0.2 %Fuerza externa

Options.Iterations=350;
[O,J]=Snake2D(filtrada,P,Options);

% Show the result
figure('Name','Snakes');
subplot(2,2,1); imshow(I);
subplot(2,2,2); imshow(GT);
subplot(2,2,3); imshow(J);
Irgb(:,:,1)=I;
Irgb(:,:,2)=I;
Irgb(:,:,3)=I+J;
subplot(2,2,4); imshow(I);
hold on;
plot([O(:,2);O(1,2)],[O(:,1);O(1,1)],'g');
hold off;

%%
%Region growing
close all;
clc;

GT = imread('bife_opt.jpg');
x=243; y=213; %Semilla

%Preprocesamiento - Probar con y sin preprocesamiento
%sigma = 3;
%h = fspecial('gaussian',ceil(3*sigma)+1,sigma);
%I = imfilter(I,h);

%Variar distancia
distanciaIntensidad = 0.05; %0.01 0.1
J = regiongrowing(I,x,y,distanciaIntensidad); %Método
J = medfilt2(J, [10 10]);
J = medfilt2(J, [10 10]);

%Mostrar resultados
figure('Name','Region Growing');
subplot(2,2,1); imshow(I);
subplot(2,2,2); imshow(GT);
subplot(2,2,3); imshow(J);
subplot(2,2,4); 
Irgb(:,:,1)=I;
Irgb(:,:,2)=I;
Irgb(:,:,3)=I+J;
imshow(Irgb,[]);

