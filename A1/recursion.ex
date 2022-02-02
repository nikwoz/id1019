defmodule Rec do 

	def prod(a, b) do
		if(a==0) do
			0
		else 
			b+prod((a-1), b)
		end
	end
	
	def exp_one(x, n) do
		case n do
			0 -> 1
			1 -> x
			_ -> prod(x, exp_one(x, n-1))
		end
	end 

	def exp_two(_, 0) do 1 end
	def exp_two(x, n) do
		if(rem(x, 2)==1)do
			exp_two(x, n/2) * exp_two(x, n/2)
		else
			exp_two(x, n-1) * x
		end
	end
end
