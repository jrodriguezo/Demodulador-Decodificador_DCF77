library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decod7s is
Port(
			D: in STD_LOGIC_VECTOR (3 downto 0);
			S: out STD_LOGIC_VECTOR (6 downto 0));
end decod7s;

architecture a_decod7s of decod7s is

begin

 with D select S <=
"0000001" when "0000",
"1001111" when "0001",
"0010010" when "0010",
"0000110" when "0011",
"1001100" when "0100",
"0100100" when "0101",
"0100000" when "0110",
"0001111" when "0111",
"0000000" when "1000",
"0001100" when "1001",
"1111111" when others; 
 
end a_decod7s; 
