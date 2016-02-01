function mu = get_mu(SS, Nr, lambda, varargin)
%function mu = get_mu(eigvalss)
% set mu for nice condition numbers, based on AL-P2 splits

% vals for x_tri_inf with beta = 2^19 and SNR 40 on slice 67
arg.edge = 13600; % pixel diff for an edge 
arg.noise = 9300; % pixel diff for noise
%arg.edge = 13600*10; % pixel diff for an edge 
%arg.noise = 9300*10; % pixel diff for noise
arg.split = 'AL-P2'; % 'ADMM-tridiag'
arg = vararg_pair(arg, varargin);

SSmax = max(col(abs(SS)));
SSmin = min(col(abs(SS)));

mu_v = mean(lambda./[arg.edge arg.noise]);

% kappa_u = (Nr + mu_u)/mu_u
%ku = @(mu, Nr) (Nr + mu(1)) / mu(1);

% kappa_z = (4 + mu_z)/mu_z for only horizontal and vertical finite diff
%kz = @(mu) (4 + mu(3)) / mu(3);

% kappa_x = (mu_u * SSmax + mu_z)/(mu_u * SSmin + mu_z)
%kx = @(mu, SSmax, SSmin) (mu(1) * SSmax + mu(3)) / (mu(1) * SSmin + mu(3));

% x = [mu_u, mu_z]
kappas = @(x) [ (Nr + x(1)) / x(1); (4 + x(2)) / x(2); (x(1) * SSmax + x(2)) / (x(1) * SSmin + x(2))];


x0 = ones(1,2);
%for ii = 1:10
x = lsqnonlin(kappas, x0, zeros(1,2), Inf(1,2));
%end
%display('there are some vals');
%keyboard
%kappas(x)

switch arg.split
	case 'AL-P2'
		mu = [x(1); mu_v; x(2)];
	case 'ADMM-tridiag'
		mu = [mu_v; mu_v; x(1); x(2); x(2)];
	otherwise
		display(sprintf('unknown splitting scheme %s', arg.split));
		keyboard
end


