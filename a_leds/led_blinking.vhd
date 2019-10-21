----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:03 10/17/2019 
-- Design Name: 
-- Module Name:    led_blinking - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity led_blinking is
	Port (
		Clk : in STD_LOGIC; -- declare clock signal as an input
		LED : out STD_LOGIC_VECTOR(7 DOWNTO 0) -- declare LEDs as output. last declaration doesn't contin semicolon
	);
end led_blinking;

architecture Behavioral of led_blinking is
constant COUNTER_LIMIT : integer := 3000000; -- declaration of counter upper limit

signal counter : unsigned(24 downto 0); -- local signal definition, 25 bytes wide
signal blinking : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; -- local variable, 7 bytes wide

begin
	process(Clk) -- process part
	begin
		if rising_edge(Clk) then
			if counter = COUNTER_LIMIT then
				counter <= b"0000000000000000000000000"; -- nullify counter
				blinking <= not blinking;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	LED <= blinking;
end Behavioral;

