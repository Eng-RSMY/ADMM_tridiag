function [sense_maps, body_coil, Sxtrue] = sim_setup();
%function [sense_maps, body_coil, Sxtrue] = sim_setup();
% setup file for simulation image
%

Nx = 240;
Ny = 200;
Nc = 6;

img = make_sim_image(Nx, Ny);
sense_maps = mri_sensemap_sim('nx', Nx, 'ny', Ny, 'ncoil', Nc, 'rcoil', 3*min(Nx, Ny));
mask = generate_mask('sim', 0, Nx, Ny);
sense_maps = truncate_sense_maps(sense_maps, mask);

Sxtrue = repmat(img, [1 1 Nc]).*sense_maps;
body_coil = img;

