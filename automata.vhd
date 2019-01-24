
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity automata is
				Port ( CLK : in STD_LOGIC; -- Reloj del autómata
				C0 : in STD_LOGIC; -- Condición de decision para "0"
				C1 : in STD_LOGIC; -- Condición de decisión para "1"
				DATO : out STD_LOGIC; -- Datos a cargar
				CAPTUR : out STD_LOGIC; -- Enable del reg. de desplaz.
				VALID : out STD_LOGIC); -- Enable del reg de validación
end automata;

architecture a_automata of automata is

			type TIPO_ESTADO is (ESP_SYNC,AVAN_ZM,MUESTREO,DATO0,DATO1,DATOSYNC);
			signal ST : TIPO_ESTADO:= ESP_SYNC ; -- Estado inicial en que arranca
			signal salidas :  STD_LOGIC_VECTOR (2 downto 0) :="000";

begin
			process (CLK)
			variable cont : STD_LOGIC_VECTOR (7 downto 0):="00000000"; -- contador
				-- para contar ciclos en un estado, iniciado a 0
				begin
				if (CLK'event and CLK = '1') then
				 	
					case ST is
						when ESP_SYNC => -- Estado normal, dura 1 ciclo de reloj
								if (C0='0' and C1='0') then
										cont:=(others=>'0');
										ST<=AVAN_ZM;
										
								else 
										ST<=ESP_SYNC;
								end if;
								
						when AVAN_ZM => -- Estado que dura 20 ciclos de reloj			
								cont:= cont+1;
								if (cont=20) then -- Si llega a 20
								cont:=(others=>'0'); -- Poner el contador a 0
								ST<=MUESTREO; -- Y cambiar de estado
								else
								ST<=AVAN_ZM; -- Si no ha llegado a 20 permanecer
								end if;-- en el mismo estado
						
						when MUESTREO =>
								cont:= cont+1;
								if (cont=39) then 
								cont:=(others=>'0');						
									if (C0='0' and C1='0') then
											ST<=DATOSYNC;
									elsif( C0='0' and C1='1') then 
											ST<=DATO1;
									elsif( C0='1' and C1='0') then
											ST<=DATO0;
									else ST<=MUESTREO;
									end if;
								else
									ST<=MUESTREO;
								end if;
						
						when  DATO0 =>	
									--ST<=MUESTREO;
								cont:= cont+1;
								if (cont=1) then -- Si llega a 1
								cont:=(others=>'0'); -- Poner el contador a 0
								ST<=MUESTREO; -- Y cambiar de estado
								end if; -- en el mismo estado
								
						when  DATO1 =>
									--ST<=MUESTREO;
				
								cont:= cont+1;
								if (cont=1) then -- Si llega a 1
								cont:=(others=>'0'); -- Poner el contador a 0
								ST<=MUESTREO; -- Y cambiar de estado
								end if; -- en el mismo estado
						
						when  DATOSYNC =>
									--ST<=MUESTREO;
								cont:= cont+1;
								if (cont=1) then -- Si llega a 1
								cont:=(others=>'0'); -- Poner el contador a 0
								ST<=MUESTREO; -- Y cambiar de estado
								end if; -- en el mismo estado
								
					end case;
				end if;
			end process;
 
 
 with ST select
	salidas<=
			"000" when ESP_SYNC,
			"000"	when AVAN_ZM,
			"000"	when MUESTREO,
			"010" when DATO0,
			"110" when DATO1,
			"001" when DATOSYNC,
			"000" when others;
			
	DATO <= salidas(2);
	CAPTUR <= salidas(1);
	VALID <= salidas(0);
	
	
end a_automata;

