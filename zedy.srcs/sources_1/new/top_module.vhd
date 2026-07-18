library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.fsm_t_package.all;

entity top_module is
Port (
        clk     : in std_ulogic;
        rst_n   : in std_ulogic;

        -- PMOD KYPD
        kypd_c4 : buffer std_ulogic;
        kypd_c3 : buffer std_ulogic;
        kypd_c2 : buffer std_ulogic;
        kypd_c1 : buffer std_ulogic;
        kypd_r4 : in std_ulogic;
        kypd_r3 : in std_ulogic;
        kypd_r2 : in std_ulogic;
        kypd_r1 : in std_ulogic;

        -- PMOD MaxSonar
        --sonar_o          : out std_ulogic;
       -- sonar_receiver   : in std_ulogic;
        --sonar_transmiter : out std_ulogic;
        sonar_pulse      : in std_ulogic;

        -- PMOD OLED RGB
        --oled_cs_n   : out std_ulogic;key_data_to_fsm
        --oled_mosi   : out std_ulogic;
        --oled_sclk   : out std_ulogic;
        --oled_dc     : out std_ulogic;
        --oled_rst_n  : out std_ulogic;
        --oled_vbatc  : out std_ulogic;
        --oled_vddc   : out std_ulogic;
        
        -- LEDs
        leds_o : out std_ulogic_vector(7 downto 0);   
        current_state_o : out std_ulogic_vector (2 downto 0)
 );
end top_module;

architecture Behavioral of top_module is
    signal sonar_person_detected     : std_ulogic;
    signal lfsr_o                    : std_ulogic_vector (3 downto 0);
    signal key_data_to_fsm           : std_ulogic_vector (3 downto 0);
    signal key_pressed               : std_ulogic;
    signal current_state             : fsm_t;
    signal oled_data                 : std_logic_vector(15 downto 0);
    signal rst_fixed                 : std_ulogic;
begin
-- links: entity ports
-- recths: top_module entity ports

--reset as 1
rst_fixed <= '1';

oled : process (current_state, sonar_person_detected)
begin 
    leds_o <= (others => '0');
    case current_state is
       when HAPPY =>
            leds_o(0) <= '1';
            current_state_o <= "000";
       when HUNGRY =>
           leds_o(1) <= '1';
           current_state_o <= "001";
       when SLEEPY =>
            leds_o(2) <= '1';
            current_state_o <= "010";
        when SLEEPING =>
            leds_o(3) <= '1';
            current_state_o <= "011";
        when WAIT_FOR_FOOD_AMOUNT =>
            leds_o(4) <= '1';
            current_state_o <= "100";
        when SAD =>
            leds_o(5) <= '1';
            current_state_o <= "101";
    end case;

    if sonar_person_detected = '1' then
        leds_o(6) <= '1';
    else
        leds_o(7) <= '1';
    end if;
end process;


--oled : process (key_data_to_fsm)
--begin
--    case key_data_to_fsm is
--        when "0001" =>
 --           oled_data <= x"07E0"; -- green
--        when "0010" =>
--            oled_data <= x"F800"; -- red
--        when "0011" =>
--            oled_data <= x"FFE0"; -- yellow
--        when "0100" =>
--            oled_data <= x"001F"; -- blue
--        when others =>
--        	oled_data <= x"0000"; -- black
--    end case;
--end process;

E_KYPD : entity work.keypad(Behavioral)
    port map (
        kypd_c4 => kypd_c4,
        kypd_c3 => kypd_c3, 
        kypd_c2 => kypd_c2, 
        kypd_c1 => kypd_c1,
        kypd_r4 => kypd_r4, 
        kypd_r3 => kypd_r3, 
        kypd_r2 => kypd_r2, 
        kypd_r1 => kypd_r1,
        data_o  => key_data_to_fsm,
        pressed_o => key_pressed
    );

process (clk)
	variable counter : integer := 0;
begin
	if rising_edge(clk) then
		counter := counter +1;
		if counter <100000 then 
			kypd_c1 <= '0';
			kypd_c2 <= '1';
			kypd_c3 <= '1';
			kypd_c4 <= '1';
		elsif counter <200000 then 
			kypd_c1 <= '1';
			kypd_c2 <= '0';
			kypd_c3 <= '1';
			kypd_c4 <= '1';
		elsif counter <300000 then 
			kypd_c1 <= '1';
			kypd_c2 <= '1';
			kypd_c3 <= '0';
			kypd_c4 <= '1';
		elsif counter <400000 then 
			kypd_c1 <= '1';
			kypd_c2 <= '1';
			kypd_c3 <= '1';
			kypd_c4 <= '0';
		else
			counter := 0; 
			kypd_c1 <= '1';
			kypd_c2 <= '1';
			kypd_c3 <= '1';
			kypd_c4 <= '1';
		end if;
	end if;
end process;

E_MS : entity work.max_sonar(Behavioral)
    port map (
        --sonar_o           => sonar_o,
       -- sonar_receiver    => sonar_receiver,
        --sonar_transmiter  => sonar_transmiter,
        clk               => clk,
        rst_n             => rst_fixed,
        pwm_i             => sonar_pulse,
        person_detected_o => sonar_person_detected
    );

E_LFSR : entity work.lfsr(Behavioral)
    port map (
        clk      => clk,
        rst_n    => rst_n,
        random_o => lfsr_o
    );

E_FSM : entity work.fsm(Behavioral)
    port map (
      clk        => clk,
      areset_ni  => rst_n,
      person_d   => sonar_person_detected,
      key_data_i => key_data_to_fsm,
      rand_val_i => lfsr_o,
      state_o    => current_state,
      key_pressed_i => key_pressed
    );

--E_OLED : entity work.rgb_oled(STRUCTURE)
--    port map (
--        clk         => clk,
--        rst_n       => rst_n,
--        rst_o       => oled_rst_n,
--        vcc_en_o    => oled_vbatc,
--        pmod_en_o   => oled_vddc,
--        start       => open,
--        byte_o      => open,
--        ready       => '1',
--        dc_o        => oled_dc,
--        addr_o      => open,
--        data_i      => oled_data
--    );

end Behavioral;
