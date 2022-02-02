defmodule Fib do 
	
	#recursion going seeking backwards
	def fibnum(0) do 0 end
	def fibnum(1) do 1 end
	def fibnum(x) do 
		if x<0 do :nope
		else
			fibnum(x-2) + fibnum(x-1)
		end
	end
	
	#recursion passing the sums forwards
	def fib_num(0) do 0 end
	def fib_num(1) do 1 end
	def fib_num(x) do 
		if x<0 do :nope
		else
			fib_num(0, 1, x, 2)
		end
	end
	def fib_num(x, y, z, t) do
		cond do 
			t<z -> fib_num( y, (x+y), z, t+1)
			t>=z -> x+y
		end
	end

	# Time the execution time of the a function.
	
				
	def time_bw(n) do
  		start = System.monotonic_time(:microsecond)
		fibnum(n)
  		stop = System.monotonic_time(:microsecond)
  		stop - start
	end
	def time_fw(n) do 
  		start = System.monotonic_time(:microsecond)
		fib_num(n)
  		stop = System.monotonic_time(:microsecond)
  		stop - start
	end
	
	def bench() do
		ls = [8,10,12,14,16,18,20,22,24,26,28,30,32,38,40]
		bench = fn(l) -> 
				tb = time_bw(l)
				tf = time_fw(l)
				:io.format("length: ~10w  *tbw: ~8w us	*tfw: ~8w us~n", [l, tb, tf])
		end
		Enum.each(ls, bench)
	end
end
