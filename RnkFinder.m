%Creates GUI to aid finding the rank. Returns figure handle h. Within the
%GUI the global variable 'rnk' is defined, which can be used in the desired
%workspace.
%   Usage:
%   H = RnkFinder(X, C, A)
%   H: Handle for the created figure.
%   X: vector containing the values for the energy equivalent independent
%   variable to A(X).
%   C: Vector containing values of the control variable.
%   A: Spectrum array.
%   To use the global variable  'rnk' and to wait for closing the GUI one
%   may use:
%       global rnk
%       h = RnkFinder(X,C,A);
%       waitfor(h.fig);
%
% Copyright (c) 2019 Martin Rabe

function h = RnkFinder (x, c, A)


%   ## set up figure and axis
  h.fig = figure("position", [50 150 1300 350]);
  h.ax1 = axes ("position", [0.05 0.2 0.25 0.7]);
  h.ax2 = axes ("position", [0.375 0.2 0.25 0.7]);
  h.ax3 = axes ("position", [0.7 0.2 0.25 0.7]);
%   ## initiate SVD
  h.x = x;
  h.c = c;
  [h.U, h.S, h.V] = svd(A, 0);

%   ##  texts                               
  h.text_1 = uicontrol ("style", "text",...
                        "units", "normalized",...
                        "string", "Plot until rank = ",...
                        "position", [0.71 0.04 0.1 0.06]);
                        
%   ##  edit  
  h.edit_1 = uicontrol ("style", "edit",...
                        "units", "normalized",...
                        "string", "3",...
                        "callback", @update_plot,...
                        "position", [0.8 0.04 0.02 0.06],...
                        "backgroundcolor", "white",...
                        "tooltipstring", "Enter a number and hit return to refresh plots.");
                                 
  h.ok_button = uicontrol ("style", "pushbutton",...
                           "units", "normalized",...
                           "string", "Done",...
                           "callback", @closefun,...
                           "position", [0.85 0.04 0.1 0.06],...
                           "tooltipstring", "Press it, when you are done.");


  guidata (gcf, h);
  update_plot (gcf);
  
function closefun(obj,evt)
  close(gcbf)
  

function update_plot (obj, evt)
  
  h = guidata (obj);
  global rnk
  rnk = round(str2num(get(h.edit_1,'string')));
  
%   ##  check limits for rnk
  if rnk < 1
      rnk = 1;
  elseif rnk > length(h.c)
      rnk = length(h.c);
  end
  
  set(h.edit_1, 'string', num2str(rnk))
  
%   ##axes 1
  plot(h.ax1, h.x, h.U(:,1:rnk));
  xlabel(h.ax1,'x');
  ylabel(h.ax1,'U');
  set(h.ax1,'box','on')
  
%   ##axes 2
  plot(h.ax2, h.c, h.V(:,1:rnk));
  xlabel(h.ax2,'c');
  ylabel(h.ax2,'V');
  set(h.ax2,'box','on')
  
%   ##axes 3
  hold(h.ax3, 'off')
  plot(h.ax3, h.c, log10(diag(h.S(:,:))), 'o');
  hold(h.ax3, 'on')
  plot(h.ax3, h.c(1:rnk), log10(diag(h.S(1:rnk,1:rnk))), 'o');
  xlabel(h.ax3,'c');
  ylabel(h.ax3,'lg(diag(S))');
  set(h.ax3,'box','on')
   
  guidata(obj, h);



