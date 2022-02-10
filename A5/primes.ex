defmodule Prim do
	def test() do 
		ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024, 16*1024, 24*1024]
		bench(ls)
	end
	
	def bench([]) do :ok end
	def bench([h|t]) do 
		list = Enum.to_list(2..h)
		t0 = Time.utc_now()
		next(list, list)
		t1 = Time.utc_now()
		sofar(list, [])
		t2 = Time.utc_now()
		reverse(sogood(list, []))
		t3 = Time.utc_now()
		b1 = Time.diff(t1, t0, :microsecond)
		b2 = Time.diff(t2, t1, :microsecond)
		b3 = Time.diff(t3, t2, :microsecond)
	  	#:io.format(file, "~w\t~w\t~w\n", [i, tl, tt])
	  	IO.write("  #{b1}\t\t\t#{b2}\t\t\t#{b3}\n")
		bench(t)
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
