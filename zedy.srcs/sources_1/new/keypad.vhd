library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity keypad is
  Port (
    kypd_c4 : in std_ulogic;
    kypd_c3 : in std_ulogic;
    kypd_c2 : in std_ulogic;
    kypd_c1 : in std_ulogic;
    kypd_r4 : in std_ulogic; 
    kypd_r3 : in std_ulogic; 
    kypd_r2 : in std_ulogic;
    kypd_r1 : in std_ulogic;
    data_o  : out std_ulogic_vector (3 downto 0); -- key number
    pressed_o : out std_ulogic -- button pressed
 );
end keypad;

architecture Behavioral of keypad is
	signal kypd_c4_i: std_ulogic;
	signal kypd_c3_i: std_ulogic;
	signal kypd_c2_i: std_ulogic;
	signal kypd_c1_i: std_ulogic;
begin

    process (kypd_c1, kypd_c2, kypd_c3, kypd_c4, kypd_r1, kypd_r2, kypd_r3, kypd_r4)
    begin
    	kypd_c4_i <= kypd_c4;
    	kypd_c3_i <= kypd_c3;
    	kypd_c2_i <= kypd_c2;
    	kypd_c1_i <= kypd_c1;
    	
        -- default
        data_o  <= "0000";
        pressed_o <= '0';
        
        if (kypd_c1_i = '0' and kypd_r1 = '0') then pressed_o <= '1'; data_o <= "0001";
        elsif (kypd_c2_i = '0' and kypd_r1 = '0') then pressed_o <= '1'; data_o <= "0010";
        elsif (kypd_c3_i = '0' and kypd_r1 = '0') then pressed_o <= '1'; data_o <= "0011";
        
        elsif (kypd_c1_i = '0' and kypd_r2 = '0') then pressed_o <= '1'; data_o <= "0100";
        elsif (kypd_c2_i = '0' and kypd_r2 = '0') then pressed_o <= '1'; data_o <= "0101";
        elsif (kypd_c3_i = '0' and kypd_r2 = '0') then pressed_o <= '1'; data_o <= "0110";
        
        elsif (kypd_c1_i = '0' and kypd_r3 = '0') then pressed_o <= '1'; data_o <= "0111";
        elsif (kypd_c2_i = '0' and kypd_r3 = '0') then pressed_o <= '1'; data_o <= "1000";
        elsif (kypd_c3_i = '0' and kypd_r3 = '0') then pressed_o <= '1'; data_o <= "1001";

        elsif (kypd_c1_i = '0' and kypd_r4 = '0') then pressed_o <= '1'; data_o <= "0000";
        end if;
    end process;
end Behavioral;
