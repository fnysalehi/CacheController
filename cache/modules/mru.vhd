library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity mru is
    port(
    address : in std_logic_vector(5 downto 0) ;
    r :in std_logic ;
    output_writing : out std_logic 
    );
end mru;
architecture dataflow of mru is
  signal w0 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  signal w1 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  signal recent : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  
 
    begin
        
       process (r)
         begin
	 if(w0(to_integer(unsigned(address))) = '0') then
		output_writing <= '0';
		w0(to_integer(unsigned(address))) <= '1';
		recent(to_integer(unsigned(address))) <= '0';
	elsif(w1(to_integer(unsigned(address))) = '0') then
		output_writing <= '1';
		w1(to_integer(unsigned(address))) <= '1';
		recent(to_integer(unsigned(address))) <= '1';
	else
           	output_writing <= recent(to_integer(unsigned(address)));
	end if;
       end process;
     
    end dataflow;
     
