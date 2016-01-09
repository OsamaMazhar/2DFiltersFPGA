--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:05:57 12/13/2015
-- Design Name:   
-- Module Name:   /home/osama/Documents/FPGA/Osama/TestBench_Real_time_image_processing/TestBench_bytetransfer.vhd
-- Project Name:  TestBench_Real_time_image_processing
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: byte_transfer
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestBench_bytetransfer IS
END TestBench_bytetransfer;
 
ARCHITECTURE behavior OF TestBench_bytetransfer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT byte_transfer
    PORT(
				CLK: in std_logic;
				
				MaskInput1: in std_logic_vector (3 downto 0);
				MaskInput2: in std_logic_vector (3 downto 0);
				MaskInput3: in std_logic_vector (3 downto 0);
				MaskInput4: in std_logic_vector (3 downto 0);
				MaskInput5: in std_logic_vector (3 downto 0);
				MaskInput6: in std_logic_vector (3 downto 0);
				MaskInput7: in std_logic_vector (3 downto 0);
				MaskInput8: in std_logic_vector (3 downto 0);
				MaskInput9: in std_logic_vector (3 downto 0);
				
				I: in std_logic_vector (7 downto 0);
				Output: out std_logic_vector (7 downto 0)

        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
	signal I : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
	
	signal Output : std_logic_vector(7 downto 0);
	
	--Mask Values
	
	signal MaskInput1: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput2: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput3: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput4: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput5: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput6: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput7: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput8: std_logic_vector (3 downto 0):= (others => '0');
	signal MaskInput9: std_logic_vector (3 downto 0):= (others => '0');
	
-- file read/write signals
	signal endoffile : bit := '0';
	signal dataread: std_logic_vector (7 downto 0):= (others => '0');
	signal count: integer:=0;
	signal thresh: integer:=0;
	
 BEGIN
	CLK <= not (CLK) after 1 ns;
	MaskInput1 <= x"1";
	MaskInput2 <= x"0";
	MaskInput3 <= x"F";
	MaskInput4 <= x"2";
	MaskInput5 <= x"0";
	MaskInput6 <= x"E";
	MaskInput7 <= x"1";
	MaskInput8 <= x"0";
	MaskInput9 <= x"F";
	
	thresh <= 12;
	
--reading process
	reading:
   process
		FILE infile : text is in "Lena128x128g_8bits.dat";
		variable inline : line;
		variable I_var : std_logic_vector (7 downto 0);
		
		begin
		wait until CLK = '1' and CLK'event;
		if (not endfile(infile)) then -- checking the end of file
	
			readline (infile, inline);
			read (inline, I_var);
			I <= I_var;
			if(count > thresh) then
				dataread <= Output;
--				count <= 12;				
			else
				dataread <= x"00";
			end if;
			count <= count + 1;
		else
			endoffile <= '1';
		end if;
	
	end process reading;
	
	writing:
	process
		FILE outfile : text is out "Processed_Image.txt";
		variable outline : line;
		
		begin
		wait until CLK = '0' and CLK'event;
			if (endoffile = '0') then
				write (outline, dataread, right, 8);
				writeline(outfile, outline);
			else
				null;
		end if;
	end process writing;
	
	BT: byte_transfer port map (CLK, MaskInput1, MaskInput2, MaskInput3,
												MaskInput4, MaskInput5, MaskInput6,
												MaskInput7, MaskInput8, MaskInput9,
												I, Output);
	
	end behavior;