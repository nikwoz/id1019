defmodule Inf do 
	
	#encapsulating the fibonacci sequence:
	def fib() do
		fn() -> fib(1,2) end
	end 
	def fib(f1, f2) do 
		[f1 | fn() -> fib(f2, f1+f2) end]
	end
	

	#taking
	def take(range, n) do 
		{:halt, res} = reduce(range, {:cont, {:sofar, 0, []}}, 
			fn(x, {:sofar, s, acc}) -> 
				s = s+1
				if s == n do 
					{:halt, [x|acc]}
				else
					{:cont, {:sofar, s, [x|acc]}}	
				end
			end
		)
		res
	end


	def head(range) do
		reduce(range, 
			{:cont, :na}, 
			fn(x, _) -> {:suspend, x} end)	
	end	
	
	#reducing a range: 
	def sum(range) do
		{:done, res} = reduce(range, {:cont, 0}, fn(x,a) -> {:cont, x+a} end)
		res
	end
	
	def prod(range) do 
		{:done, res} = reduce(range, {:cont, 1}, fn(x, a) -> {:cont, x*a} end)
		res
	end

	def reduce(_, {:halt, acc}, _) do
                {:halt, acc}
        end  

	def reduce(range, {:suspend, acc}, fun) do
		{:suspended, acc, fn(cmd) -> reduce(range, cmd, fun) end}
	end	

	def reduce({:range, from, to}, {:cont, acc}, fun) do 
		if from <= to do 
			reduce({:range, (from + 1), to}, fun.(from, acc), fun)
		else
			{:done, acc}
		end 
	end	
end
