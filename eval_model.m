function F = eval_model( c, model, paras)
%Evaluation of a transition model. Returns function values for the
%transition models.
%   Usage:
%   F = eval_model(C, MODEL, PARAS)
%   F array containing the function values for MODEL in C with the
%   parmeter vector PARAS. PARAS contains the parameters in the order
%   specified by the parameter name list PARALIST returned by
%   PARALIST = vecpar(MODEL).
%
% Martin Rabe, 2019

[~, P] = mappar (model, paras);

% for enabling evaluation of the model P as cell structure is needed.
P = num2cell(P);

F = zeros(length(c), length(model));
for modelNo = 1: length(model)
    for cPos = 1:length(c)
        F(cPos ,modelNo) = model{modelNo}(c(cPos),...
                           P{~isnan(cell2mat(P(:,modelNo))),modelNo});
    end
end






