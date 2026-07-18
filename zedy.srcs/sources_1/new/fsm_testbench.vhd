library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.fsm_t_package.all;

entity fsm_testbench is
end fsm_testbench;

architecture Behavioral of fsm_testbench is
    -- Signals to connect to the FSM module (Unit Under Test)
    signal clk, areset_ni : std_ulogic := '0';
    signal person_d       : std_ulogic := '1';
    signal state_o        : fsm_t;
    signal key_pressed_i  : std_ulogic := '0';
    signal key_data_i     : std_ulogic_vector(3 downto 0) := "0000";
    signal rand_val_i     : std_ulogic_vector(3 downto 0) := "0101"; 
begin
    -- Port map connecting the FSM
    uut : entity work.fsm 
        port map (clk, areset_ni, person_d, rand_val_i, state_o, key_pressed_i, key_data_i);

    -- Clock generation process: 10ns period
    clk_process : process begin
        clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
    end process;

    -- Stimulus generation process
    stim_process : process
    begin
        -- 1. Reset sequence
        areset_ni <= '0'; wait for 50 ns; areset_ni <= '1'; wait for 50 ns;

        -- 2. Test SAD state
        person_d <= '0'; wait for 500 ns;
        wait for 10 ns; -- Buffer to allow state update
        assert state_o = SAD report "Not in SAD state" severity error;

        -- 3. Test HUNGRY state
        wait for 3000 ns;
        wait for 10 ns; -- Buffer
        assert state_o = HUNGRY report "Not in HUNGRY state" severity error;

        -- 4. Test WAIT_FOR_FOOD_AMOUNT state
        key_pressed_i <= '1'; key_data_i <= "1111"; wait for 20 ns;
        key_pressed_i <= '0'; wait for 20 ns;
        wait for 10 ns; -- Buffer
        assert state_o = WAIT_FOR_FOOD_AMOUNT report "Not in WAIT_FOR_FOOD_AMOUNT state" severity error;

        -- 5. Test HAPPY state
        key_pressed_i <= '1'; key_data_i <= "0001"; wait for 20 ns;
        key_pressed_i <= '0'; wait for 50 ns;
        wait for 10 ns; -- Buffer
        assert state_o = HAPPY report "Not in HAPPY state" severity error;

        -- 6. Test SLEEPY and SLEEPING states
        key_pressed_i <= '1'; key_data_i <= "0010"; wait for 20 ns;
        key_pressed_i <= '0'; wait for 20 ns;
        wait for 100 ns; 
        assert state_o = SLEEPING report "Not in SLEEPING state" severity error;

        -- Wait long enough for sleep_target (100 cycles) to expire
        wait for 1500 ns; 
        wait for 10 ns;   -- Buffer
        assert state_o = HAPPY report "Sleep finished, should be in HAPPY state" severity error;

        report "All tests completed successfully with zero errors!" severity note;
        wait;
    end process;
end Behavioral;
