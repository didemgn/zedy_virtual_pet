library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lfsr is
Port ( 
        clk : in std_ulogic;
        rst_n : in std_ulogic;
        random_o : out std_ulogic_vector(3 downto 0)
);
end lfsr;

architecture Behavioral of lfsr is

    signal lfsr_reg : std_ulogic_vector (3 downto 0) := "0001";
    signal feedback : std_ulogic;

begin
    feedback <= lfsr_reg(3) xor lfsr_reg(2);

    process(clk, rst_n)
        begin
            if rst_n = '0' then
                lfsr_reg <= "0001";
            elsif rising_edge(clk) then
                lfsr_reg <= lfsr_reg(2 downto 0) & feedback;
            end if;
        end process;

        random_o <= lfsr_reg;


end Behavioral;
