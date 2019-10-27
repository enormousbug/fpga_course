----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:45:43 10/26/2019 
-- Design Name: 
-- Module Name:    logic_gates - Behavioral 
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

entity logic_gates is
Port(Switch : in STD_LOGIC_VECTOR(4 downto 0); -- buttons acting as gates input
	DPSwitch : in STD_LOGIC_VECTOR(1 downto 0); -- dip switch array as multiplekser input
	LED : out STD_LOGIC_VECTOR(7 downto 0)); -- LEDs acting as gates outputs
	-- by default we use button 0 and 1
	-- when multiplekser used 00 -> b1. 01 -> b2, 10 -> b3, 11 -> b4
	-- 0 and	
	-- 1 nand
	-- 2 or
	-- 3 nor
	-- 4 xor
	-- 5 xnor
	-- 6 b0 pressed
	-- 7 b1 pressed
end logic_gates;

architecture Behavioral of logic_gates is

-- declaration of local signals (not available outside module)
signal input_buffer : STD_LOGIC_VECTOR(4 downto 0); 
signal address_buffer : STD_LOGIC_VECTOR(1 downto 0); 
signal button_state : STD_LOGIC := '0'; -- used to keep button state

begin

-- multiplekser logic
with address_buffer select -- HDLs' switch - case
	button_state <= input_buffer(1) when "00",
						input_buffer(2) when "01",
						input_buffer(3) when "10",
						input_buffer(4) when others; -- others in this case is only "11"
						
-- parrel with with-select
input_buffer <= not Switch;
address_buffer <= not DPSwitch;

-- all switch values are negated, because of hardware architecture
LED(0) <= (not Switch(0)) and (button_state); -- and
LED(1) <= (not Switch(0)) nand (button_state); -- nand
LED(2) <= (not Switch(0)) or (button_state); -- or
LED(3) <= (not Switch(0)) nor (button_state); -- nor
LED(4) <= (not Switch(0)) xor (button_state); -- xor
LED(5) <= (not Switch(0)) xnor (button_state); -- xnor
LED(6) <= (not Switch(0)); -- Switch 0
LED(7) <= (button_state); -- Switch multiplekser

end Behavioral;

