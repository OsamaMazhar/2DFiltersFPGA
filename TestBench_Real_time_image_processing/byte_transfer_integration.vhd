----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:17:22 11/19/2015 
-- Design Name: 
-- Module Name:    byte_transfer - Behavioral 
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
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity byte_transfer is
	port (
				CLK: in std_logic;
				I: in std_logic_vector (7 downto 0);
				
				MaskInput1: in std_logic_vector (3 downto 0);
				MaskInput2: in std_logic_vector (3 downto 0);
				MaskInput3: in std_logic_vector (3 downto 0);
				MaskInput4: in std_logic_vector (3 downto 0);
				MaskInput5: in std_logic_vector (3 downto 0);
				MaskInput6: in std_logic_vector (3 downto 0);
				MaskInput7: in std_logic_vector (3 downto 0);
				MaskInput8: in std_logic_vector (3 downto 0);
				MaskInput9: in std_logic_vector (3 downto 0);

				Output: out std_logic_vector (7 downto 0)
			);
end byte_transfer;

architecture Behavioral of byte_transfer is

signal flag: std_logic:= '0';

signal TEMP1: std_logic_vector (7 downto 0);
signal TEMP2: std_logic_vector (7 downto 0);
signal TEMP3: std_logic_vector (7 downto 0);
signal TEMP4: std_logic_vector (7 downto 0);
signal TEMP5: std_logic_vector (7 downto 0);
signal TEMP6: std_logic_vector (7 downto 0);
signal TEMP7: std_logic_vector (7 downto 0);
signal TEMP8: std_logic_vector (7 downto 0);
signal TEMP9: std_logic_vector (7 downto 0);

signal FilterInput1: std_logic_vector (7 downto 0);
signal FilterInput2: std_logic_vector (7 downto 0);
signal FilterInput3: std_logic_vector (7 downto 0);
signal FilterInput4: std_logic_vector (7 downto 0);
signal FilterInput5: std_logic_vector (7 downto 0);
signal FilterInput6: std_logic_vector (7 downto 0);
signal FilterInput7: std_logic_vector (7 downto 0);
signal FilterInput8: std_logic_vector (7 downto 0);
signal FilterInput9: std_logic_vector (7 downto 0);

signal MaskSInput1: std_logic_vector (3 downto 0);
signal MaskSInput2: std_logic_vector (3 downto 0);
signal MaskSInput3: std_logic_vector (3 downto 0);
signal MaskSInput4: std_logic_vector (3 downto 0);
signal MaskSInput5: std_logic_vector (3 downto 0);
signal MaskSInput6: std_logic_vector (3 downto 0);
signal MaskSInput7: std_logic_vector (3 downto 0);
signal MaskSInput8: std_logic_vector (3 downto 0);
signal MaskSInput9: std_logic_vector (3 downto 0);

signal Output_Temp: std_logic_vector (7 downto 0);

signal buff1: std_logic_vector (7 downto 0);
signal buff2: std_logic_vector (7 downto 0);

signal pft: std_logic_vector (6 downto 0);

signal rd_en1: std_logic;
signal rd_en2: std_logic;

signal prog_full1: std_logic;
signal prog_full2: std_logic;

signal wr_en1: std_logic;
signal Reset1: std_logic;
signal full_1: std_logic;
signal empty1: std_logic;

signal wr_en2: std_logic;
signal Reset2: std_logic;
signal full_2: std_logic;
signal empty2: std_logic;

signal count: std_logic_vector(8 downto 0):= (others => '0');

component Flip_Flop_4_11 is
generic (BUS_WIDTH: integer := 8);
    Port ( CLK : in  STD_LOGIC;
           D : in STD_LOGIC_VECTOR (BUS_WIDTH - 1 downto 0);
           Q : out  STD_LOGIC_VECTOR (BUS_WIDTH - 1 downto 0);
           R : in  STD_LOGIC;
           EN : in  STD_LOGIC);
end component;

component bt_fifo is
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC
  );
end component;

component FilterTest_Syn is
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
end component;

begin

wr_en1 <= '1';
Reset1 <= '0';

wr_en2 <= '1';
Reset2 <= '0';

MaskSInput1 <= MaskInput1;
MaskSInput2 <= MaskInput2;
MaskSInput3 <= MaskInput3;
MaskSInput4 <= MaskInput4;
MaskSInput5 <= MaskInput5;
MaskSInput6 <= MaskInput6;
MaskSInput7 <= MaskInput7;
MaskSInput8 <= MaskInput8;
MaskSInput9 <= MaskInput9;


FF1: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => I, Q => TEMP1);
FF2: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => TEMP1, Q => TEMP2);
FF3: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => TEMP2, Q => TEMP3);

FIFO1: bt_fifo port map (clk => CLK, rst => Reset1, din => TEMP3, wr_en => wr_en1, rd_en => rd_en1,
								 prog_full_thresh => pft, dout => buff1, full => full_1, empty => empty1,
								 prog_full => prog_full1);
								 
FF4: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => buff1, Q => TEMP4);
FF5: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => TEMP4, Q => TEMP5);
FF6: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => TEMP5, Q => TEMP6);

FIFO2: bt_fifo port map (clk => CLK, rst => Reset2, din => TEMP6, wr_en => wr_en2, rd_en => rd_en2,
								 prog_full_thresh => pft, dout => buff2, full => full_2, empty => empty2,
								 prog_full => prog_full2);
								 	 
FF7: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => buff2, Q => TEMP7);
FF8: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => TEMP7, Q => TEMP8);
FF9: Flip_Flop_4_11 generic map (8) PORT MAP (CLK => CLK, R => '0', EN => '1', D => TEMP8, Q => TEMP9);

Filter: FilterTest_Syn port map (CLK => CLK,          FF1 => FilterInput1, FF2 => FilterInput2, FF3 => FilterInput3, FF4 => FilterInput4,
											FF5 => FilterInput5, FF6 => FilterInput6, FF7 => FilterInput7, FF8 => FilterInput8, FF9 => FilterInput9,
											MInput1 => MaskInput1, MInput2 => MaskInput2, MInput3 => MaskInput3, MInput4 => MaskInput4, 
											MInput5 => MaskInput5, MInput6 => MaskInput6, MInput7 => MaskInput7, MInput8 => MaskInput8,
											MInput9 => MaskInput9, Output => Output_Temp);

pft <= "1111011";
rd_en1 <= prog_full1;
rd_en2 <= prog_full2;

	process(CLK) begin

		if (CLK'event and CLK = '1') then
			if (TEMP9 /= 0) then flag <= '1';
			end if;
			if(flag = '1') then
				FilterInput1 <= TEMP1;
				FilterInput2 <= TEMP2;
				FilterInput3 <= TEMP3;
				FilterInput4 <= TEMP4;
				FilterInput5 <= TEMP5;
				FilterInput6 <= TEMP6;
				FilterInput7 <= TEMP7;
				FilterInput8 <= TEMP8;
				FilterInput9 <= TEMP9;
			else
				FilterInput1 <= x"00";
				FilterInput2 <= x"00";
				FilterInput3 <= x"00";
				FilterInput4 <= x"00";
				FilterInput5 <= x"00";
				FilterInput6 <= x"00";
				FilterInput7 <= x"00";
				FilterInput8 <= x"00";
				FilterInput9 <= x"00";
			end if;
		end if;
	end process; 	
	
Output <= Output_Temp;
end Behavioral;

