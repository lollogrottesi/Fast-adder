library IEEE;
use ieee.numeric_std;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
--use WORK.constants.all; -- libreria WORK user-defined

entity MUX21_GENERIC is
	Generic (NBIT: integer:= 4);
		 	--DELAY_MUX: Time:= tp_mux);
	Port (	A:	In	std_logic_vector(NBIT-1 downto 0) ;
		B:	In	std_logic_vector(NBIT-1 downto 0);
		SEL:	In	std_logic;
		Y:	Out	std_logic_vector(NBIT-1 downto 0));
end MUX21_GENERIC;



architecture MUX21_GEN_BEHAVIORAL of MUX21_GENERIC is

begin
  process(A, B, SEL)
    begin
      if (SEL ='1')then
        Y <= A ;--after DELAY_MUX;
      else
        Y <= B;-- after DELAY_MUX;
      end if;
  end process;


end MUX21_GEN_BEHAVIORAL;



architecture MUX21_GEN_structural of MUX21_GENERIC is

--The delay in this architecture is not parametric, but 
--we have the delay defined in costant.vhd in the basic 
--gates (inv.vhd and nd2.vhd)used to implement the mux_21

component mux21 is
  	Port (	A:	In	std_logic;
		B:	In	std_logic;
		S:	In	std_logic;
		Y:	Out	std_logic);
end component;
begin
gen:
  for i in 0 to NBIT-1 generate
    instance: mux21 port map(A(i), B(i), SEL, Y(i));
  end generate gen;

end MUX21_GEN_structural;

configuration CFG_MUX21_GEN_BEHAVIORAL of MUX21_GENERIC is
  for MUX21_GEN_BEHAVIORAL
  end for;
end CFG_MUX21_GEN_BEHAVIORAL;

configuration CFG_MUX21_GEN_STRUCTURAL of MUX21_GENERIC is
  for MUX21_GEN_STRUCTURAL
    for all: mux21
      use configuration WORK.CFG_MUX21_STRUCTURAL;
    end for;
  end for;
end CFG_MUX21_GEN_STRUCTURAL;

