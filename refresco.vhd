library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity refresco is

Port(
			CLK: in STD_LOGIC;
			S: out STD_LOGIC_VECTOR (1 downto 0);
			AN: out STD_LOGIC_VECTOR (3 downto 0));
			
end refresco;

architecture a_refresco of refresco is

signal SS : STD_LOGIC_VECTOR (1 downto 0) := "00";
--signal	cont_V: STD_LOGIC_VECTOR(15 downto 0) :="0000000000000000"; 

 begin

process (CLK)
variable cont_V: STD_LOGIC_VECTOR(15 downto 0) :="0000000000000000"; 
	begin
 if (CLK'event and CLK='1') then
	cont_V := cont_V +'1';
	if(cont_V=50000 or cont_V="1100001101010000") then --"1100001101010000" esto es 50000
			SS<=SS+1; -- genera la secuencia 00,01,10 y 11
			cont_V :="0000000000000000";
		end if;
	 end if;
 end process;
 
S<=SS;

AN<="0111" when SS="00" else -- activa cada display en function del valor de SS
	 "1011" when SS="01" else
	 "1101" when SS="10" else
    "1110" when SS="11"; 
	
end a_refresco;
