function [Paramap, varargout] = mappar( model, varargin )
%Returns parameter map and parameter array from model.
%   A parameter map associates the position of a value in the parameter
%   array to the name of the parameter. The name of the parameter is formed
%   from the name of the parameter in the model function + the index of
%   the model function in the model cell array. Parameter maps are used
%   internally and the standard user should not need them.
%   need to use 
%   
%   Usage: PARAMAP = mappar(MODEL)
%          PARAMAP: parameter map for MODEL. MODEL is cell array containing
%          function handles to anonymous functions that fullfill the 
%          requirements for a model function. These requirements 
%          are described in detail creating_advancedmodel.m
%          
%          [PARAMAP, P] = mappar(MODEL)
%          P: parameter array containing zeros.
%          
%          [PARAMAP, P] = mappar(MODEL, PARAS)
%          P: parameter array containing the parameters in
%          PARAS ordered according to PARAMAP. PARAS: parameter vector as
%          returned by [~, PARAS] = vecpar(MODEL), or fit parameters returned
%          by recombfit(...).
%
% Copyright (c) 2019 Martin Rabe

%crawl through the model and extract the parameter names and counts
NumParas = 0;
for modelNo = 1:length(model)
    
    % take apart the input argument str the first input argument is ignored
    funStr = func2str(model{modelNo});
    %here it is assumed that the anonymous function starts with '@('
    %followed by a comma separated list of arguments, followed by ')'
    closbrack = strfind(funStr, ')');
    ParametListStr = funStr(2:closbrack(1));
    commas=strfind(ParametListStr,',');
    delimiters = [commas, closbrack(1)-1];
     
    for paramnr = 1:length(delimiters)-1
        NumParas = NumParas + 1;
        Paramap{paramnr,modelNo} = ...
            [ParametListStr(delimiters(paramnr)+1:delimiters(paramnr+1)-1)...
             '_' num2str(modelNo)];
        if nargin > 1
            paras(paramnr,modelNo) = varargin{1}(NumParas);
        else
            paras(paramnr,modelNo) = 0;
        end
    end
    %ensure that an empty spaces is included for constant models:
    if isempty(commas)
        Paramap{1,modelNo} = [];
        paras(1,modelNo) = NaN;
    end
    %replace [] by empty cells;
    Paramap(~cellfun(@ischar,Paramap))={''};
end
% paras = zeros(size(Paramap));
paras(cellfun(@isempty,Paramap)) = NaN;
varargout{1} = paras;

