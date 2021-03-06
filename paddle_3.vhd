library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.numeric_std.all;

entity REncoder2 is
	port(
		clk_in : in std_logic;
		rot1 : in std_logic;
		rot2 : in std_logic;
		Rvalue : out unsigned(6 downto 0);
		);
end REncoder;

architecture synth of REncoder2 is
--component HSOSC is
	--generic (
		--CLKHF_DIV : String := "0b00"); -- Divide 48MHz clock by 2?N (0-3)
	--port(
		--CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
		--CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output
		--CLKHF : out std_logic := 'X'); -- Clock output
--end component;

signal rotary_a_in   : std_logic;
signal rotary_b_in   : std_logic;
signal rotary_a_prev : std_logic;
signal rotary_b_prev : std_logic;
signal clk           : std_logic;
signal Rvalue_s      : std_logic_vector(6 downto 0);
signal Rvalue_int    : integer range 0 to 127;

begin

--clock : hsosc
	--port map(
		--clkhfpu => '1',
		--clkhfen => '1',
		--clkhf => clk
		--);
		
rotary_a_in <= rot1;
rotary_b_in <= rot2;

process (clk) is
begin
	if rising_edge(clk) then
		rotary_a_prev <= rotary_a_in;
		rotary_b_prev <= rotary_b_in;
		if rotary_a_prev = '0' and rotary_a_in = '1' and rotary_b_prev = '1' and rotary_b_in = '1' and Rvalue_int < 128 then
			Rvalue_int <= Rvalue_int + 1;
		elsif rotary_a_prev = '1' and rotary_a_in = '1' and rotary_b_prev = '1' and rotary_b_in = '0' and Rvalue_int > 1 then
			Rvalue_int <= Rvalue_int - 1;
		else
			Rvalue_int <= Rvalue_int;
		end if;
		Rvalue <= to_unsigned(rvalue_int);
	end if;
end process;
end;