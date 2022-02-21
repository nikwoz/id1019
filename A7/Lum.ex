defmodule Lum do
 
#splitting the sequence	
	def split(seq) do split(seq, 0, [], []) end
	
	def split([], l, left, right) do 
		[{left, right, l}]
	end

	def split([s|rest], l, left, right) do 
		split(rest, l+s, left ++ [s], right) ++ split(rest, l+s, left, right ++ [s])
	end


#checking the mem
	def check(seq,  mem) do
    		case Memo.lookup(mem, seq) do
      			nil -> count(seq, mem)
      			{c, t} -> {c, t, mem}
		end 
	end

	
#counting the cost
	def count([]) do {0} end
	def count([_]) do {0} end

	def count(seq) do 
		{count, tree, _} = count(seq, Memo.new())
		{count, tree}
	end
	
  	def count([s], mem) do {0, s, mem} end
  	def count(seq, mem) do
    		{c, t, mem} = count(seq, 0, [], [], mem)			#problema: mem no es tree
    		{c, t, Memo.add(mem, seq, {c, t})}
  	end

	def count([], l, left, right, mem) do 
		{(l + elem(count(left), 0) + elem(count(right), 0)), mem}
	end
				
	def count([s], l, [], right, mem) do 				
		{(l + s + elem(count(right), 0)), mem}
	end

	def count([s], l, left, [], mem) do 
		{(l + elem(count(left), 0) + s), mem}
	end
	


	def count([s|rest], l, left, right, mem) do
		c1 = {count(rest, l+s, [s|left], right, mem), {s, left}}
		c2 = {count(rest, l+s, left, [s|right], mem), {s, right}} 
		if (elem(c1, 0) < elem(c2, 0)) do 
			c1  
		else 
			c2 
		end
	 end 

#benchcmarking the costs
	def bench(n) do 
		for i <- 1..n do
 			{t,_} = :timer.tc(fn() -> count(Enum.to_list(1..i)) end)
      			IO.puts(" n = #{i}\t t = #{t} us")
    		end
	end
	
end


defmodule Memo do 
	def new() do %{} end
	def add(mem, key, val) do Map.put(mem, key, val) end
	def lookup(mem, key) do Map.get(mem, key) end
end
