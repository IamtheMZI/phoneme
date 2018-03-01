## Copyright (C) 2018 Muhammad Ilahee
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} phoneme_run (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Muhammad Ilahee <milahee@milahee-dev>
## Created: 2018-02-28

function [retval] = phoneme_run (iter)
  pkg load parallel;
  v_x = [1:54]';
  count = 0;
  while ( count < iter)
      retval = pararrayfun(nproc-1,@phoneme_test,v_x);
      count = count + 1;
  end
endfunction
