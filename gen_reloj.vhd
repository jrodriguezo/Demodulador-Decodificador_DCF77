
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gen_reloj_m is
    Port ( CLK : in  STD_LOGIC;    
           CLK_M : out  STD_LOGIC);  
end gen_reloj_m;

architecture a_gen_reloj_m of gen_reloj_m is

signal cont_M : STD_LOGIC_VECTOR (31 downto 0) := (others=>'0');
signal S_M : STD_LOGIC :='0';

begin
  PROC_CONT : process (CLK)
    begin
    if CLK'event and CLK='1' then
      cont_M <= cont_M + '1'; 
      if cont_M >= 625000 then   --625000
        S_M<=not S_M;

	     cont_M<=(others=>'0');
      end if;	 
    end if;	
    end process;
	 
  CLK_M<=S_M;
  
end a_gen_reloj_m;



