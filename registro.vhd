
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro is

	Port(	 ENTRADA	: in STD_LOGIC_VECTOR (27 downto 0);
			 SALIDA	: out STD_LOGIC_VECTOR (27 downto 0);
			 EN		: in STD_LOGIC;
			 CLK		: in STD_LOGIC);
			
end registro;

architecture a_registro of registro is

--signal SALIDA_aux: STD_LOGIC_VECTOR(13 downto 0) :="00000000000000";

begin

	process(CLK,EN)
		begin
			if (CLK'event and CLK='1') then
				if(EN='1') then
				 SALIDA<= ENTRADA;
		end if;
	end if;
end process;

end a_registro;





























































































