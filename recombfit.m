function [ paramout, varargout ] = recombfit(Model, c, A, rnk, startingvs, varargin)
%Performs singular value decomposition (SVD) and global fitting. Returns 
%fitted parameters and optionally the output from the solver lsqnonlin.
%   Details of the method can be found in: 
%   Hendler et al. 1994, J Biochem Bioph Methods 28, 1-33.
%   Shrager 1986 Chemometr Intell Lab Sys 1 59-70.
%   
%   Usage:
%   PARAMOUT = recombfit (MODEL, C, A, RNK, STARTINGVS)
%   PARAMOUT: fitted parameters
%   MODEL: Transition model. A model cell array containing handles to 
%   anonymous functions that fullfill the requirements for a model function.
%   C: Vector containing values of the control variable. These requirements 
%   are described in detail in creating_advancedmodel.m
%   A: spectrum array
%   RNK: Rank, i.e. the number of components od the SVD results, that is
%   used for fitting. (should be the lower limit for the number of
%   transitions i.e. length(MODEL)).
%   STARTINGVS: Vector of start values for the iteration. Order and length
%   of STARTINGVS are specified by the parameter name list PARALIST 
%   returned by PARALIST = vecpar(MODEL).
%
%   PARAMOUT = recombfit (MODEL, C, A, RNK, STARTINGVS, LB, UB)
%   LB, UB: lower and upper bounds, so that the solutions are always 
%   LB ? PARAMOUT ? UB.
%   
%   PARAMOUT = recombfit (MODEL, C, A, RNK, STARTINGVS, LB, UB, OPTIONS)
%   OPTIONS: optimization options. Use optimoptions(...), or optimset(...)
%   to set these options. Pass empty matrices for lb and ub if no bounds 
%   exist.
%
%   [PARAMOUT,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMDA,JACOBIAN] = ...
%   recombfit (...)
%   Additionally returns variables to asses details of the iteration
%   process. Variables are optional and the same as returned by 
%   lsqnonlin(...). See doc('lsqnonlin') for more information.
% 
% Copyright (c) 2019 Martin Rabe




[U,S,V] = svd(A, 0);


% Fit function according to Shrager 1986 
Fitfunhndl = @(Inp)...
        (S(1:rnk,1:rnk)*(V(:,1:rnk)' - (V(:,1:rnk)' * ...
        pinv(eval_model(c, Model, Inp)'))*eval_model(c, Model, Inp)'));

    
switch nargin
    case 5        
    	[paramout,varargout{1},varargout{2},varargout{3},varargout{4}, ...
         varargout{5}, varargout{6}] = lsqnonlin (Fitfunhndl, startingvs); 
    case 6
        error('This shouldnt be')
    case 7
    	[paramout,varargout{1},varargout{2},varargout{3},varargout{4}, ...
         varargout{5}, varargout{6}] = lsqnonlin (Fitfunhndl, ...
                                                  startingvs, ...
                                                  varargin{1},...
                                                  varargin{2}); 
    case 8
         [paramout,varargout{1},varargout{2},varargout{3},varargout{4}, ...
         varargout{5}, varargout{6}] = lsqnonlin (Fitfunhndl, ...
                                                  startingvs, ...
                                                  varargin{1},...
                                                  varargin{2},...
                                                  varargin{3}); 
end
end
