% Single iteration of updating the weight
% This function takes 4  arguments
% This function outputs the final weight of that iteration
function [res] = phoneme_test(in,out)
   input = importdata(in);
   fp=fopen("F:\project\Speech Data\phonemix1024.cpp");
   weight = [];
   dat = fgetl(fp);
   while(dat ~= -1)
      if(dat(1) == '"')
          disp("Iteration begin for ");
          disp(dat);
          dat = dat(2:(length(dat)-1));
          weight = importdata(string(dat));
      elseif (dat(1) == '#')
           disp("Starting");
      elseif (dat(1) == '.')
          disp("Iteration ending");
      else
          A = sscanf(dat,'%ld');
          start_id = A(1) / 100000 + 1;
          end_id = A(2) / 100000 + 1;
          disp(start_id);
          disp(end_id);
          weight(start_id:end_id,:) = NeuralNet(input,weight(start_id:end_id,:),out);
          
      end
      dat = fgetl(fp);
   end
   fclose(fp);
   res = weight;
end 
