--game_over.vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity game_over is 
  port(
	clk : in std_logic;
	out_left : in std_logic;
	out_right : in std_logic;
	start_ball_pos_x : out unsigned(6 downto 0) := "100000";
	start_ball_pos_y : out unsigned(6 downto 0) := "100000";
	start_p_pos_x : out unsigned(6 downto 0) := "1000000";
	start_p_pos_y : out unsigned(6 downto 0) := "1000000"
  );
end game_over;

architecture synth of game_over is
begin
	-- can you do this?
	(start_ball_pos_x <= "100000",
	start_ball_pos_y <= "100000",
	start_p_pos_x <= "1000000",
	start_p_pos_y <= "1000000") when ((out_left = '1') or (out_right = '1'));
	
end;