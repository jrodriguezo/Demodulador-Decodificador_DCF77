----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:00:53 12/11/2017 
-- Design Name: 
-- Module Name:    MUX_mejora - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_mejora is
    Port ( E0 : in  STD_LOGIC_VECTOR (13 downto 0);
           E1 : in  STD_LOGIC_VECTOR (13 downto 0);
			  S: in STD_LOGIC;
				Y: out STD_LOGIC_VECTOR (13 downto 0));
end MUX_mejora;

architecture Behavioral of MUX_mejora is
--signal  manten_hora: STD_LOGIC_VECTOR (13 downto 0);
--signal manten_fecha: STD_LOGIC_VECTOR (13 downto 0);

begin

--process(S)
--	begin
--		if S='1' then
--		manten_fecha <= E1;
--		else	
--		manten_hora <= E2;
--		end if;
--	end process;
--	
--	Y<=
Y <=
 E0 when S='0' else
 E1 when S='1' ;
 
 
 

end Behavioral;

