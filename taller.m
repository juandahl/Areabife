clear all;
clc;

I = imread('bife.png');
GT = imread('bife.png');
GT = GT(1:3340, :, 1);
I = double(I);
I= (I - min(I(:))) / (max(I(:)) - min(I(:)));
%I= I(:,:,1);
I= I(1:3340, :, 1);
figure(1), imshow(I);

%%
I(I > 0.34) = 1;
figure(2), imshow(I)

%%

y=[1579 1579 1586 1598 1596];
x=[1389 1411 1421 1415 1402];
P=[x(:) y(:)];

% Opciones
Options=struct;
Options.Verbose=true;

%Variar un solo valor a la vez
Options.Alpha =  0.2 %0.2; %2.0
Options.Beta =  0.2; %0.2
Options.Kappa =  6; %0.2 % 6; %0.2 %Fuerza externa

Options.Iterations=40;
[O,J]=Snake2D(I,P,Options);

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

