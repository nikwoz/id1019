defmodule Str do

#sequence of natural numbers:
	def z() do 
		z(0)
	end	
	def z(n) do 
		{n, fn() -> z(n+1) end}
	end

#filtering sequence: (odd/even) 
	def filter(fun, fil) do
		{n, f} = fun.() 
		case rem(n, fil) do
				#returns a function for the next odd 
			0 -> filter(f, fil)
				#returns the odd and a function for the next
			_ -> {n, fn() ->filter(f, fil) end}
		end
	end

#defining the sieves: 	
	def sieves(fun, p) do 
		{n, f} = filter(z.(3), 2)
		{n, sieves(filter(f, n), n)}
	end


end	
