library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity alu is
    
    port (
        clk     : in std_logic;
        rst_n     : in std_logic;
        alu_i   : in  alu_in_t;
        alu_o   : out alu_out_t);

end alu;

architecture behavioral of alu is

    signal a_uns, b_uns, r_uns : unsigned(31 downto 0);
    signal bf : std_logic;  -- branch flag
    
    signal HI_LO_c, HI_LO_n : hi_lo_t;          -- HI and LO registers
 
    
begin  -- behavioral

    -- purpose: For storing HI and LO
    -- type   : sequential
    -- inputs : clk, rst_n
    -- outputs: 
    clk_proc: process (clk, rst_n)
    begin  -- process clk_proc
        if rst_n = '0' then               -- asynchronous reset (active low)
            HI_LO_c <= ((others => '0'), (others => '0'));
        elsif rising_edge(clk) then  -- rising clock edge
            HI_LO_c <= HI_LO_n;
        end if;
    end process clk_proc;

    a_uns <= unsigned(alu_i.src_a);
    b_uns <= unsigned(alu_i.src_b);

    -- purpose: ALU combinational process
    -- type   : combinational
    -- inputs : alu_i
    -- outputs: alu_o
    comb_proc: process (a_uns, b_uns, alu_i, HI_LO_c)
        
        variable mult_res_v : udword_s;   -- for storing intermediate result when
        variable shift_v : uword_s;
        variable branch_res : uword_s; -- store intermediate result when branch instr.
        
    begin  -- process comb_proc

        -- default values
        r_uns <= (others => '0');
        bf <= '0';
        HI_LO_n <= HI_LO_c;
        
        case alu_i.op is
            
            when ALU_OP_ADDU =>
                r_uns <= a_uns + b_uns;
                
            when ALU_OP_SUBU =>
                r_uns <= a_uns - b_uns;

            when ALU_OP_MULTU =>        
                mult_res_v := a_uns * b_uns;
                HI_LO_n.HI <= word_s(mult_res_v(63 downto 32));
                HI_LO_n.LO <= word_s(mult_res_v(31 downto 0));
                            
            when ALU_OP_AND =>
                r_uns <= a_uns and b_uns;

            when ALU_OP_OR =>
                r_uns <= a_uns or b_uns;

            when ALU_OP_XOR =>
                r_uns <= a_uns xor b_uns;

            when ALU_OP_SLL =>
                shift_v := b_uns;
                -- shift 1
                if alu_i.shamt(0) = '1' then
                    shift_v := shift_v(30 downto 0) & '0';
                end if;
                -- shift 2
                if alu_i.shamt(1) = '1' then
                    shift_v := shift_v(29 downto 0) & "00";
                end if;
                -- shift 4
                if alu_i.shamt(2) = '1' then
                    shift_v := shift_v(27 downto 0) & "0000";
                end if;
                -- shift 8
                if alu_i.shamt(3) = '1' then
                    shift_v := shift_v(23 downto 0) & x"00";
                end if;
                -- shift 16
                if alu_i.shamt(4) = '1' then
                    shift_v := shift_v(15 downto 0) & x"0000";
                end if;
                r_uns <= shift_v;

            when ALU_OP_SRL =>
                shift_v := b_uns;
                -- shift 1
                if alu_i.shamt(0) = '1' then
                    shift_v := '0' & shift_v(31 downto 1);
                end if;
                -- shift 2
                if alu_i.shamt(1) = '1' then
                    shift_v := "00" & shift_v(31 downto 2);
                end if;
                -- shift 4
                if alu_i.shamt(2) = '1' then
                    shift_v := "0000" & shift_v(31 downto 4);
                end if;
                -- shift 8
                if alu_i.shamt(3) = '1' then
                    shift_v := x"00" & shift_v(31 downto 8);
                end if;
                -- shift 16
                if alu_i.shamt(4) = '1' then
                    shift_v := x"0000" & shift_v(31 downto 16);
                end if;
                r_uns <= shift_v;
                
            when ALU_OP_SRA =>
                r_uns <= b_uns(31 downto 31) & b_uns(31 downto 1);

            when ALU_OP_SLT =>
                if signed(a_uns) < signed(b_uns) then
                    r_uns <= x"00000001";
                else
                    r_uns <= x"00000000";
                end if;

            when ALU_OP_SLTU =>
                if a_uns < b_uns then
                    r_uns <= x"00000001";
                else
                    r_uns <= x"00000000";
                end if;

            when ALU_OP_MFHI =>
                r_uns <= unsigned(HI_LO_c.HI);

          when ALU_OP_MFLO =>
                r_uns <= unsigned(HI_LO_c.LO);

          when ALU_OP_LUI =>
              r_uns <= b_uns(15 downto 0) & x"0000";

          when ALU_OP_LW =>
              r_uns <= a_uns + b_uns;

          when ALU_OP_SW =>
              r_uns <= a_uns + b_uns;
 
          when ALU_OP_J =>

          when ALU_OP_JAL =>

          when ALU_OP_JR =>
            
          when ALU_OP_BEQ =>
              --branch_res := a_uns - b_uns;
              if a_uns = b_uns then
                  bf <= '1';
              end if;
              r_uns <= (others => '0');
            
          when ALU_OP_BNE =>
              --branch_res := a_uns - b_uns;
              if a_uns /= b_uns then
                  bf <= '1';
              end if;
              r_uns <= (others => '0');
                
          when others =>
                r_uns <= (others => '0');
        end case;
    end process comb_proc;
    
    alu_o.branch <= bf;
    alu_o.result <= word_s(r_uns);  

end behavioral;
