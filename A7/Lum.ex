defmodule Lum do
 
#splitting the sequence	
	def split(seq) do split(seq, 0, [], []) end
	
	def split([], l, left, right) do 
		[{left, right, l}]
	end

	def split([s|rest], l, left, right) do 
		split(rest, l+s, left ++ [s], right) ++ split(rest, l+s, left, right ++ [s])
	end


#check
	def check(seq,  mem) do
    		case Memo.lookup(mem, Enum.sort(seq)) do
      			nil -> cost(seq, mem)
      			{c, t} -> {c, t, mem}
		end 
	end

#cost
	def cost([]) do {0, :na} end 
	def cost([s]) do {0, s} end 
	def cost(seq) do 
		{cost, tree, _} = cost(Enum.sort(seq), Memo.new())
		{cost, tree} 	
	end
	
	def cost([s], mem) do {0, s, mem} end
  	def cost([s| rest] = seq, mem) do
    		{c, t, mem} = cost(rest, s, [s], [], mem)
    		{c, t, Memo.add(mem, Enum.sort(seq), {c, t})}
  	end

	
	def cost([], l, left, right, mem) do
		{c1, t1, m1} = check(left, mem)
		{c2, t2, m2} = check(right, m1) 
		({l + c1 + c2, {t1, t2}, m2}) 
	end
	def cost([s], l, left, [], mem) do
		{c, t, m} = check(left, mem) 
		{s + l + c, {t, s}, m} 
	end
	def cost([s], l, [], right, mem) do 
		{c, t, m} = check(right, mem)
		{s + l + c, {t, s}, m} 
	end
	def cost([s|rest], l, left, right, mem) do 
		{c1, t1, m} = cost(rest, l+s, [s|left], right, mem)
		{c2, t2, mm} = cost(rest, l+s, left, [s|right], mem)
		if c1 < c2 do 
			{c1, t1, m}
		else
			{c2, t2, mm}
		end
	end
		

#benchcmarking the costs
	def bench(n) do 
		for i <- 1..n do
 			{t,_} = :timer.tc(fn() -> cost(Enum.to_list(1..i)) end)
      			IO.puts(" n = #{i}\t t = #{t} us")
    		end
	end
	
end


defmodule Memo do
	def new() do %{} end
	def add(mem, key, val) do Map.put(mem, :binary.list_to_bin(key), val) end
	def lookup(mem, key) do Map.get(mem, :binary.list_to_bin(key)) end
end
