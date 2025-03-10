-----------------------------------------------------------------
-- test bench for p4_top
-- by Danny Seidner 16/12/12
-----------------------------------------------------------------

library	 ieee;
use  ieee.std_logic_arith.all;  
use  ieee.std_logic_unsigned.all;
use  ieee.std_logic_1164.all;

-----------------------------------------------------------------

entity  p4_TB  is
end  p4_TB;

architecture Testing of p4_TB is

signal  TB_clk		: 	STD_LOGIC; 
signal  TB_pbtn		:	STD_LOGIC; 
signal  TB_switches	:	STD_LOGIC_VECTOR (3 downto 0);
signal  TB_sevenseg	: 	STD_LOGIC_VECTOR (6 downto 0);
signal  TB_anodes	: 	STD_LOGIC_VECTOR (3 downto 0);

component p4_top
   Port ( CK 			: in STD_LOGIC;
			switches 	: in STD_LOGIC_VECTOR (3 downto 0);
		    pushbutton	: in STD_LOGIC;
            sevenseg_out : out STD_LOGIC_VECTOR (6 downto 0);
            anodes_out 	: inout STD_LOGIC_VECTOR (3 downto 0));
end component;

begin
    Testing_p4 : p4_top port map( TB_clk, TB_switches, TB_pbtn, TB_sevenseg, TB_anodes );
	
   -- External CK, 100 MHz CK
	 process  
		begin
			TB_clk <= '1';			-- clock cycle 10 ns
			wait for 5 ns;
			TB_clk <= '0';
			wait for 5 ns;
		end process;
	
	
   -- Manual clock, 10 MHz CK 
	process
		begin
			TB_pbtn <= '1';			-- clock cycle 100 ns
			wait for 50 ns;
			TB_pbtn <= '0';
			wait for 50 ns;
		end process;
	
   -- set TB_switches
    process			 
		begin
			-- be in "off" for 2,000 ns. In this period one can see that both counters are stuck in 0.		
			TB_switches <=  "0000";
			wait for 2000 ns;	

			-- go to "on". In the following 18,000 ns you can see the divider counter working 
			-- but there is no CK to the display counter
			TB_switches <=  "0001";	
			wait for 18000 ns;	
					
			-- continue in "on". After the first 20,000 ns you can still see the divider counter working 
			-- but more interesting is to see the display counter getting the manual_CK 
			-- which we make to be at 100 ns period - to accelerate the simulation
			TB_switches <= "0011";	
			wait for 100000000 ns;	
			
			
		end process;	 
	
		
	
end Testing;



