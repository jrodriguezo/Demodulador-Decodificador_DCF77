
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gen_reloj_v is
    Port ( CLK : in  STD_LOGIC;    
           CLK_V : out  STD_LOGIC);  
end gen_reloj_v;

architecture a_gen_reloj_v of gen_reloj_v is

signal cont_V : STD_LOGIC_VECTOR (31 downto 0) := (others=>'0');
signal S_V : STD_LOGIC :='0';

begin
  PROC_CONT : process (CLK)
    begin
    if CLK'event and CLK='1' then
      cont_V <= cont_V + '1'; 
      if cont_V >= 50000 then   --50000
        S_V<=not S_V;

	     cont_V<=(others=>'0');
      end if;	 
    end if;	
    end process;
	 
  CLK_V<=S_V;
  
end a_gen_reloj_v;
