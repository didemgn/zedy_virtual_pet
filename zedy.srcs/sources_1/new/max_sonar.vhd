library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity max_sonar is
  Port ( 
      clk : in std_ulogic;
      rst_n : in std_ulogic;
      pwm_i : in std_ulogic;
      person_detected_o : out std_ulogic
     
  );
end max_sonar;

architecture Behavioral of max_sonar is
	-- counter to measure the pulse width duration
	signal pulse_counter : unsigned(31 downto 0) := (others => '0');
    signal pwm_prev : std_ulogic := '0';

    -- threshold for 30 cm 
	-- 30 cm round trip travel time is approx. 1750us
    constant THRESHOLD : unsigned(31 downto 0) := to_unsigned(174000,32);
begin
	process(clk, rst_n)
	begin
		if rst_n = '0' then
			pulse_counter <= (others => '0');
			person_detected_o <= '0';
			pwm_prev <= '0';
		elsif rising_edge(clk) then
			pwm_prev <= pwm_i;

			-- increment counter while pwm signal is high
			if pwm_i = '1' then
				pulse_counter <= pulse_counter + 1;
			-- evaluate the puöse width on the falling edge
			elsif pwm_prev = '1' and pwm_i = '0' then
				-- check if the measured pulse is within the detection range
				if pulse_counter <= THRESHOLD then
					person_detected_o <= '1';
				else
					person_detected_o <= '0';
				end if;
				pulse_counter <= (others => '0');
			end if;
		end if;
	end process;
end Behavioral;