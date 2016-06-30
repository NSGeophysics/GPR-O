
more off
%graphics_toolkit('fltk')

try pkg load io
catch
  disp('Installing io pkg from forge. This may take a minute.')
  pkg install -forge io
  disp('done')
  pkg load io
end

try pkg load statistics
catch
    disp('Installing statistics pkg from forge. This may take a minute.')
    pkg install -forge statistics
    disp('done')
    pkg load statistics
end

initialize