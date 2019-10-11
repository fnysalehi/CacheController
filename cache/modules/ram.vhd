library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity ram is
    port(clk ,write :std_logic ;
    address:in std_logic_vector(9 downto 0);
    datain :in std_logic_vector(15 downto 0);
    dataout : out std_logic_vector(15 downto 0);
    Data_ready : out std_logic
    );
end ram;
architecture expression of ram is
   type arraylist is array(1023 downto 0) of std_logic_vector(15 downto 0); 
   signal ram_memory : arraylist ; 
    begin
      process(clk)
        begin
         
        
          if(write= '1')
          then
            ram_memory(to_integer(unsigned(address))) <= datain;
            dataout <=  ram_memory(to_integer(unsigned(address)));
          Data_ready <= '0';
          end if;
          if(write= '0')
          then
            dataout <=  ram_memory(to_integer(unsigned(address)));
           Data_ready <= '1';
        end if;
        end process;
    end expression;
     
