defmodule Primes do
	defstruct [:next]
	
#primes 
	def primes() do 
		%Primes{next: fn -> {2, fn -> sieves(z(3), 2) end} end}
	end
	def next(%Primes{next: fun}) do
    		{n, f} = fun.()
    		{n, %Primes{next: f}}
  	end
	
	defimpl Enumerable do
    		def count(_) do  {:error, __MODULE__}  end
    		def member?(_, _) do {:error, __MODULE__}  end
    		def slice(_) do {:error, __MODULE__} end
    		def reduce(_,       {:halt, acc}, _fun) do
       			{:halted, acc}
    		end
    		def reduce(primes,  {:suspend, acc}, fun) do
       			{:suspended, acc, fn(cmd) -> reduce(primes, cmd, fun) end}
    		end
    		def reduce(primes,  {:cont, acc}, fun) do
     		 	{p, next} = Primes.next(primes)
      			reduce(next, fun.(p,acc), fun)
		end 
	end

#sequence of natural numbers:
	def z(n) do 
		fn() -> {n, z(n+1)} end
	end

#filtering sequence: (odd/even) 
	def filter(fun, fil) do
		{n, f} = fun.() 
		case rem(n, fil) do
			0 -> filter(f, fil)
			_ -> {n, fn() ->filter(f, fil) end}
		end
	end

#defining the sieves: 
	def sieves() do 
		sieves(z(2), 2)	
	end	
	def sieves(fun, p) do 
		{n, f} = filter(fun, p)
		{n, fn()-> sieves(f, n) end}	
	end
end	
