% Single iteration of updating the weight
% This function takes 2  arguments
% This function outputs the final weight of that iteration
function [res] = phoneme_test(line_id)   % Function declaration 
% Takes 2 inputs => in is the input filename, out is the output vector
% Returns updated weight
  out = [1 0];
  weight = importdata("weight.mfc"); % Parses input file and gets the input matrix
  fp=fopen("Speech Data/phonemix1024.cpp"); % Opens weight file
  gp="sp aa ch ey ow r n g uh l ax m b ae d iy k er ih dh t p sh ao s th ng eh v nh oy uw hh f chh ay ah dha gh z kh aw h i zh jh j ky y w bh u sil";
  phn = strsplit(gp)(1,line_id);
  if(line_id == 54);
    line_id = 53;
  end
  input = []; % Creates empty weight
  dat = fgetl(fp); % Reads the weight file, line by line

  % while (dat(1) ~= ".")  % Checks for the end of chunk
  counter = 0;
  while(dat ~= -1 && counter < 3001); % Reads till the end
    if(dat(1) == '"');
      disp("Iteration begin for ");
      disp(dat);
      dat = dat(2:(length(dat)-1));
      input = importdata(dat);
      counter = counter + 1;
    elseif(dat(1) == '#' || dat(1) == '.');
      dat = fgetl(fp);
      continue;
    else(size(strsplit(dat))(2) > 3); 
      k = strsplit(dat)(1,3);
      % disp('Comparing '), disp(phn), disp(' to '), disp(k);
      s =strcmp(k,phn);
      if(s ~= 0);
      A = sscanf(dat,'%ld');
      start_id = A(1) / 100000 + 1;
      end_id = A(2) / 100000 + 1;
      weight(line_id,:) = NeuralNet(input(start_id:end_id,:),weight(line_id,:),out);
      % disp(weight(line_id,:));
      end
    end
    dat = fgetl(fp);
    fflush(stdout);
  end
  fclose(fp);
  res = weight(line_id,:);
end 
