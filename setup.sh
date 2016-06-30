
echo
echo Downloading external m-files from Luca Baradello's website for reading PulseEkko Pro files
echo ==========================================================================================
echo

mkdir ext
cd ext

curl -o dt1read.m http://www.lucabaradello.it/files/dt1read.m
curl -o dt1struct.m http://www.lucabaradello.it/files/dt1struct.m
curl -o headerstruct.m http://www.lucabaradello.it/files/headerstruct.m
curl -o dimstruct.m http://www.lucabaradello.it/files/dimstruct.m

cd ..
