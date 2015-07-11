library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;
use work.records_pkg.all;
use work.subtypes_pkg.all;

entity controller is
    
    port (
        ctrl_i : in  ctrl_in_t;
        ctrl_o : out ctrl_out_t);

end entity controller;

architecture behavioral of controller is

begin  -- architecture behavioral

    comb_proc: process (ctrl_i) is
    begin  -- process comb_proc

        case ctrl_i.opcode is

            when INSTR_R_TYPE =>
                ctrl_o.regDst <= '1';           -- R[d] = ...
                ctrl_o.ALUsrc_B <= '0';         -- read reg_src_b
                ctrl_o.memtoReg <= '0';         -- no mem read
                ctrl_o.regWrite <= '1';         -- save to reg
                ctrl_o.memWen_n <= '1';         -- no mem here
                ctrl_o.branch <= '0';           -- no branch
                ctrl_o.cALU_OP <= CTRL_OP_RTYPE;

            when INSTR_ADDIU =>
                ctrl_o.regDst <= '0';           -- R[t] = ...
                ctrl_o.ALUsrc_B <= '1';         -- read Imm
                ctrl_o.memtoReg <= '0';
                ctrl_o.regWrite <= '1';         -- no mem here
                ctrl_o.memWen_n <= '1';
                ctrl_o.branch <= '0';
                ctrl_o.cALU_OP <= CTRL_OP_ADD;

			-- R[t] = Imm << 16 & 0x0000
            when INSTR_LUI =>
                ctrl_o.regDst <= '0';           -- R[t] = ...
                ctrl_o.ALUsrc_B <= '1';  		-- read Imm 
                ctrl_o.memtoReg <= '0';  		-- no mem
                ctrl_o.regWrite <= '1';  		-- save to reg
                ctrl_o.memWen_n <= '1';   -- no mem here
                ctrl_o.branch <= '0';
                ctrl_o.cALU_OP <= CTRL_OP_LUI;

			-- R[t] = MEM[R[s] + Off]
            when INSTR_LW =>
                ctrl_o.regDst <= '0';			-- R[t] = ...
                ctrl_o.ALUsrc_B <= '1';			-- read Offset (Imm)
                ctrl_o.memtoReg <= '1';			-- load from mem
                ctrl_o.regWrite <= '1';			-- save to reg
                ctrl_o.memWen_n <= '1';   -- read mem
                ctrl_o.branch <= '0';			-- no branch
                ctrl_o.cALU_OP <= CTRL_OP_ADD;	-- R[s] + Off

			-- MEM[R[s] + Off] = R[t]
            when INSTR_SW =>
                ctrl_o.regDst <= '0';			-- don't care
                ctrl_o.ALUsrc_B <= '1';			-- read Offset (Imm)
                ctrl_o.memtoReg <= '0';			-- don't care
                ctrl_o.regWrite <= '0';			-- don't save to reg
                ctrl_o.memWen_n <= '0'; -- save to mem
                ctrl_o.branch <= '0';
                ctrl_o.cALU_OP <= CTRL_OP_ADD;	-- R[s] + Off

            when INSTR_J =>
                ctrl_o.regDst <= '1';
                ctrl_o.ALUsrc_B <= '0';
                ctrl_o.memtoReg <= '0';
                ctrl_o.regWrite <= '1';
                ctrl_o.memWen_n <= '1';
                ctrl_o.branch <= '0';
                ctrl_o.cALU_OP <= "0000";

            when INSTR_JAL =>
                ctrl_o.regDst <= '1';
                ctrl_o.ALUsrc_B <= '0';
                ctrl_o.memtoReg <= '0';
                ctrl_o.regWrite <= '1';
                ctrl_o.memWen_n <= '1';
                ctrl_o.branch <= '0';
                ctrl_o.cALU_OP <= "0000";

            when INSTR_BEQ =>
                ctrl_o.regDst <= '1';   -- X
                ctrl_o.ALUsrc_B <= '0';
                ctrl_o.memtoReg <= '0'; -- X
                ctrl_o.regWrite <= '0';
                ctrl_o.memWen_n <= '1'; -- no write
                ctrl_o.branch <= '1';
                ctrl_o.cALU_OP <= CTRL_OP_BEQ;

            when INSTR_BNE =>
                ctrl_o.regDst <= '1';
                ctrl_o.ALUsrc_B <= '0';
                ctrl_o.memtoReg <= '0';
                ctrl_o.regWrite <= '0';
                ctrl_o.memWen_n <= '1';
                ctrl_o.branch <= '1';
                ctrl_o.cALU_OP <= CTRL_OP_BNE;
                
            when others => null;
        end case;
    end process comb_proc;

end architecture behavioral;
