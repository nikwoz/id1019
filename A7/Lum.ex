defmodule Lum do

 
#splitting the sequence	
	def split(seq) do split(seq, 0, [], []) end
	
	def split([], l, left, right) do 
		[{left, right, l}]
	end

	def split([s|rest], l, left, right) do 
		split(rest, l+s, left ++ [s], right) ++ split(rest, l+s, left, right ++ [s])
	end
	
#counting the cost
		#base cases
	def count([]) do 0 end
	def count([_]) do 0 end
	def count(seq) do count(seq, 0, [], []) end
	
		#single cases	
	def count([], l, left, right) do 
		l + count(left) + count(right)
	end
	def count([s], l, [], right) do 
		l + s + count(right)
	end
	def count([s], l, left, []) do 
		l + count(left) + s
	end
	
		#specific cases
	def count([s|rest], l, left, right) do
		c1 = count(rest, l+s, [s|left], right)
		c2 = count(rest, l+s, left, [s|right])
		if c1<c2 do 
			c1
		else 
			c2
		end
	 end
	
end
