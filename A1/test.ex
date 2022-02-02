defmodule Test do
	def double(n), do: n*2
	
	def to_celsius(n), do: (n-32)/1.8
	
	def rectangle(a, b), do: a*b

	def square(a), do: a*a
	
	def circle(r) do
		:math.pi()*r*r
	end
end
