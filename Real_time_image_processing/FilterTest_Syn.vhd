----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:17:04 11/24/2015 
-- Design Name: 
-- Module Name:    FilterTest_Syn - Behavioral 
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FilterTest_Syn is
	Port (
			CLK: in std_logic;
			
			FF1: in std_logic_vector (7 downto 0);
			FF2: in std_logic_vector (7 downto 0);
			FF3: in std_logic_vector (7 downto 0);
			FF4: in std_logic_vector (7 downto 0);
			FF5: in std_logic_vector (7 downto 0);
			FF6: in std_logic_vector (7 downto 0);
			FF7: in std_logic_vector (7 downto 0);
			FF8: in std_logic_vector (7 downto 0);
			FF9: in std_logic_vector (7 downto 0);
			
			MInput1: in std_logic_vector (3 downto 0);
			MInput2: in std_logic_vector (3 downto 0);
			MInput3: in std_logic_vector (3 downto 0);
			MInput4: in std_logic_vector (3 downto 0);
			MInput5: in std_logic_vector (3 downto 0);
			MInput6: in std_logic_vector (3 downto 0);
			MInput7: in std_logic_vector (3 downto 0);
			MInput8: in std_logic_vector (3 downto 0);
			MInput9: in std_logic_vector (3 downto 0);
			
			Output: out std_logic_vector (7 downto 0):= (others => '0')
			);
end FilterTest_Syn;

architecture Behavioral of FilterTest_Syn is

signal MASK1 : signed (3 downto 0);
signal MASK2 : signed (3 downto 0);
signal MASK3 : signed (3 downto 0);
signal MASK4 : signed (3 downto 0);
signal MASK5 : signed (3 downto 0);
signal MASK6 : signed (3 downto 0);
signal MASK7 : signed (3 downto 0);
signal MASK8 : signed (3 downto 0);
signal MASK9 : signed (3 downto 0);

signal Pixel1_Result : signed (12 downto 0);
signal Pixel2_Result : signed (12 downto 0);
signal Pixel3_Result : signed (12 downto 0);
signal Pixel4_Result : signed (12 downto 0);
signal Pixel5_Result : signed (12 downto 0);
signal Pixel6_Result : signed (12 downto 0);
signal Pixel7_Result : signed (12 downto 0);
signal Pixel8_Result : signed (12 downto 0);
signal Pixel9_Result : signed (12 downto 0);

signal ADD1 : signed (15 downto 0);
signal ADD2 : signed (15 downto 0);
signal ADD3 : signed (15 downto 0);
signal ADD4 : signed (15 downto 0);
signal ADD5 : signed (15 downto 0);
signal ADD6 : signed (15 downto 0);
signal ADD7 : signed (15 downto 0);
signal ADD8 : signed (15 downto 0);

signal std_multiplied9_temp1: std_logic_vector (12 downto 0);
signal std_multiplied9_temp2: std_logic_vector (12 downto 0);
signal std_multiplied9: std_logic_vector (12 downto 0);

signal std_add8 : std_logic_vector(15 downto 0);

component Flip_Flop_4_11 is
generic (BUS_WIDTH: integer := 8);
    Port ( CLK : in  STD_LOGIC;
           D : in STD_LOGIC_VECTOR (BUS_WIDTH - 1 downto 0);
           Q : out  STD_LOGIC_VECTOR (BUS_WIDTH - 1 downto 0);
           R : in  STD_LOGIC;
           EN : in  STD_LOGIC);
end component;

begin

MASK1 <= signed(MInput1);
MASK2 <= signed(MInput2);
MASK3 <= signed(MInput3);
MASK4 <= signed(MInput4);
MASK5 <= signed(MInput5);
MASK6 <= signed(MInput6);
MASK7 <= signed(MInput7);
MASK8 <= signed(MInput8);
MASK9 <= signed(MInput9);

Pixel9temp1: Flip_Flop_4_11 generic map (13) PORT MAP (CLK => CLK, R => '0', EN => '1', D => conv_std_logic_vector(Pixel9_Result, Pixel9_Result'length), Q => std_multiplied9_temp1);
Pixel9temp2: Flip_Flop_4_11 generic map (13) PORT MAP (CLK => CLK, R => '0', EN => '1', D => std_multiplied9_temp1, Q => std_multiplied9_temp2);
Pixel9temp3: Flip_Flop_4_11 generic map (13) PORT MAP (CLK => CLK, R => '0', EN => '1', D => std_multiplied9_temp2, Q => std_multiplied9);

mask: process(CLK)

begin
	if(rising_edge(CLK)) then
		
		Pixel1_Result <= signed('0' & FF1) * MASK1;
		Pixel2_Result <= signed('0' & FF2) * MASK2;
		Pixel3_Result <= signed('0' & FF3) * MASK3;
		Pixel4_Result <= signed('0' & FF4) * MASK4;
		Pixel5_Result <= signed('0' & FF5) * MASK5;
		Pixel6_Result <= signed('0' & FF6) * MASK6;
		Pixel7_Result <= signed('0' & FF7) * MASK7;
		Pixel8_Result <= signed('0' & FF8) * MASK8;
		Pixel9_Result <= signed('0' & FF9) * MASK9;
		
		ADD1 <= ((15 downto 13 => Pixel1_Result(12)) & Pixel1_Result) + ((15 downto 13 => Pixel2_Result(12)) & Pixel2_Result);
		ADD2 <= ((15 downto 13 => Pixel3_Result(12)) & Pixel3_Result) + ((15 downto 13 => Pixel4_Result(12)) & Pixel4_Result);
		ADD3 <= ((15 downto 13 => Pixel5_Result(12)) & Pixel5_Result) + ((15 downto 13 => Pixel6_Result(12)) & Pixel6_Result);
		ADD4 <= ((15 downto 13 => Pixel7_Result(12)) & Pixel7_Result) + ((15 downto 13 => Pixel8_Result(12)) & Pixel8_Result);
		
		ADD5 <= ADD1 + ADD2;
		ADD6 <= ADD3 + ADD4;
		
		ADD7 <= ADD5 + ADD6;
		
		ADD8 <= abs(ADD7 + signed((15 downto 13 => std_multiplied9(12)) & std_multiplied9));
		
		std_add8 <=conv_std_logic_vector(ADD8, ADD8'length);
		
		Output <= std_add8(10 downto 3);

	end if;
end process mask;

end Behavioral;

