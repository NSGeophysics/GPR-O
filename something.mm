function setup()

disp('Downloading external m-files from Luca Baradello website for reading PulseEkko Pro files')

mkdir('ext');
urlwrite('http://www.lucabaradello.it/files/dt1read.m','ext/dt1read.m');
urlwrite('http://www.lucabaradello.it/files/dt1struct.m','ext/dt1struct.m');
urlwrite('http://www.lucabaradello.it/files/headerstruct.m','ext/headerstruct.m');
urlwrite('http://www.lucabaradello.it/files/dimstruct.m','ext/dimstruct.m');
