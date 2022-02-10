defmodule Prim do
	def test(n) do 
		list = Enum.to_list(2..n)
#		next(list, list)
#		sofar(list, [])
		reverse(sogood(list, []))
	end
	

##next prime search################################################
	def next([], list) do list end
	def next([h|t], list) do
		next(t, sieves(t, h, list))
	end

##deleting the elements from the list #############################
	def sieves([], _, list) do list end
	def sieves([h|t], fact, list) do 
		if rem(h, fact) == 0 do
			sieves(t, fact, List.delete(list, h))
		else 
			sieves(t, fact, list)
		end
	end
##comparing with found-primes#######push()#########################
	def sofar([], acc) do acc end
	def sofar([h|t],[]) do sofar(t, [h]) end
	def sofar([h|t], [b|e]) do
		case check(h, [b|e]) do
			:nil ->sofar(t, [b|e])
			:ok -> sofar(t, [b|e ++ [h]])
		end
	end
	def check(_, []) do :ok end 
	def check(h, [b|e]) do 
		if rem(h, b) == 0 do
			:nil
		else 
			check(h, e)
		end 
	end
##comparing with found-primes#######enqueue()######################
	def sogood([], acc) do acc end
	def sogood([h|t], []) do sogood(t, [h]) end
	def sogood([h|t], lst) do 
		case checking(h, lst) do 
			:nil ->sogood(t, lst)
			:ok -> sogood(t, [h|lst])
		end
	end
	def checking(_, []) do :ok end
	def checking(h, [b|e]) do
		if rem(h, b) == 0 do 
			:nil
		else
			checking(h, e)
		end
	end
	def reverse([]) do [] end
	def reverse([h]) do [h] end
	def reverse([h|t]) do
		reverse(t) ++ [h]
	end	

end
