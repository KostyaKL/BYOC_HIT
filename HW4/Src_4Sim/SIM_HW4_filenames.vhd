----------------------------------------------------------------------------------
--
-- 
-- This package includes definition of filenames used in simulations
--
--
----------------------------------------------------------------------------------
library	 ieee;


package  BYOC_filenames is
	
use  ieee.std_logic_1164.all;
use  ieee.std_logic_arith.all;  
use  ieee.std_logic_unsigned.all;
use  std.textio.all;
use  IEEE.NUMERIC_STD.all;

constant	program_in_file_name 	:  string := "C:\Users\User\Documents\VHDL\HW4\Src_4Sim\SIM_HW4_program.dat";
constant	data_in_file_name 		:  string := "C:\Users\User\Documents\VHDL\HW4\Src_4Sim\SIM_HW4_TB_data.dat";

signal 		no_hold					:  STD_LOGIC := '0'; -- MUST be '0' for correct TB messages !!!

end   BYOC_filenames ;