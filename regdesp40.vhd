
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_desp40 is
    Port ( SIN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (39 downto 0));
end reg_desp40;

architecture a_reg_desp40 of reg_desp40 is

signal Q_aux: STD_LOGIC_VECTOR (39 downto 0) := "0000000000000000000000000000000000000000";

begin		
	process (CLK)
		--variable Q_aux: STD_LOGIC_VECTOR (39 downto 0) := "0000000000000000000000000000000000000000"; esto no funciona
			begin
				if (CLK'event and CLK='1') then
					--Q_aux <= SIN & Q_aux(39 downto 1); -- a derechas
					Q_aux <= Q_aux(38 downto 0) & SIN; --a izquierdas
				end if;
			end process;
			
		Q <= Q_aux;

	end a_reg_desp40;


