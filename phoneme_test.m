% Single iteration of updating the weight
% This function takes 2  arguments
% This function outputs the final weight of that iteration
function [res] = phoneme_test(in,file,phn)   % Function declaration 
% Takes 2 inputs => in is the input filename, out is the output vector
% Returns updated weight
   out = [1 0];
   filematch = 1;
   input = importdata(in); % Parses input file and gets the input matrix
   fp=fopen("F:\project\Speech Data\phonemix1024.cpp"); % Opens weight file
   weight = []; % Creates empty weight
   dat = fgetl(fp); % Reads the weight file, line by line
    % while (dat(1) ~= ".")  % Checks for the end of chunk
    counter = 0;
    while(dat ~= -1) % Reads till the end
    %while(counter < 7) %%%%%%%%%%%%%%%%%%%%%%%%%%%% change value from 20 %%%%%%%
      if(dat(1) == '"')
          filematch = 1;
          if (size(strfind(dat,file)) ==0)
              filematch = 0;
          else
              disp("Iteration begin for ");
              disp(dat);
              dat = dat(2:(length(dat)-1));
              weight = importdata(string(dat));
          end
      elseif (dat(1) == '#' && filematch)
           disp("Starting");
      elseif (dat(1) == '.' && filematch)
          counter = counter + 1;
          disp(counter);
          disp("Iteration ending");
          s = strcat('F:\project\Speech Data\OUTPUT\file', num2str(counter));
          s = strcat(s,'.mfc');
          % csvwrite(s,weight);
          dlmwrite(s, weight, 'delimiter', '\t', 'precision', '%3.6f')
          weight = [];
      elseif (filematch)
          A = sscanf(dat,'%ld');
          start_id = A(1) / 100000 + 1;
          end_id = A(2) / 100000 + 1;
          disp(start_id);
          disp(end_id);
          if(size(strfind(dat,phn)) ~=0)
            weight(start_id:end_id,:) = NeuralNet(input,weight(start_id:end_id,:),out);
          end
          
      end
      dat = fgetl(fp);
    end
       fclose(fp);
   res = weight;
end 
