library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity cache is
    port(clk,hole_write,write,reset, cache_request :in std_logic ;
    address:in std_logic_vector(9 downto 0);
    data_in :in std_logic_vector(15 downto 0);
     hit , cache_ready: out std_logic;
    data_out : out std_logic_vector(15 downto 0)
    );
end cache;
architecture expression of cache is
  signal wren1 , wren2 ,invaliddata ,out_lru ,w0_valid , w1_valid :std_logic;
  signal r : std_logic  := '0';
  signal index : std_logic_vector(5 downto 0);
  signal tag : std_logic_vector (3 downto 0);
  signal tag_out1 , tag_out2 : std_logic_vector(4 downto 0);
  signal data_out1 : std_logic_vector(15 downto 0);
  signal data_out2 : std_logic_vector(15 downto 0);
type state is(s0,s1,s2,s3,s4);
SIGNAL s : state:= s4 ;
    begin
     
       LGEN1 : for i in 0 to 5 generate  index(i)<=address(i); end generate; 
      LGEN2 : for i in 6 to 9 generate  tag(i-6)<=address(i); end generate; 
      data_array1 : entity work.data_array port map (clk,wren1,index,data_in,data_out1);
      data_array2 : entity work.data_array port map (clk,wren2,index,data_in,data_out2);
      valid_tag_array1 : entity work.valid_tag_array port map (clk,reset,wren1,invaliddata,index,tag,tag_out1);
      valid_tag_array2 : entity work.valid_tag_array port map (clk,reset,wren2,invaliddata,index,tag,tag_out2);
      lru : entity work.mru port map (index,r,out_lru);
        miss_hit : entity work.miss_hit port map (clk,tag,tag_out1,tag_out2,hit,w0_valid,w1_valid);
          
         process(clk)
         begin 
        case s is
        when s0 =>
        cache_ready <='0';
        invaliddata <= '0';
      if(cache_request = '1')
        then
         s <= s1;
       end if;
        when s1 => 
           cache_ready <='0';
           if(write = '1')
           then
           r <= not r ;
           wren2 <= out_lru ;
           wren1 <= not out_lru;
         end if;
         if(write= '0')
         then
           wren1 <='0';
           wren2 <='0';
         end if;
         s <= s2;
         when s2 =>
        cache_ready <='0';
         s <= s3;
         when s3 =>
          cache_ready <='0';
          if(w0_valid = '1' and hole_write = '0')
          then
          data_out <= data_out1;
        end if;
         if(w1_valid = '1' and hole_write = '0')
          then
          data_out <= data_out2;
        end if;
        if(hole_write = '1')
          then
          invaliddata <= '1';
        end if;
         s <= s4;
         when s4 =>
          cache_ready<='1';
          s <= s0;
    
      end case;
      end  process ;   
    end expression;
     