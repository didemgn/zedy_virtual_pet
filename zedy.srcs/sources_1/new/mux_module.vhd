----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/06/2026 02:38:57 PM
-- Design Name: 
-- Module Name: mux_module - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use work.fsm_t_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_module is
  Port ( 
    current_state : in std_ulogic_vector (2 downto 0);
    image_happy : in std_ulogic_vector(15 downto 0);
    image_hungry : in std_ulogic_vector(15 downto 0);
    image_sleepy : in std_ulogic_vector(15 downto 0);
    image_sleeping : in std_ulogic_vector(15 downto 0);
    image_wait_food : in std_ulogic_vector(15 downto 0);
    image_sad : in std_ulogic_vector(15 downto 0);
    
    data_o : out std_ulogic_vector(15 downto 0)
  );
end mux_module;

architecture Behavioral of mux_module is
begin

	process (current_state)
	begin 
	    case current_state is
		when "000" =>
		    data_o <= image_happy;
		when "001" =>
		    data_o <= image_hungry;
		when "010" =>
		    data_o <= image_sleepy;
		when "011" =>
		    data_o <= image_sleeping;
		when "100" =>
		    data_o <= image_wait_food;
		when "101" =>
		    data_o <= image_sad;
		when others =>
		    data_o <= image_happy;
	    end case;
	end process;
end Behavioral;
