function [ Paralist, varargout ] = vecpar( Model )
%Return list of parameter names from model cell array
%   Usage:
%   PARALIST = vecpar(MODEL)
%   PARALIST is a list that associates the model parameter names to their 
%   values by their position in the  parameter vector PARAS. PARAS is
%   needed as input for eval_model(...) and recombfit(...).
%   MODEL is a model cell array containing handles to anonymous function 
%   that fullfill the requirements for a model function. These requirements 
%   are described in detail creating_advancedmodel.m
%   
%   [PARALIST, PARAZEROS] = vecpar(MODEL)
%   PARAZEROS is a parameter vector containing zeros. Can for instance be
%   used as start parameters.
% Martin Rabe, 2019

Paramap = mappar(Model);

% make parameter vector from map
Paralist = Paramap(~cellfun(@isempty,Paramap));
varargout{1} = zeros(size(Paralist));

end

