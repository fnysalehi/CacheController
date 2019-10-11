library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity control is
    port(clk,iwrite,iread,hit,Data_ready ,cache_ready :in std_logic ;
      request_cache , cache_write , finish: out std_logic;
    data_out : out std_logic_vector(15 downto 0)
    );
end control;
architecture expression of control is
type state is(s0,s1,s2,s3,s4);
SIGNAL s : state:= s0 ;
    begin
    process(clk)
         begin
        case s is
        when s0 =>
          cache_write <= '0';
          finish <= '0';
          s <= s1;
        when s1 =>
            finish <= '0';
        if(iwrite = '1')
        then
          cache_write <= '0';
          request_cache <= '1'; 
          if(cache_ready = '1') 
          then
          request_cache <= '0';
          s <= s4;
        end if;
      end if;
          if(iread = '1')
          then
            cache_write <= '0';
          request_cache <= '1';
          if(cache_ready = '1')
           then
             if(hit = '1') then
             s <= s4;
           else
             s <= s2;
          
           end if;
          request_cache <= '0';
          end if;
        end if;
        when s2 => 
        
            finish <= '0';
        if(Data_ready = '1')
           then
          cache_write <= '1';
       
             s <=s3;
         end if;
         when s3 =>
         
             finish <= '0';
          request_cache <= '1';
          if(cache_ready = '1') 
          then
            s <= s4;
         request_cache <= '0';
           end if;
         when s4 =>
         finish <= '1';
          s <= s0;
     
      end case;  
      end  process ;   
    end expression;
     
