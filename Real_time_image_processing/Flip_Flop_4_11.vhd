----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:07 11/04/2015 
-- Design Name: 
-- Module Name:    Flip_Flop_4_11 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Flip_Flop_4_11 is
generic (BUS_WIDTH: integer := 8);
    Port ( CLK : in  STD_LOGIC;
           D : in STD_LOGIC_VECTOR (BUS_WIDTH - 1 downto 0);
           Q : out  STD_LOGIC_VECTOR (BUS_WIDTH - 1 downto 0);
           R : in  STD_LOGIC;
           EN : in  STD_LOGIC);
end Flip_Flop_4_11;

architecture Behavioral of Flip_Flop_4_11 is

signal temp : STD_LOGIC_VECTOR (BUS_WIDTH - 1 downto 0) := (others => '0');

begin
flip_flop : process (CLK, R) 	-- LABELLING IS NOT COMPULSORY
														-- we did not add other than CLK
														-- and RESET bcz they are not
														-- compulsory
begin

if	(R = '1') then temp <= (others => '0');
--elsif (CLK'event and CLK = '1') then
elsif rising_edge(CLK) then
-- following is not compulsory, means that if the above is not true the program wont execute the following
	if(EN = '1') then								-- writing EN here means the system is synchronous, means the system will check
														-- enable at every clock!
		temp <= D;
	end if;
-- non-compulsory part ends
end if;
end process flip_flop; 							-- labelling is not compulsory

Q <= temp;


end Behavioral;

