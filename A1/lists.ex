defmodule Lis do
	def th(n, [h|t]) do
		case n do
			0 -> h
			_ -> th((n-1), t)
		end
	end

	def len([])do 0 end
	def len([h|t]) do
		case t do
			[] -> 1
			_ -> 1 + len(t)
		end
	end

	def sum([]) do 0 end
	def sum([h|t]) do 
		case h do 
			[] -> 0
			_ -> h + sum(t)
		end
	end


	def dup([h|t]) do
		case t do 
			[]-> [h, h]
			_ -> [h, h] ++ dup(t) 
		end
	end
	
	def add(x, [h|t]) do
		cond do
			h == x -> [h|t]
			t == [] ->[h,x]
			h != x -> [h] ++ add(x, t) 
		end
	end

	def remove(x, []) do [] end
	def remove(x, [h|t]) do
		cond do	
			t == [] -> cond do
					h == x -> []
					h != x -> [h]
					end
			h == x -> [] ++ remove(x, t)
			h != x -> [h] ++ remove(x, t)
		end
	end

	def unique([]) do [] end	
	def unique([h|t]) do
		[h] ++ unique(remove(h, t))
	end
	
	def reverse([]) do [] end
	def reverse([h]) do [h] end
	def reverse([h|t]) do
		reverse(t) ++ [h]
	end	
end












