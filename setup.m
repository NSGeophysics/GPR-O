function setup()

disp('Downloading external m-files from Luca Baradello website for reading PulseEkko Pro files')

mkdir('ext')
websave('ext/dt1read.m','http://www.lucabaradello.it/files/dt1read.m')
websave('ext/dt1struct.m','http://www.lucabaradello.it/files/dt1struct.m')
websave('ext/headerstruct.m','http://www.lucabaradello.it/files/headerstruct.m')
websave('ext/dimstruct.m','http://www.lucabaradello.it/files/dimstruct.m')