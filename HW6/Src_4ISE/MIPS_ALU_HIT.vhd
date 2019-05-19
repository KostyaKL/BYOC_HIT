--
-- 
-- This module is the MIPS ALU for HW3
--  
--
--   
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ***************************************************************************************************
-- ***************************************************************************************************

entity MIPS_ALU is
Port	(	
-- ALU operation control inputs
ALUOP		: in STD_LOGIC_VECTOR(1 downto 0);-- 00=add, 01=sub, 10=by Function
Funct		: in STD_LOGIC_VECTOR(5 downto 0);-- 32=ADD, 34=sub, 36=AND, 37=OR, 38=XOR, 42=SLT
-- data inputs & data control inputs
A_in		: in STD_LOGIC_VECTOR(31 downto 0);
B_in		: in STD_LOGIC_VECTOR(31 downto 0);
sext_imm	: in STD_LOGIC_VECTOR(31 downto 0);
ALUsrcB		: in STD_LOGIC;
-- data output
ALU_out		: out STD_LOGIC_VECTOR(31 downto 0)
		);
end MIPS_ALU;
 

architecture Behavioral of MIPS_ALU is
		   
-- ***************************************************************************************************
-- ***************************************************************************************************


-- inner signals
-- ====================================================
signal  ALU_cmd : STD_LOGIC_VECTOR  (2 downto 0);-- 000=AND, 001=OR, 010=ADD, 011=XOR, 110=sub, 111=slt, 100,101= not used for now
signal  ALU_A_in  : STD_LOGIC_VECTOR  (31 downto 0);
signal  ALU_B_in  : STD_LOGIC_VECTOR  (31 downto 0);
signal  ALU_output : STD_LOGIC_VECTOR  (31 downto 0);

signal  sub_rslt : STD_LOGIC_VECTOR  (32 downto 0);-- use this for creating the sign of sub in SLT instruction
signal  sign_of_sub : STD_LOGIC;

-- Decoded signals for ID phase
signal  LUI : STD_LOGIC;-- '1' when we decode a LUI instruction
signal  ORI : STD_LOGIC;-- '1' when we decode an ORI instruction
signal  JAL : STD_LOGIC;-- '1' when we decode a JAL instruction


begin

ORI <= '0';


-- ALU
process(ALUOP, Funct, ORI)
begin
	if ORI = '1' then 
		ALU_cmd <= b"001"; -- FUNCT=OR
	elsif ALUOP = b"00" then
		ALU_cmd <= b"010"; -- ADD
	elsif ALUOP= b"01" then
			ALU_cmd <= b"110";--  SUB
	elsif ALUOP  = b"11" then -- @@@ ORi HW6
		ALU_cmd <= b"001";
		
	else 
		if Funct = b"100000" then 
			ALU_cmd <= b"010"; -- FUNCT=ADD
		elsif Funct = b"100010" then
			ALU_cmd <= b"110"; -- FUNCT=SUB
		elsif Funct = b"100100" then
			ALU_cmd <= b"000"; -- FUNCT=AND
		elsif Funct = b"100101" then
			ALU_cmd <= b"001"; -- FUNCT=OR
		elsif Funct = b"100110" then
			ALU_cmd <= b"011"; -- FUNCT=XOR
		elsif Funct = b"101010" then
			ALU_cmd <= b"111"; -- FUNCT=SLT
		else 
			ALU_cmd <= b"010"; -- ADD
		end if;
	end if;
end process;		
-- 


---- before forwarding
process(ALUsrcB, sext_imm, B_in)
begin
	if  ALUsrcB='0' then
		ALU_B_in <= B_in;
	else
		ALU_B_in <= sext_imm;
	end if;
end process;
ALU_A_in <= A_in;	



-- if we consider both inputs as 2's comp numbers then
sub_rslt <= (ALU_A_in(31) & ALU_A_in) - (ALU_B_in(31) & ALU_B_in);
sign_of_sub <= sub_rslt(32);


process(ALU_A_in, ALU_B_in, ALU_cmd, sign_of_sub)
	begin
		case ALU_cmd is
			when b"000" =>   ALU_output <= ALU_A_in and ALU_B_in;-- AND
			when b"001" =>   ALU_output <= ALU_A_in or ALU_B_in; -- OR
			when b"010" =>   ALU_output <= ALU_A_in + ALU_B_in; -- ADD
			when b"011" =>   ALU_output <= ALU_A_in xor ALU_B_in; -- XOR 
			when b"100" =>   ALU_output <= not(ALU_A_in and ALU_B_in); -- NAND
			when b"101" =>   ALU_output <= not(ALU_A_in or ALU_B_in); -- NOR
			when b"110" =>   ALU_output <= ALU_A_in - ALU_B_in; -- SUB
			when others =>   ALU_output <= x"0000000" & b"000" & sign_of_sub;-- SLT
		end case;
end process;


ALU_out <= ALU_output;


end Behavioral;

-- ***************************************************************************************************
-- ***************************************************************************************************

