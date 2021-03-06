%% Example for creating advanced models
% This example shows how to manually create and evaluate models.
%
% Copyright (c) 2019 Martin Rabe

%% Model creation
% Models can be created 'manually'. Handles to anonymous functions must be 
% provided in the form @(C,P1,P2,...PN)(fun). With C being
% the independent (control variable) and P1...PN are the parameter used in 
% fitting. Constants should not be stored in the anonymous function because
% they will get lost. For keeping parameters fixed during fitting they 
% should be stated directly, i.e.:
%%
  q = 3;
  fh = @(c,p)(p.*c+q); 
%%
% should be avoided. Instead, use:

  fh = @(c,p)(p.*c+3);
%%
%
% Also, any Matlab function myfun with y = myfun(varargin) can be 
% used as shown below:

Model = {@(c,b,f) sin(c/b)+f ...
         @(c,a0,a1,a2) polyval([a2,a1,a0],c)...         
         @(c, cstep) double(c>=cstep)...
         model_fun.invexpdec};
    
%% Evaluation of the model    
% For any model a parameter name vector and an array of zeros of the necessary 
% format for model evaluation can be generated by the vecpar() function:

[Paranames, Parameters] = vecpar(Model);

%%
% The model can then be evaluated by:
c = 1:10;
value = eval_model(c, Model, Parameters);

