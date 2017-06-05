function gpro2vtk(data,vel,linespace,firsty,filename,fl)
% gpro2vtk(data,vel,linespace,firsty,'filename',fl)
%
% Write GPR data out to VTK file. 
%
% INPUT: 
% 
% data          your GPR data
% vel           velocity [m/ns]
% linespace     space between parallel y lines
% firsty        y coordinate of the first line
% filename      output vtk file name (input requires string form: 'filename')
% fl            which lines have flipped "colors"? Flip them back
%               Example: line 2 and 7 are flipped, then fl=[2,7]
%
% Last modified by plattner-at-alumni.ethz.ch, 01/20/2016

defval('fl',[])

gpr=permute(data.gprdata,[2,3,1]);
for i=1:length(fl)
    gpr(:,fl,:)=-gpr(:,fl,:);
end

[Nx,Ny,Nz]=size(gpr);

ax=data.finalex(2)-data.finalex(1);
ay=linespace;
az=(data.finalti(2)-data.finalti(1))*0.5*vel;
sx=data.finalex(1);
sy=firsty;
sz=0;

fid = fopen([filename '.vtk'], 'w');
fprintf(fid,'# vtk DataFile Version 2.0\n');
fprintf(fid,'Volume example\n');
fprintf(fid,'BINARY\n');
fprintf(fid,'DATASET STRUCTURED_POINTS\n');
fprintf(fid,'DIMENSIONS %d %d %d\n',Nx,Ny,Nz);
fprintf(fid,'ASPECT_RATIO %d %d %d\n',ax,ay,az);
fprintf(fid,'ORIGIN %d %d %d\n',sx,sy,sz);
fprintf(fid,'POINT_DATA %d\n',Nx*Ny*Nz);
fprintf(fid,'SCALARS GPR float 1\n');
fprintf(fid,'LOOKUP_TABLE default\n');
fwrite(fid, gpr(:),'float','ieee-be');