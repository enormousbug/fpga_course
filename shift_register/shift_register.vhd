----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:25 10/27/2019 
-- Design Name: 
-- Module Name:    shift_register - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_register is
	Port (Clk : in STD_LOGIC; -- clock as an input
		DPSwitch : in STD_LOGIC_VECTOR(7 downto 0); -- data in register
		Switch : in STD_LOGIC; -- switch as a reset
		LED : out STD_LOGIC_VECTOR(7 downto 0)); -- LED as an visualization of register state
end shift_register;

architecture Behavioral of shift_register is

signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := x"01";

constant COUNTER_MAX : integer := 12000000;
signal counter : STD_LOGIC_VECTOR(24 downto 0);

begin

count_n_shift : process(Clk, Switch, DPSwitch)
begin
	if (rising_edge(Clk)) then
		if (counter = COUNTER_MAX) then
			counter <= (others => '0'); -- write to each bit value '0'
			shift_reg <= shift_reg(0) & shift_reg(7 downto 1); -- shift operation, take 0 and move it to the vector front
		else
			counter <= counter + 1;
		end if;
	end if;
	
	if (not Switch = '1') then
		shift_reg <= not DPSwitch; -- reset LEDs and apply new register value
		counter <= (others => '0'); -- write to each bit value '0'
	else
	end if;
end process count_n_shift;

LED <= shift_reg;	

end Behavioral;

