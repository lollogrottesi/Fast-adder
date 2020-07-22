library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std;
use ieee.std_logic_unsigned.all;

entity RCA_Gen is 
	generic (Nbit: integer:= 6);
	Port (	A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
		Ci:	In	std_logic;
		S:	Out	std_logic_vector(Nbit-1 downto 0);
		Co:	Out	std_logic);
end RCA_Gen; 

architecture STRUCTURAL of RCA_Gen is

  signal STMP : std_logic_vector(Nbit-1 downto 0);
  signal CTMP : std_logic_vector(Nbit downto 0);

  component FA 
  Port ( A:	In	std_logic;
	 B:	In	std_logic;
	 Ci:	In	std_logic;
	 S:	Out	std_logic;
	 Co:	Out	std_logic);
  end component; 

begin

  CTMP(0) <= Ci;
  S <= STMP;
  Co <= CTMP(Nbit);
  
  ADDER1: for I in 1 to Nbit generate  --generic rca is composed by n full adder 
    FAI : FA 
	  --generic map (DFAS => DRCAS, DFAC => DRCAC) 
	  Port Map (A(I-1), B(I-1), CTMP(I-1), STMP(I-1), CTMP(I)); 
  end generate;

end STRUCTURAL;


architecture BEHAVIORAL of RCA_Gen is
signal s_tmp: std_logic_vector(Nbit downto 0);
signal tmp_a, tmp_b: std_logic_vector(Nbit downto 0);

begin

  tmp_a <= '0'&A; -- for the sum are used signal(n+1), the MSB of the result is Co  
  tmp_b <= '0'&B;
  s_tmp <= tmp_a + tmp_b + Ci;
  S <= s_tmp (Nbit-1 downto 0);-- after DRCAS;
  Co <= s_tmp (Nbit);-- after Nbit*DRCAC;	

end BEHAVIORAL;

configuration CFG_RCA_GEN_STRUCTURAL of RCA_Gen is
  for STRUCTURAL 
    for ADDER1
      for all : FA
        use configuration WORK.CFG_FA_BEHAVIORAL;
      end for;
    end for;
  end for;
end CFG_RCA_GEN_STRUCTURAL;

configuration CFG_RCA_GEN_BEHAVIORAL of RCA_Gen is
  for BEHAVIORAL 
  end for;
end CFG_RCA_GEN_BEHAVIORAL;
