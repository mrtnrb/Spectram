classdef model_fun
    %Library containing anonymous functions that can be used as transition
    %models
    %   The functions can be retrieved by fun = model_fun.MODELNAME
    %   MODELNAME: name of the model function. A full list of all models
    %   can be retrieved by: properties(model_fun).
    % Copyright (c) 2019 Martin Rabe
    
    properties (Constant = true)
        % Sigmoidals
        sigmoid_m_bl = @(c, bl, m, c_mid, del)...
                        (bl+(m-bl)./(1+exp((c_mid-c)./del)));
        sigmoid_bl   = @(c, bl, c_mid, del)...
                        (bl+(1-bl)./(1+exp((c_mid-c)./del)));
        sigmoid      = @(c, c_mid ,del)...
                        (1./(1+exp((c_mid-c)./del)));
        
        % Exponentials
        exp_lin_bl   = @(c, a, b, m, n)...
                        (a.*exp(b.*c)+m.*c + n);
        exp_const_bl = @(c, a, b, n)...
                        (a.*exp(b.*c) + n);
        expdec       = @(c, b)...
                        (exp(-b.*c));
        invexpdec    = @(c, b)...
                        (-1.*exp(-b.*c)+1);
        
        %linear
        liner = @(c, m, n)...
                 (m.*c+n);
        
        %constants
        const       = @(c, const)...
                       ones(size(c)).*const;
        const_ones  = @(c)...
                       ones(size(c))
    end
    
end

