library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package fsm_t_package is
    type fsm_t is (
        HAPPY,
	SAD,
        HUNGRY,
        WAIT_FOR_FOOD_AMOUNT,
        SLEEPY,
        SLEEPING
    );
end package;
