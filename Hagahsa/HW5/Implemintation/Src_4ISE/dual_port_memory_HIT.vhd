--
-- dual_port_memory no CK for read for HW3
--
-- Created:
--          by - Danny Seidner, 31/8/2013
--
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY dual_port_memory_no_CK_read IS
GENERIC(
    width :  integer :=32;
    depth :  integer :=32
  );
PORT (
  wr_address    : in integer range depth-1 downto 0;
  wr_data       : in std_logic_vector(width-1 downto 0);
  wr_clk        : in std_logic;
  wr_en         : in std_logic;
  rd1_address   : in integer range depth-1 downto 0;
  rd1_data      : out std_logic_vector(width-1 downto 0);
  rd2_address   : in integer range depth-1 downto 0;
  rd2_data      : out std_logic_vector(width-1 downto 0)
   ); 
END ENTITY dual_port_memory_no_CK_read;

--
ARCHITECTURE dual_port_memory OF dual_port_memory_no_CK_read IS
type Memory_Type is array ((depth-1) downto 0) of std_logic_vector((width-1) downto 0);   
shared variable  Memory_array : Memory_Type := (others => (others =>'0')); -- reset initial value to be 0


BEGIN


Memory_wrdata: PROCESS (wr_clk)
begin 
if wr_clk'event and wr_clk = '1' then
   if wr_en = '1' then
      Memory_array(wr_address) := wr_data;
   end if;
end if ;
end process Memory_wrdata;


Memory_rddata1 : PROCESS (rd1_address,wr_clk) -- need to add wr_clk, otherwise 
                                              -- if we leave rd1_address constant, 
                                              -- we won't see changes in rd data even
                                              -- we write new data (in simulation)											  
begin
   rd1_data <= Memory_array(rd1_address);
end process Memory_rddata1;



Memory_rddata2 : PROCESS (rd2_address,wr_clk) -- need to add wr_clk, see Memory_rddata1 above
begin
   rd2_data <= Memory_array(rd2_address);
end process Memory_rddata2;



END ARCHITECTURE dual_port_memory;

 



