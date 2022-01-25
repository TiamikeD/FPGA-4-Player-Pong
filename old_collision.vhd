 -- most recent code - as of April 25 - Daisy
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity collision is
  generic(
  p_len : integer := 24; -- paddle length
  front : integer := 0;  -- where the left paddle is
  back  : integer := 127 -- where the right paddle is
  );
  port(
	--clk7       : in std_logic;
    --old_x_vel  : in signed(6 downto 0); --changed to internal signals - Olive
	--old_y_vel  : in signed(6 downto 0);
    b_pos_x    : in unsigned(6 downto 0) := "1000000";
	b_pos_y    : in unsigned(6 downto 0) := "1000000";
	p_pos_lt   : in unsigned(6 downto 0);
	p_pos_rt   : in unsigned(6 downto 0);
	out_lt     : out std_logic;
    out_rt     : out std_logic;
	hit_lt     : out std_logic;
    hit_rt     : out std_logic;
	x_vel      : out signed(6 downto 0);
	y_vel      : out signed(6 downto 0)
	);
end collision;

architecture synth of collision is

  -- signal declarations
  signal diff  : signed(6 downto 0);
  signal b_x   : signed(6 downto 0);
  signal b_y   : signed(6 downto 0);
  signal p_lt  : signed(6 downto 0);
  signal p_rt  : signed(6 downto 0);
  signal p_len_s : signed(6 downto 0);
  signal front_s : signed(6 downto 0);
  signal back_s  : signed(6 downto 0);
  signal prev_v_x : signed(6 downto 0);
  signal prev_v_y : signed(6 downto 0);
  
begin
--prev_v_x <= 
-- constant variables to be used -- moved to generic instead 
		  p_len_s <= to_signed(p_len, 7);
		  front_s <= to_signed(front, 7);
		  back_s <= to_signed(back, 7);
		  
		  -- pe conversions
		  b_x <= to_signed(to_integer(b_pos_x), 7);
		  b_y <= to_signed(to_integer(b_pos_y), 7);
		  p_lt <= to_signed(to_integer(p_pos_lt), 7);
		  p_rt <= to_signed(to_integer(p_pos_rt), 7);
	--process(clk7) is begin
	--	if rising_edge(clk7) then
		  -- hit left paddle
		  hit_lt <= '1' when ((b_y <= (p_lt + p_len)) and (b_y >= (p_lt - p_len)) and (b_x = front)) else 
					'0'; 

		  -- hit right paddle
		  hit_rt <= '1' when ((b_y <= (p_rt + p_len)) and (b_y >= (p_rt - p_len)) and (b_x = back) ) else
					'0';
		  
		  -- checks for game over 
		  -- out on left side
		  out_lt <= '1' when ( hit_lt = '0' ) else
					'0';
					   
		  -- out on right side
		  out_rt <= '1' when ( hit_rt = '0' ) else
					'0';

		  -- calculates velocity below:
		  --if (hit_lt = '1') then
			--x_vel <= -x_vel; -- x vel is reflected 
			--y_vel <= y_vel;
		  --elsif (hit_rt = '1') then
		    --x_vel <= - x_vel;
			--y_vel <= y_vel;
		  --elsif (b_y = "0000000") then
		    --x_vel <= x_vel;
			--y_vel <= -y_vel;
		  --elsif (b_y = "1111111") then
		    --x_vel <= x_vel;
			--y_vel <= -y_vel;
		  --else
		    --x_vel <= x_vel;
			--y_vel <= y_vel;
		  --end if;
		  
		  diff <= (b_pos_x - p_pos_lt) when ((b_pos_x = "0000000") and (hit_lt = '1') ) else   -- hit left paddle
				  (b_pos_x - p_pos_rt) when ((b_pos_x = "1111111") and (hit_rt = '1')) else      -- hit right paddle
				  (b_pos_y - 64);      -- hit top or bottom
			   
--	  x_vel <= old_x_vel + diff;
	  x_vel <= x_vel + diff;
	  y_vel <= y_vel + diff;
-- y_vel <= old_y_vel - diff;

--	end if;
  --end process;
end;

 
 --synthesized but couldn't map design got an error saying it didn't match to device
--library IEEE;
--use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;

--entity collision is
  --port(
		--b_pos_x       : in unsigned(6 downto 0);
		--b_pos_y       : in unsigned(6 downto 0);
		--p_position_lt  : in unsigned(6 downto 0);
		--p_position_rt  : in unsigned(6 downto 0);
		--out_left     : out std_logic;
		--out_right     : out std_logic;
		--hit_lt : out std_logic;
		--hit_rt : out std_logic;
		--velocity_x     : out signed(6 downto 0);
		--velocity_y     : out signed(6 downto 0)
  --);
--end collision;


--architecture synth of collision is

  -- signal declarations
  --signal diff : unsigned(6 downto 0);
  --signal b_x : unsigned(6 downto 0);
  --signal b_y : unsigned(6 downto 0);
  --signal p1 : unsigned(6 downto 0);
  --signal p2 : unsigned(6 downto 0);
  

--begin
  --b_x <= b_pos_x;
  --b_y <= b_pos_y;
  --p1 <= p_position_lt;
  --p2 <= p_position_rt;
  
  -- hit left paddle
  --hit_lt <= '1' when ((b_y <= (p1 + 24)) and (b_y >= (p1 - 24)) and (b_x = 0) ) else 
            --'0'; 

 --  hit right paddle
  --hit_rt <= '1' when ((b_y <= (p2 + 24)) and (b_y >= (p2 - 24)) and (b_x = 127) ) else
            --'0';
  
  --out_left <= '1' when ( hit_lt = '0' ) else
          --'0';
   
  --out_right <= '1' when ( hit_rt = '0' ) else
           --'0';
--end;
