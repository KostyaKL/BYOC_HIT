--------------------------------------------------------------------------------------
--
-- 
-- This package includes definition of filenames of all dat files used in simulations
--
--
--------------------------------------------------------------------------------------
library	 ieee;


package  BYOC_filenames is

use  ieee.std_logic_1164.all;
use  ieee.std_logic_arith.all;  
use  ieee.std_logic_unsigned.all;
use  std.textio.all;
use  IEEE.NUMERIC_STD.all;

	
--constant	program_in_file_name 	:  string := "C:\Users\User\Documents\BYOC_HIT\HW6\Src_4Sim_1\SIM_HW6_program.dat";
constant	program_in_file_name 	:  string := "C:\Users\User\Documents\BYOC_HIT\HW6\Src_4Sim_2\SIM_HW6_program.dat";
--constant	program_in_file_name 	:  string := "C:\Users\User\Documents\BYOC_HIT\HW6\Src_4Sim_3\SIM_HW6_program.dat";


--constant	data_in_file_name 		:  string := "C:\Users\User\Documents\BYOC_HIT\HW6\Src_4Sim_1\SIM_HW6_TB_data_no_fwding.dat"; -- for  no fwding
constant	data_in_file_name 		:  string := "C:\Users\User\Documents\BYOC_HIT\HW6\Src_4Sim_2\SIM_HW6_TB_data_wt_data_fwding.dat"; -- for wt data fwding
--constant	data_in_file_name 		:  string := "C:\Users\User\Documents\BYOC_HIT\HW6\Src_4Sim_3\SIM_HW6_TB_data_wt_data_and_branch_fwding.dat"; -- for wt data & branch fwding
--constant	data_in_file_name 		:  string := "C:\Users\User\Documents\VHDL\HW6\Src_4Sim\SIM_HW6_TB_data_???.dat"; -- use one of the 3 file names from the 3 lines above



signal 		no_hold					:  STD_LOGIC := '0'; -- MUST be '0' for correct TB messages !!!

end   BYOC_filenames ;