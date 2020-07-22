----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.07.2020 11:24:37
-- Design Name: 
-- Module Name: Add_sub_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Add_sub_TB is
--  Port ( );
end Add_sub_TB;

architecture Behavioral of Add_sub_TB is
component Adder_subctractor is
generic (N : integer := 5);--N is number of level in the tree.
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          add_sub: IN std_logic;
          cout: out std_logic;
          overflow: out std_logic;
          S: OUT std_logic_vector((2**N)-1 downto 0));
end component;

constant N: integer := 5;
signal A, B, S: std_logic_vector((2**N)-1 downto 0);
signal add_sub, cout, overflow: std_logic;

begin

dut : Adder_subctractor generic map (N)
                        port map (A, B, add_sub, cout, overflow, S);
                        
    process
    begin
        A <= (others => '0');
        B <= (others => '0');
        add_sub <= '0';
        wait for 10 ns;
        A <= std_logic_vector(to_unsigned (5, 32));
        B <= std_logic_vector(to_unsigned (10, 32));
        wait for 10 ns;
        add_sub <= '1';
        A <= std_logic_vector(to_unsigned (5, 32));
        B <= std_logic_vector(to_unsigned (10, 32));
        wait for 10 ns;
        A <= std_logic_vector(to_unsigned (30, 32));
        B <= std_logic_vector(to_unsigned (10, 32));
        wait for 10 ns;
        add_sub <= '0';
        A <= std_logic_vector(to_signed (-30, 32));
        B <= std_logic_vector(to_signed (10, 32));
        wait;
    end process;

end Behavioral;
