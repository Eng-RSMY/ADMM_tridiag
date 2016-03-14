clear;
tridiag_setup;

orient = 'axial'; slice = 38; truncate = 2;
exp_ADMM_ALP2;
display('done with slice 38')

orient = 'axial'; slice = 90; truncate = 2;

exp_ADMM_ALP2;
display('done with slice 90');

clear;
orient = 'sim';
exp_ADMM_ALP2;
display('done with sim');

send_mai_text('done with all tests on mpel8')