
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity visualizacion is
    Port ( E0 : in  STD_LOGIC_VECTOR (3 downto 0);
           E1 : in  STD_LOGIC_VECTOR (3 downto 0);
           E2 : in  STD_LOGIC_VECTOR (3 downto 0);
           E3 : in  STD_LOGIC_VECTOR (3 downto 0);
           CLK : in  STD_LOGIC;
           SEG7 : out  STD_LOGIC_VECTOR (6 downto 0);
           AN : out  STD_LOGIC_VECTOR (3 downto 0));
end visualizacion;

architecture a_visualizacion of visualizacion is

	
signal s_control : STD_LOGIC_VECTOR (1 downto 0); --aux1
signal s_datos : STD_LOGIC_VECTOR (3 downto 0); --aux2
--signal CLK_V_aux : STD_LOGIC;
--signal S_aux : STD_LOGIC_VECTOR (1 downto 0);
--signal D_deco : STD_LOGIC_VECTOR (3 downto 0);
			

component MUX4x4
		Port(
			E0: in STD_LOGIC_VECTOR (3 downto 0);
			E1: in STD_LOGIC_VECTOR (3 downto 0);
			E2: in STD_LOGIC_VECTOR (3 downto 0);
			E3: in STD_LOGIC_VECTOR (3 downto 0);
			S: in STD_LOGIC_VECTOR (1 downto 0);
			Y: out STD_LOGIC_VECTOR (3 downto 0));
end component;

component decod7s
		Port(
			D: in STD_LOGIC_VECTOR (3 downto 0);
			S: out STD_LOGIC_VECTOR (6 downto 0));
end component;

component refresco
		Port(
			CLK: in STD_LOGIC;
			S: out STD_LOGIC_VECTOR (1 downto 0);
			AN: out STD_LOGIC_VECTOR (3 downto 0));
end component;

--component gen_reloj_v
--		    Port ( 
--					CLK : in  STD_LOGIC;    
--					CLK_V : out  STD_LOGIC);
--end component;

--begin
	
	--Unit_refresco : refresco port map (CLK,S_aux,AN); 
	--Unit_decod7s : decod7s port map (D_deco,SEG7);
	--Unit_MUX4x4 : MUX4x4 port map (E0,E1,E2,E3,S_aux,D_deco);


begin
 

				U1_refresco : refresco
				 port map (
						 CLK => CLK,
						 S => s_control,
						 AN => AN
				 );

				U2_MUX : MUX4X4
				 port map (
						 E0 => E0,
						 E1 => E1,
						 E2 => E2,--"0000",
						 E3 => E3,--"0000",
						 S => s_control,
						 Y => s_datos
				 );

				U3 : decod7s
				 port map (
						 D => s_datos,
						 S => SEG7
				 ); 
				 
			--	U4 : gen_reloj_v
			--		port map (
			--			CLK => CLK,
			--			CLK_V => CLK_V_aux
			--	 );
 
 
end a_visualizacion;

