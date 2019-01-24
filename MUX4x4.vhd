
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX4x4 is
		Port( E0: in STD_LOGIC_VECTOR (3 downto 0);
				E1: in STD_LOGIC_VECTOR (3 downto 0);
				E2: in STD_LOGIC_VECTOR (3 downto 0);
				E3: in STD_LOGIC_VECTOR (3 downto 0);
				S: in STD_LOGIC_VECTOR (1 downto 0);
				Y: out STD_LOGIC_VECTOR (3 downto 0));
end MUX4x4;

architecture a_MUX4x4 of MUX4x4 is


begin

--with S select 
Y <=
 E3 when S="00" else
 E2 when S="01" else
 E1 when S="10" else
 E0 when S="11";
 --"0000" when others; 

end a_MUX4x4;

