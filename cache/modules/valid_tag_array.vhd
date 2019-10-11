library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity valid_tag_array is
    port(
	clk , reset_n ,wren , invaliddata :std_logic ;
   	address:in std_logic_vector(5 downto 0);
    	wrdata :in std_logic_vector(3 downto 0);
    	output : out std_logic_vector(4 downto 0)
    );
end valid_tag_array;
architecture dataflow of valid_tag_array is
   type arraylist is array(63 downto 0) of std_logic_vector(4 downto 0); 
   signal tag_memory : arraylist ; 
   begin
    process(clk  , reset_n)
    begin
      if (reset_n ='1') then 
          for i in 0 to 63 loop
            tag_memory(i) <= "00000";
          end loop;
      elsif(clk'event and clk ='1' ) then
	output <=   tag_memory (to_integer(unsigned(address)));
      	if(wren ='1') then
              tag_memory (to_integer(unsigned(address)))(4) <= '1';
              tag_memory (to_integer(unsigned(address)))(0) <= wrdata(0);
              tag_memory (to_integer(unsigned(address)))(1) <= wrdata(1);
              tag_memory (to_integer(unsigned(address)))(2) <= wrdata(2);
              tag_memory (to_integer(unsigned(address)))(3) <= wrdata(3);
      	end if;
       end if;  
  end process;
   
end dataflow;
     
