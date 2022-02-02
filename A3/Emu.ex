############################################################################################################################################
defmodule Emu do 
	
	def run() do 
		{code, mem} = Program.load()
		out = Out.new()
		reg = Register.new()
		run(0, code, reg, mem, out)
	end
	
	def run(pc, code, reg, mem, out) do
		next = Program.read_instruction(code, pc)
		case next do
			:halt -> Out.close(out)
			{:add, rd, rs, rt} ->
				pc = pc + 4
				s = Register.read(reg, rs)
				t = Register.read(reg, rt)
				reg = Register.write(reg, rd, s + t)
				run(pc, code, reg, mem, out)
			{:sub, rd, rs, rt} -> 
				pc = pc + 4
				s = Register.read(reg, rs)
				t = Register.read(reg, rt)
				reg = Register.write(reg, rd, s - t)
				run(pc, code, reg, mem, out)
			{:addi, rd, rs, imm} ->
				pc = pc + 4
				s = Register.read(reg, rs)
				reg = Register.write(reg, rd, s + imm)
				run(pc, code, reg, mem, out)
			{:lw, rd, off, tag} -> 
				pc = pc + 4
				reg = Register.write(reg, rd, Program.data_read(mem, tag))
				run(pc, code, reg, mem, out)
			{:sw, rs, off, tag} ->
				^pc = pc + 4
				Program.data_write(mem, rs, tag)
				run(pc, code, reg, mem, out)
			{:beq, rs, rt, tag} -> 
				case rs do
					rt -> run(Program.branch(mem, tag), code, reg, mem, out)
					_ -> run(pc + 4, code, reg, mem, out)
				end
			{:bne, rs, rt, tag} -> 
				s = Register.read(reg, rs)
				t = Register.read(reg, rt)
				cond do
					s != t -> run(Program.branch(mem, tag), code, reg, mem, out)	
					s == t -> run(pc + 4, code, reg, mem, out) 
				end
			{:out, rs} ->
        			 pc = pc + 4
        			 s = Register.read(reg, rs)
        			 out = Out.put(out, s)
        			 run(pc, code, reg, mem, out)
			 {:label, _} -> 
				 pc = pc + 4
				 run(pc, code, reg, mem, out)
		end
	end
end

############################################################################################################################################
defmodule Program do 
	def load() do
	    {[{:addi, 1, 0, 5},     # $1 <- 5
	     {:lw, 2, 0, :arg},    # $2 <- data[:arg]
	     {:add, 4, 2, 1},      # $4 <- $2 + $1
	     {:addi, 5, 0, 1},     # $5 <- 1
	     {:label, :loop},
	     {:sub, 4, 4, 5},      # $4 <- $4 - $5
		 {:out, 4},            # out $4
		 {:bne, 4, 0, :loop},  # branch if not equal
		 :halt], 
		 %{:loop => 20, :arg => 12}} #memory... predefined by us...
	end
	
	def branch(mem, tag) do elem(Map.fetch(mem, tag), 1) end 
	
	def data_read(mem, tag) do elem(Map.fetch(mem, tag) , 1) end
	def data_write(mem, imm, tag) do Map.put(mem, tag, imm) end


	#kind of complicated to update "in base4", but still pretty...
	def read_instruction([h|t], pc) do 
		case pc do
			0 -> h
			_ -> read_instruction(t, pc - 4)
		end
	end
end
############################################################################################################################################
defmodule Register do
	def new() do
		#create the sturcture of registers
		{
		 0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,
		 0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,
		}
	end

	def read(reg, rs) do elem(reg, rs)	end
	def write(reg, rd, imm) do 	put_elem(reg, rd, imm) 	end

end
############################################################################################################################################
defmodule Out do 
	def new() do [:init] end
	def put(out, s) do out ++ [s] end
	def close(out) do out end
end