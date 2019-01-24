library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity principal is
 Port ( CLK : in STD_LOGIC; -- entrada de reloj
			SIN : in STD_LOGIC; -- entrada de datos
			AN : out STD_LOGIC_VECTOR (3 downto 0); -- control de displays
			SEG7 : out STD_LOGIC_VECTOR (6 downto 0)); -- segmentos de displays
end principal;

architecture a_principal of principal is
-- Constantes del circuito (umbrales de decisión)
constant UMBRAL1 : STD_LOGIC_VECTOR (5 downto 0) := "100010"; -- 34
constant UMBRAL2 : STD_LOGIC_VECTOR (5 downto 0) := "100110"; -- 38

--signal CLK: STD_LOGIC;
--signal sal_dig_aux: STD_LOGIC;

signal CLK_M_aux: STD_LOGIC;
--signal CLK_V_aux: STD_LOGIC;
signal Q_aux : STD_LOGIC_VECTOR (39 downto 0);
signal SAL_aux :  STD_LOGIC_VECTOR (5 downto 0);
signal PGTQ_aux1 : STD_LOGIC;
signal PLEQ_aux1 :  STD_LOGIC;
signal PGTQ_aux2 : STD_LOGIC;
signal PLEQ_aux2 :  STD_LOGIC;
signal  SUM :  STD_LOGIC;
signal DATO_aux,CAPTUR_aux,VALID_aux: STD_LOGIC;
signal Q_reg_desp_aux : STD_LOGIC_VECTOR (13 downto 0);
signal Q_reg_validacion_aux: STD_LOGIC_VECTOR (13 downto 0);
signal salida_E: STD_LOGIC_VECTOR (15 downto 0);

									

component gen_reloj_m
 Port ( CLK : in STD_LOGIC; -- Reloj de la FPGA
		  CLK_M : out STD_LOGIC); -- Reloj de frecuencia dividida
end component;

component gen_reloj_v
 Port ( CLK : in  STD_LOGIC;    
        CLK_V : out  STD_LOGIC);  
end component;

component reg_desp40
 Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
		  CLK : in STD_LOGIC; -- Reloj de muestreo
		  Q : out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo
end component;

component sumador40

 Port ( ENT : in STD_LOGIC_VECTOR (39 downto 0);
		  SAL : out STD_LOGIC_VECTOR (5 downto 0));
end component;
component comparador

 Port ( P : in STD_LOGIC_VECTOR (5 downto 0);
		  Q : in STD_LOGIC_VECTOR (5 downto 0);
		  PGTQ : out STD_LOGIC;
		  PLEQ : out STD_LOGIC);
end component;

component AND_2
 Port ( 
 A : in STD_LOGIC;
 B : in STD_LOGIC;
 S : out STD_LOGIC);
end component;

component reg_desp
 Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
 CLK : in STD_LOGIC; -- Reloj
 EN : in STD_LOGIC; -- Enable
 Q : out STD_LOGIC_VECTOR (13 downto 0)); -- Salida paralelo
end component;

component registro
 Port ( ENTRADA : in STD_LOGIC_VECTOR (13 downto 0);
 SALIDA : out STD_LOGIC_VECTOR (13 downto 0);
 EN : in STD_LOGIC; -- Enable
 CLK : in STD_LOGIC);
end component;

component automata
 Port ( CLK : in STD_LOGIC; -- Reloj del autómata
 C0 : in STD_LOGIC; -- Condición de decision para "0"
 C1 : in STD_LOGIC; -- Condición de decisión para "1"
 DATO : out STD_LOGIC; -- Datos a cargar
 CAPTUR : out STD_LOGIC; -- Enable del reg. de desplaz.
 VALID : out STD_LOGIC); -- Activación registro
end component;

component visualizacion
 Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 0
 E1 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 1
 E2 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 2
 E3 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 3
 CLK : in STD_LOGIC; -- Entrada de reloj FPGA
 SEG7 : out STD_LOGIC_VECTOR (6 downto 0); -- Salida para los displays
 AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Activación individual
end component;

--component gen_signal 
--    Port ( clk : in  STD_LOGIC;
--           sal_dig : out  STD_LOGIC);
--end component;
--
------    Clock period definitions
--   constant CLK_period : time := 10 ns;
--
begin
--
--   CLK_process :process
--   begin
--		CLK <= '0';
--		wait for CLK_period;
--		CLK <= '1';
--		wait for CLK_period;
--   end process;
--	

salida_E <= STD_LOGIC_VECTOR('0'&Q_reg_validacion_aux(13 downto 11)&Q_reg_validacion_aux(10 downto 7)&'0'&Q_reg_validacion_aux(6 downto 4)&Q_reg_validacion_aux(3 downto 0));
	
--	u_gen_signal: gen_signal port map(
--										CLK => CLK,
--										 sal_dig	 => sal_dig_aux);		
										 
	U0_gen_reloj : gen_reloj_m port map (
									CLK=>CLK,
									CLK_M=>CLK_M_aux
									);
									
--	U01_gen_reloj : gen_reloj_v port map (
--									CLK=>CLK,
--									CLK_V=>CLK,
--									);
	
	
	U1_reg_desp40 : reg_desp40 port map (
									SIN => SIN,--sal_dig_aux, --SIN
									CLK =>CLK_M_aux,
									Q	=>	Q_aux
									);
									
	U2_sumador40 : sumador40 port map(
									ENT => Q_aux,
									SAL => SAL_aux);
									
	U3_comparador1 :  comparador port map(
									P => SAL_aux,
									Q => UMBRAL1,
									PGTQ =>	PGTQ_aux1,
									PLEQ =>	PLEQ_aux1);
									
	U4_comparador2 :  comparador port map(
									P => SAL_aux,
									Q => UMBRAL2,
									PGTQ =>	open,--PGTQ_aux2,
									PLEQ =>	PLEQ_aux2); -- P<=Q
	U5_and : AND_2 port map(
									A => PGTQ_aux1,
								   B => PLEQ_aux2,
								   S => SUM);
									
	U6_automata: automata port map(
									CLK => CLK_M_aux,
									C0 =>	SUM,
									C1 => PLEQ_aux1,
									DATO => DATO_aux,
									CAPTUR => CAPTUR_aux,
									VALID => VALID_aux);
									
	U7_reg_desp: reg_desp port map(
									SIN => DATO_aux,
									CLK => CLK_M_aux,
									EN => CAPTUR_aux,
									Q => Q_reg_desp_aux);
									
	U8_reg_validacion: registro port map(
									ENTRADA => Q_reg_desp_aux,
									SALIDA => Q_reg_validacion_aux,
									EN => VALID_aux,
									CLK => CLK_M_aux);

	U9_visualizacion: visualizacion port map(
									E0 => salida_E(15 downto 12),--('0' & Q_reg_validacion_aux(13 downto 11)),
									E1 => salida_E(11 downto 8), --    Q_reg_validacion_aux(10 downto 7),
									E2 => salida_E(7 downto 4), --('0' & Q_reg_validacion_aux(6 downto 4)),
									E3 => salida_E(3 downto 0),--Q_reg_validacion_aux(3 downto 0),
									CLK => CLK,--CLK_V_aux,
									SEG7 => SEG7,
									AN=> AN);
			
																	
end a_principal;