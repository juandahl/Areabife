%OTSU'S
close all;
clear;
clc;

GT = imread('bife_opt.JPG');
I = GT(:,:,2);
%normalizar la imagen
I = double(I);
I= (I - min(I(:))) / (max(I(:)) - min(I(:)));

%%
%mostrar imagenes
figure('Name','Original y banda verde');
%imagen original
subplot(1,2,1); imshow(GT);
subplot(1,2,2); imshow(I);


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
distanciaIntensidad = 0.07; %0.01 0.1
J = regiongrowing(I,x,y,distanciaIntensidad); %Método
J = medfilt2(J, [20 20]);


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

%%
%
close all;
I = GT(:,:,1);
%normalizo imagen banda Roja
I = double(I);
I= (I - min(I(:))) / (max(I(:)) - min(I(:)));
%saco la moda, el que mas se repite dentro del ojo calculado
mode_number = mode(I(J))

range = 0.03;

mask = I;
mask(I>=mode_number-range) = 1;
mask(I<mode_number-range) = 0;
mask = logical(mask);
mask_m = I;
mask_m(I>mode_number+range) = 0;
mask_m(I<=mode_number+range) = 1;
mask_m = logical(mask_m);
final = and(mask_m, mask);

figure();
subplot(1,4,1); imshow(GT);
subplot(1,4,2); imshow(mask);
subplot(1,4,3); imshow(mask_m);
subplot(1,4,4); imshow(final);
