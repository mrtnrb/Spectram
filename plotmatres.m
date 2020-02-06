function [f] = plotmatres(A, x, c, Model, paras, rnk)
%Creates figure to aid result and fit quality assesment. Returns figure
%handle F.
%   Detailed explanations of the plotted arrays can be found in the 
%   associated paper and in Hendler et al. 1994, J Biochem Bioph Methods 
%   28, 1-33. 
%   
%   Usage:
%   F = plotmatres(A, X, C, MODEL, PARAS, RNK)
%   F: Handle for the created figure.
%   A: Spectrum array.
%   X: vector containing the values for the energy equivalent independent
%   variable to A(X).
%   C: Vector containing values of the control variable.
%   MODEL: Transition model.
%   PARAS: Parameters for MODEL as defined by PARALIST returned by 
%   PARALIST = vecpar(MODEL).
%   RNK: Rank used for fitting by recombfit(..., RNK, ...).
%   for details on A, C, MODEL and RNK see doc(recombfit).
%
% Copyright (c) 2019 Martin Rabe

[F, D, A_fit, V_fit] = matres(A, c, Model, paras, rnk);

f=figure('OuterPosition', [170, 190, 870, 750]);
[~,~,V] = svd(A,0);

sp1 = subplot(2,2,1);
plot(c, F )
title('F')
legend(num2str([1:size(F,2)]'))
ylim([-0.1, 1.1]);

sp2 = subplot(2,2,2);
plot(x, D)
title('D')
legend(num2str([1:size(D,2)]'))

sp3 = subplot('Position', [0.13, 0.11, 0.22,  0.3259]);
plot(x, A-A_fit)
title('Residuals A - A_{fit} ')
ylim(0.1*max(get(sp2,'YLim'))*[-1,1]);

sp4 = subplot('Position', [0.4075, 0.11, 0.22,  0.3259]);
plot(x, A, 'o')
hold(sp4, 'on')
set(sp4,'ColorOrderIndex', 1);
plot(x, A_fit)
title('comparison A - A_{fit}')

sp5 = subplot('Position', [0.685, 0.11, 0.22,  0.3259]);
plot(c, V_fit)
hold(sp5, 'on')
set(sp5,'ColorOrderIndex' ,1);
plot(c, V(:,1:rnk), 'o')
title('comparison V - V_{fit}')


end

