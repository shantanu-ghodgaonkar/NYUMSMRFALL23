function maxWindow
%MAXWINDOW - Maximize figure window
%
%Syntax: maxWindow

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

screen=get(0,'screensize');
if screen(3)==800
 set(gcf,'Units','normalized','Position',[0 0.0467 1.00 0.84])
elseif screen(3)==1024
 set(gcf,'Units','normalized','Position',[0.00 0.032 1.00 0.92])
elseif screen(3)==1152
 set(gcf,'Units','normalized','Position',[0.00 0.032 1.00 0.89])
elseif screen(3)==1280
 set(gcf,'Units','normalized','Position',[0.00 0.032 1.00 0.895])
elseif screen(3)==1440
 set(gcf,'Units','normalized','Position',[0.00 0.032 1.00 0.895])
elseif screen(3)==1600
 set(gcf,'Units','normalized','Position',[0.00 0.032 1.00 0.905])
end 