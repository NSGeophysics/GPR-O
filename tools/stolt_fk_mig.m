function dataout=stolt_fk_mig(data,vel,lines,fLow,fHigh)
% dataout=stolt_fk_mig(data,vel,lines,fLow,fHigh)
%
% Stolt fk migration. A direct copy-paste of the program
% learn_stolt.m by  Martin H. Skjelvareid,
% https://github.com/mh-skjelvareid/synaptus/blob/master/learn/learn_stolt.m
%
% INPUT:
%
% data       input data in GPR-O format
% vel        estimated radar velocity for subsurface in m/ns 
% lines      for which lines do you want to calculate the migration
% fLow       cut all frequencies below this [Hz]
% fHigh      cut all frequencies above this [Hz]
%
% OUTPUT:
%
% dataout    GPR-O data with stolt f-k migrated sections. Resampled
%
% Original by Martin H. Skjelvareid, 01/03/2016  
% Last modified by plattner-at-alumni.ethz.ch, 5/22/2017

defval('fLow',1e5);       
defval('fHigh',1e9);

%% Turn time into seconds
vel=vel*1e9;
data.finalti=data.finalti*(1e-9);

%% Set all the required variables. The names and everything are (almost)
%% exactly as in  Martin H. Skjelvareid's learn_stolt. I wish it were
%% written as a function with data input such that I could just git
%% clone it instead of needing to copy it here. It is all his work.

nT=length(data.finalti);
nX=length(data.finalex);
xStep=1/(data.finalex(2)-data.finalex(1));
  
zStart=min(data.finalti)*vel/2;
zEnd=max(data.finalti)*vel/2;
dz=(vel/2)/(fHigh-fLow);  
fs=1/(data.finalti(2)-data.finalti(1));
nZ=length(zStart:dz:zEnd);

tt=(0:(nT-1))/fs;
xx=(0:(nX-1))*xStep;
zz=(0:(nZ-1))*dz;

dataout.finalti=2*zz/(vel/1e9);
dataout.finalex=xx;

nFFTt = 2^nextpow2(nT);                    
nFFTx = 2^nextpow2(nX);                    
nFFTz = 2^nextpow2(nT*(fHigh-fLow)/(fs/2));
  
omega = ((0:(nFFTt-1)) - floor(nFFTt/2))*((2*pi*fs)/nFFTt);
omega = ifftshift(omega);
omegaBandInd = (omega <= -2*pi*fLow) & (omega >= -2*pi*fHigh);  
omegaBand = omega(omegaBandInd);

kxs = (2*pi)/xStep;                               
kx = ((0:(nFFTx-1)) - floor(nFFTx/2))*(kxs/nFFTx);
kx = ifftshift(kx);   


kzs = (2*pi)/dz;                                        
kz = (2*pi*fLow)/(vel/2) + (0:(nFFTz-1))*(kzs/nFFTz);    
kz = -kz(end:-1:1);  


for li=1:length(lines)
  %% Fourier transform
  Pokx = fft2(data.gprdata(:,:,lines(li)+1),nFFTt,nFFTx);
  %% Cut the part of spectrum that we don't want
  Pokx = Pokx(omegaBandInd,:);
  
  %% Resample at higher resolution
  upSamp = 4;
  nOmegaBand = length(omegaBand);
  dOmega = ((2*pi*fs)/nFFTt);
  Pokx = fft(ifft(Pokx),upSamp*nOmegaBand);
  tmp = (0:(nOmegaBand*upSamp-1))*(dOmega/upSamp);
  omegaBand = -tmp(end:-1:1) + omegaBand(end);

  tDelay=0;
  [OMEGA,KX] = ndgrid(omegaBand,kx); 
  Pokx = Pokx.*exp(-1i*OMEGA*tDelay);
  
  %% For spectrum resampling
  [KZ_st,KX_st] = ndgrid(kz,kx);
  KK2_st = (KZ_st.^2 + KX_st.^2);                 
  KK_st = -sqrt(KK2_st .* (KK2_st > 0)); 
  Akzkx = 1./(1 + (KX_st.^2)./KZ_st.^2);     
  Akzkx(isnan(Akzkx)) = 1;
  OMEGA_st = (vel/2)*KK_st; 
  %% Resample the spectrum
  Pkzkx = complex(zeros(nFFTz,nFFTx));
  for jj = 1:nFFTx
    Pkzkx(:,jj) = interp1(omegaBand,Pokx(:,jj),OMEGA_st(:,jj));
  end
  %% Set NaN values to 0
  nonValid = (isnan(Pkzkx)) | (OMEGA_st < omegaBand(1)) | ...
    (OMEGA_st > omegaBand(end));
  Pkzkx(nonValid)=0;
  %% Rescale amplitudes
  Pkzkx = Pkzkx.*Akzkx;
  %% Shift back to start
  Pkzkx = Pkzkx.*exp(1i*KZ_st*zStart);
  %% Transform back
  im = ifft2(Pkzkx);
  %% im is in pos vs depth coordinates.
  %% But for constant velocity, we can just rescale the coordinate axis
  %% to get time
  dataout.gprdata(:,:,lines(li)+1) = abs(im(1:nZ,1:nX));
  dataout.gprcell{lines(li)+1}=abs(im(1:nZ,1:nX));
end
