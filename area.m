%OTSU'S
close all;
clear;
clc;

%esto es conflicto
I = imread('bife.JPG');
%contar la cantidad de pixeles negros
I = I(:,:,2);
pixeles_fondo = numel(find(I<100));
pixeles_fondo
%% Umbralado con OTSU
GT = imread('bife.JPG');

%aplico dos veces OTSU
level = graythresh(I);
BW = im2bw(I,level);
level2 = graythresh(I(BW));
BW2 = im2bw(I,level2);
filtrada = medfilt2(BW2, [100 100]);

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
subplot(1,3,3); imshow(BW2);

%puto el que lee
