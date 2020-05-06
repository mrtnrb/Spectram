%% Example script for a typical analysis using Spectram toolbox. 
% A typical data analysis using SVD-based MLS by Spectram.
%
% Copyright (c) 2019 Martin Rabe

%% 0. For GNU Octave only: Load the optim package
% In Octave, first the optim package must be loaded.
% When not installed, the optim package and its dependencies must 
% be installed by:
% pkg install -forge io struct statistics optim 
%
% Only in Octave uncomment the following line to load optim:
% pkg load optim

%% 1. Load some data
% The loading routine should provide:
%%
% * The absorbance/intensity/... array, here A.
% * The vector with an energy equivalent
% (wavelength/wavenumber/frequency/...), here wvnr.
% * The control variable (time/temperature/potential/...), here c.
SpectralData = load ('sim_example_data.dat');
A = SpectralData(:,2:end);       
wvnr = SpectralData(:,1);
c = [10:5:80];

%% 2. Choose a rank
% Different criteria are discussed in detail by:
% Hendler et al. 1994, J Biochem Bioph Methods 28, 1-33.
% Here visual Inspection of U, S, and V is applied. 
global rnk
h = RnkFinder(wvnr,c,A);
waitfor(h.fig);


%% 3. Define a transition model
% A model for usage within Spectram consists of a cell array that 
% contains handles to anonymous model functions. The model array 
% is of size [1,n] with n the number of (c-dependent) transitions.
%
% Create a simple sigmoidal model, from the standard library provided by the
% model_fun class:
n = 2;
[Model ,Paralist] = simple_model(model_fun.sigmoid, n, 1);

%%
% In the following steps parameter vectors are needed. The order of the 
% parameters in the parameter vectors is specified in the parameter name 
% list 'Paralist' that is returned above by simple_model(...):
disp(Paralist)

%%
% Models can also be created manually as cell array of anonymous functions 
% (for more details see: creating_advancedmodel.m). Then the parameter name 
% list is created by the function vecpar(...):
Model2 = {model_fun.sigmoid, @(c)ones(size(c)).*1};
Paralist2 = vecpar(Model2)

%% 4. Choose/vary start parameters and/or bounds
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
% Alternatively, the result matrices and further matrices, useful for the
% assesment can be calculated by:
[F, D, A_fit, V_fit] = matres(A, c, Model, paramout, rnk);

%%
% An example how to plot to asses the results and the fit quality is given
% by f = plotmatres(...). This function first calls matres(...), then plots 
% the results and returns the figure handle.
f = plotmatres(A, wvnr, c, Model, paramout, rnk);

%%
% It might be necessary to repeat steps 2.-6. with different input
% parameters until satisfying results are obtained.
%
