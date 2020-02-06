function [ Model, varargout] = simple_model( fun, n, const )
%Return cell array with transition models and optionally a parameter name 
%list and a vector of parameters 0. 
%   Usage: 
%       MODEL = simple_model(FUN, N, CONST)
%       Returns model cell array of function handels to anonymous functions
%       that represent transition models. In MODEL the first N cells 
%       contain FUN and the last is a constant function of the value CONST.
%       FUN can be for instance created from the model functions library
%       'model_fun' or can be any handle to an anonymous function that 
%       fullfills the requirements for a model function. These requirements 
%       are described in detail creating_advancedmodel.m
%
% Copyright (c) 2019 Martin Rabe

for compNr = 1:n
    
    Model{compNr} = fun;
    
end

Model{n+1} = str2func(['@(c)ones(size(c)).*', num2str(const)]);


[Paralist, P] = vecpar(Model);
varargout{1} = Paralist;
varargout{2} = P;



