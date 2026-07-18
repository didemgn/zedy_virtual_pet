library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.fsm_t_package.all;

entity fsm is
    Port (
        clk, areset_ni : in std_ulogic;
        person_d       : in std_ulogic;
        rand_val_i     : in std_ulogic_vector(3 downto 0);
        state_o        : out fsm_t;
        key_pressed_i  : in std_ulogic;
        key_data_i     : in std_ulogic_vector(3 downto 0)
    );
end fsm;

architecture Behavioral of fsm is

    signal state_ff  : fsm_t := HAPPY;
    signal state_nxt : fsm_t := HAPPY;

    constant CLK_FREQ      : integer := 100000000;  --10
    constant ABSCENCE_TIME : integer := 4 * CLK_FREQ;
    
    signal hunger_period        : integer range 10 * CLK_FREQ to 20 * CLK_FREQ := 10 * CLK_FREQ ; 
    signal hunger_counter       : integer range 0 to 20 * CLK_FREQ:= 0;
    
    signal abscence_counter : integer range 0 to ABSCENCE_TIME := 0;

    signal sleep_counter : integer range 0 to 10* CLK_FREQ := 0;
    signal sleep_target  : integer range 5 * CLK_FREQ to 14 * CLK_FREQ := 5 * CLK_FREQ;
    
    signal sleep_counter_1 : integer range 0 to 14 * CLK_FREQ;
    constant sleep_target_1  : integer := 14 * CLK_FREQ;

    signal TRANSITION_TIME     : integer := 2 * CLK_FREQ ;
    signal transition_counter   : integer range 0 to 2 * CLK_FREQ := 0;

    signal key_pressed_prev : std_ulogic := '0';
    signal key_pressed_edge : std_ulogic;    
begin

    seq : process(clk, areset_ni)
        variable rand_sec : integer;
        variable rand_sec_1 : integer;
        variable hungry_sec: integer;

    begin
        if areset_ni = '0' then
            state_ff <= HAPPY;
            abscence_counter <= 0;
            hunger_counter <= 0;
            sleep_counter <= 0;
            hunger_period <= 10 * CLK_FREQ ;
            sleep_target <= 5 * CLK_FREQ;
            --sleep_target_1 <= 14 * CLK_FREQ;
            sleep_counter_1 <= 0;
            key_pressed_prev <= '0';
        elsif rising_edge(clk) then
            key_pressed_prev <= key_pressed_i;
            key_pressed_edge <= key_pressed_i and not key_pressed_prev;

            state_ff <= state_nxt;

            -- Counting absence time
            if person_d = '0' then
                if abscence_counter < ABSCENCE_TIME then
                    abscence_counter <= abscence_counter + 1;
                end if;
            else
                abscence_counter <= 0;
            end if;

           if state_ff = WAIT_FOR_FOOD_AMOUNT then           
                hunger_counter <= 0;           
                if transition_counter >= TRANSITION_TIME and
                   key_pressed_edge = '1' then           
                    if to_integer(unsigned(key_data_i)) <= 9 then
                        hungry_sec := 10 + to_integer(unsigned(key_data_i));
                        hunger_period <= hungry_sec * CLK_FREQ;
                    end if;            
                end if;
            elsif state_ff = HAPPY or state_ff = SAD then           
                if hunger_counter < hunger_period then
                    hunger_counter <= hunger_counter + 1;
               else
                    hunger_counter <= 0;
                end if;            
            end if;
            
               
            -- Counting sleeping time
            if state_ff = SLEEPING then
                rand_sec := 5 + (to_integer(unsigned(rand_val_i)) mod 6);
                sleep_target <= rand_sec * CLK_FREQ;
                sleep_counter <= 0;

                if sleep_counter < sleep_target then
                     sleep_counter <= sleep_counter + 1;
                end if;

            else
                sleep_counter <= 0;
            end if;
            
            -- Counting sleeping time 1
            if state_ff = HAPPY or state_ff= SAD or state_ff = HUNGRY or state_ff = WAIT_FOR_FOOD_AMOUNT then
               -- rand_sec_1 := 5 + (to_integer(unsigned(rand_val_i)) mod 6);
                --sleep_target_1 <= rand_sec * CLK_FREQ;
                sleep_counter_1 <= 0;
                if sleep_counter_1 < sleep_target_1 then
                     sleep_counter_1 <= sleep_counter_1 + 1;
                end if;
            else
                sleep_counter_1 <= 0;
            end if;
            
            if (state_ff = WAIT_FOR_FOOD_AMOUNT or state_ff = SLEEPY) then
                if transition_counter < TRANSITION_TIME then
                    transition_counter <= transition_counter + 1;
                end if;
                
            else
                transition_counter <= 0;
            end if;
            
        end if;
    end process;

    state_o <= state_ff;

    next_state : process(
        state_ff,
        person_d,
        key_pressed_edge,
        key_data_i,
        abscence_counter,
        sleep_counter,
        sleep_target,
        sleep_counter_1,
        transition_counter
    )
    begin
        state_nxt <= state_ff;

        case state_ff is

            when HAPPY =>
                if hunger_counter >= hunger_period then
                    state_nxt <= HUNGRY;
                elsif abscence_counter >= ABSCENCE_TIME then
                    state_nxt <= SAD;
                elsif key_pressed_edge = '1' and key_data_i = "0010" then
                    state_nxt <= SLEEPY;
               -- end if;
                elsif sleep_counter_1 >= sleep_target_1 then
                    state_nxt <= SLEEPY;
                end if;

            when SAD =>
                if hunger_counter >= hunger_period then
                    state_nxt <= HUNGRY;
                elsif person_d = '1' then
                    state_nxt <= HAPPY;
                elsif key_pressed_edge = '1' and key_data_i = "0010" then
                    state_nxt <= SLEEPY;
                elsif sleep_counter_1 >= sleep_target_1 then
                    state_nxt <= SLEEPY;
               -- end if;
                end if;

            when HUNGRY =>
                if key_pressed_edge = '1' and key_data_i = "0000" then
                    state_nxt <= WAIT_FOR_FOOD_AMOUNT;
                --end if;
                elsif sleep_counter_1 >= sleep_target_1 then
                    state_nxt <= SLEEPY;
               end if;
            
            when WAIT_FOR_FOOD_AMOUNT =>
               if transition_counter >= TRANSITION_TIME then
                  if key_pressed_edge = '1' then
                       if to_integer(unsigned(key_data_i)) <=9  then
                           --if fullness_level >=10 then
                                state_nxt <= HAPPY;
                           --end if;
                     end if;
                  end if;
                end if;
                    
            when SLEEPY =>
                if transition_counter >= TRANSITION_TIME then
                    state_nxt <= SLEEPING;
                end if;
                
            when SLEEPING =>
                if sleep_counter >= sleep_target then
                    state_nxt <= HAPPY;
                end if;

        end case;
    end process;

end Behavioral;