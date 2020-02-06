function [ F, D, varargout ] = matres( A, c, model, paras, rnk, varargin)
%Returns result arrays of SVD based decomposition - recombination approach.
%   Detailed explanations of the returned arrays can be found in the 
%   associated paper and in: 
%
%   Usage:
%   [F, D] = matres(A, C, MODEL, PARAS, RNK)
%   F: the C- dependent transitions as solutions of MODEL with the
%   parameters PARAS.
%   D: The isolated spectral components associated to the transitions in F.
%   C: Vector containing values of the control variable.
%   A: Spectrum array.
%   MODEL: Transition model.
%   PARAS: Parameters for MODEL as defined by PARALIST returned by 
%   PARALIST = vecpar(MODEL).
%   RNK: Rank used for fitting by recombfit(..., RNK, ...).
%   for details on A, C, MODEL and RNK see doc(recombfit).
%
%   [F, D] = matres(A, C, MODEL, PARAS, RNK, 'lownoise')
%   Returns D calculated from rank deficient A. This may reduce noise but
%   also it might (falsely) mask the influence of higher order spectral 
%   components during assesment.
%
%   [F, D, A_FIT] = matres(...)
%   Additionaly returns the data array reconstructed from F and D. A_FIT
%   can be used to assess quality of the results.
%
%   [F, D, A_FIT, V_FIT] = matres(...)
%   Additionaly returns array V reconstructed from F and D. V_FIT can be 
%   used to assess quality of the results, by comparison with V returned by: 
%   [~,~,V] = svd(A, 0).
%
% Copyright (c) 2019 Martin Rabe


[U,S,V] = svd(A, 0);

%% linear algebra
F = eval_model(c, model, paras); 

H=V(:,1:rnk)'*pinv(F');


D = A*pinv(F'); %this is the way porposed by Shrager 1986, using the full dataset.

if  ~isempty(varargin) && (varargin{1} == 'lownoise')
    D = U(:,1:rnk)*S(1:rnk,1:rnk)*H; %this way the shortened (noise reduced) data is used
end

A_fit=D*F'; %reconstruction of data from fit results

V_fit = (H*F')'; %this would be another valid way to calculate the fitted V (same as in Shrager 1986)

varargout{1} = A_fit;
varargout{2} = V_fit;


