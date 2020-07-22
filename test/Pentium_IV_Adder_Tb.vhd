----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2020 17:17:08
-- Design Name: 
-- Module Name: Pentium_IV_Adder_Tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pentium_IV_Adder_Tb is
--  Port ( );
end Pentium_IV_Adder_Tb;

architecture Behavioral of Pentium_IV_Adder_Tb is
component Pentium_IV_Adder is
generic (N : integer := 5);--N is number of level in the tree.
    port (A: IN std_logic_vector((2**N)-1 downto 0);
          B: IN std_logic_vector((2**N)-1 downto 0); 
          cin: IN std_logic;
          cout: out std_logic;
          S: OUT std_logic_vector((2**N)-1 downto 0));
end component;

constant nbit: integer := 5;

signal A, B: std_logic_vector(2**nbit-1 downto 0);
signal sum: std_logic_vector(2**nbit-1 downto 0);
signal cin, cout: std_logic;

begin
DUT: Pentium_IV_Adder generic map (nbit) port map (A, B, cin, cout, Sum);
cin <= '0';
--A <= (32=> '0', others => '1');
A <= (others => '1');
B <= (0=> '1', others => '0');

end Behavioral;
