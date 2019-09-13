%% Example script for a typical analysis using Spectran toolbox. 
% A typical data analysis using the transition model SVD recombination
% method is described in the following. 
% The basic steps any analysis should
% contain, are: 
% 
% # load some data
% # choose a rank
% # create/load a model
% # choose/vary start parameters and/or bounds
% # decompose and fit
% # evaluate results
% # repeat from 1 until reasonable and stable results are obtained

%% 0. Load the optim package
% In Octave, first the optim package must be loaded. Currently this issues a 
% warning which may be suppressed. Only in Octave uncomment the following 2
% lines:
warning('off', 'Octave:deprecated-function')
pkg load optim

%% 1. Load some data
% The loading routine should provide:
%%
% * The absorbance/intensity/... array, here A.
% * The vector with an energy equivalent
% (wavelength/wavenumber/frequency/...), here wavenumber.
% * The control variable (time/temperature/potential/...), here c.
SpectralData = load ('sim_example_data.dat');
A = SpectralData(:,2:end);       
wvnr = SpectralData(:,1);
c = [10:5:80];

%% 2. choose a rank
% Different criteria are discussed in detail by:
% Hendler et al. 1994, J Biochem Bioph Methods 28, 1-33.
% Here visual Inspection of U, S, and V is applied. 
global rnk
h = RnkFinder(wvnr,c,A);
waitfor(h.fig);


%% 3. Define a transition model
% A model for usage within this package consists of a cell array that 
% contains handles to anonymous model functions. The model array 
% is of size [1,n] with n the number of (c-dependent) transitions.
%
% Create a simple sigmoidal model, from the standard library provided by the
% model_fun class:
n = 2;
[Model ,Paralist] = simple_model(model_fun.sigmoid, n, 1);

%%
% The order of the parameters the parameter vectors, needed for the 
% following steps is specified in the parameter name list 'Paralist' as it 
% is returned above by simple_model(...):
disp(Paralist)

%%
% Model can also be created manually. A detailed explanation for this can 
% be found in creating_advancedmodel.m. The a list of parameter names is
% created by the function vecpar(...):
Model2 = {model_fun.sigmoid, @(c)ones(size(c)).*1};
Paralist2 = vecpar(Model2)

%% 4. choose/vary start parameters and/or bounds
% Three parameter vectors must be constructed that contain start parameters, 
% the lower bounds and and the upper bounds. The order and size of these
% parameter vectors is defined by 'Paralist'. 
% Note: In Octave setting bounds to 0 returns warnings in step 5. For workaround
% set the bounds to very small values close to 0.
startparas = [30; 5; 90; 5];
lb = [1E-18; 1E-18; 1E-18; 1E-18];
ub = [100; 100; 100; 100];

%%
% Also, create an optimization options structure and define the important
% options:
ftopt = optimset ('Tolfun', 1e-18, ...
                  'MaxFunEvals',100000,...
                  'Display', 'iter',...
                  'TolX',1E-18,...
                  'MaxIter', 1000);
              
%% 5. Decompose and fit
% Call recombfit(...) to fit the model to the data.
[paramout,resnorm,residual,exitflag,output] = ...
    recombfit(Model, c, A, rnk, startparas, lb, ub, ftopt);

%% 6. Assesment of the results
% F may be determined by calculating the values for the fitted 
% model, by:
F = eval_model(c, Model, paramout);

%%
% Alternatively, the result matrices and furthe matrices, useful for the
% assesment can be calculated by:
[F, D, A_fit, V_fit] = matres(A, c, Model, paramout, rnk);

%%
% An example how to plot to asses the results and the fit quality is given
% by f = plotmatres(...). This function first calls matres(...), then plots 
% the results and returns the figure handle.
f = plotmatres(A, wvnr, c, Model, paramout, rnk);
