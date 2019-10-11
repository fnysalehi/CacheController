library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity miss_hit is
    port(
      clk : in std_logic ;
    tag :in std_logic_vector(3 downto 0);
    w0 :in std_logic_vector(4 downto 0);
    w1 : in std_logic_vector(4 downto 0);
    hit , w0_valid , w1_valid : out std_logic
    
    );
end miss_hit;
architecture dataflow of miss_hit is
  
 signal wv1,wv0: std_logic;
 begin
   process (clk)
      begin
       if(w0(4)='1' and tag(0)=w0(0) and tag(1)=w0(1) and tag(2)=w0(2) and tag(3)=w0(3)) then
          w0_valid <='1';
          wv0 <= '1';
        else 
         w0_valid <='0';
          wv0 <= '0';
        end if;
        if( w1(4)='1' and tag(0)= w1(0) and tag(1)=w1(1) and  tag(2)=w1(2) and tag(3)=w1(3)) then
          w1_valid <='1';
          wv1 <= '1';
        else 
          w1_valid <='0';
          wv1 <= '0';
        end if;
        if(wv1='1' or wv0='1') then
          hit <= '1';
        else 
          hit <= '0';
   	end if;
     end process ;
end dataflow;
     