library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity data_array is
    port(
	clk, wren :std_logic ;
    	address:in std_logic_vector(5 downto 0);
    	wrdata :in std_logic_vector(15 downto 0);
    	data : out std_logic_vector(15 downto 0)
	);
end data_array;

architecture dataflow of data_array is
   type arraylist is array(63 downto 0) of std_logic_vector(15 downto 0); 
   signal memory : arraylist ;
    begin
      process(clk)
        begin
	if(clk ='1' and clk'event ) then
	  data <=  memory(to_integer(unsigned(address))); 
          if(wren = '1') then
          memory(to_integer(unsigned(address))) <= wrdata;
          end if;
       end if; 
      end process;
       
    end dataflow;
     