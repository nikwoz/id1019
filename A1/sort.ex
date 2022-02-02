defmodule Sort do
	def insert(grk, []) do [grk] end 
	def insert(grk, [h|t]) do
		cond do
			h < grk -> [h] ++ insert(grk, t)
			h >= grk-> [grk] ++ [h|t]
		end
	end



	def isort(l) do
  		isort(l, [])
	end
	def isort(l, sorted) do
		case l  do
			[] -> sorted
			[h | t] -> insert(h, sorted)
		end
	end	



	def nreverse([]) do [] end
	def nreverse([h | t]) do
		r = nreverse(t)
 		r ++ [h]
	end



	def reverse(l) do
 		 reverse(l, [])
	end
	def reverse([], r) do r end
	def reverse([h | t], r) do
  		reverse(t, [h | r])
	end



	def bench() do
		ls = [16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536]
		n = 100
		# bench is a closure: a function with an environment. 
		bench = fn(l) ->
    			seq = Enum.to_list(1..l)
   			tn = time(n, fn -> nreverse(seq) end)
    			tr = time(n, fn -> reverse(seq) end)
    			:io.format("length: ~10w  nrev: ~8w us	rev: ~8w us~n", [l, tn, tr])
		end

		# We use the library function Enum.each that will call # bench(l) for each element l in ls
		Enum.each(ls, bench)
	end

	
	# Time the execution time of the a function.
	def time(n, fun) do
  		start = System.monotonic_time(:millisecond)
  		loop(n, fun)
  		stop = System.monotonic_time(:millisecond)
  		stop - start
	end



	# Apply the function n times.
	def loop(n, fun) do
		if n == 0 do
			:ok
		else
    			fun.()
    			loop(n - 1, fun)

		end 
	end
end

