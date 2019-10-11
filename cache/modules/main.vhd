library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity cache_ram is
    port(write, read , clk , reset:in std_logic ;
    address:in std_logic_vector(9 downto 0);
    data_in :in std_logic_vector(15 downto 0);
    data_out : out std_logic_vector(15 downto 0);
    hit : out std_logic
    );
end cache_ram;
architecture expression of cache_ram is
 signal a,b,c,request : std_logic := '0' ;
  signal data_out4 ,data_out_cache,data_out5: std_logic_vector(15 downto 0);
  signal write_cache,cache_request ,hit_cache ,cache_ready,Data_ready,finish,data_out_ram :std_logic;
    begin
     
      ram : entity work.ram port map (clk ,write, address,data_in,data_out4,Data_ready);
      cache : entity work.cache port map (clk , write, write_cache , reset , cache_request , address ,data_out4,hit_cache,cache_ready,data_out_cache);
     control : entity work.control port map (clk ,write,read,hit_cache ,Data_ready ,cache_ready ,cache_request , write_cache ,finish,data_out5);
         process(clk)
         begin 
    data_out <= data_out_cache;      
      hit <= hit_cache ;
      if(finish =  '1')
      then
        b <= not b;
      end if;
      end  process;
      process (address,write,data_in)
        begin
          c <= not c ;
        end process;
        process (b ,c)
          begin
            request <= not request;
          end process;
    end expression;
     
