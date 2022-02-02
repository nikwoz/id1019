
defmodule Bin do

#toBinary conversion
	def toBin(0) do 0 end
	def toBin(x) do 
		if div(x, 2) > 0  do
			toBin(div(x, 2)) ++ [rem(x, 2)]
		else 
			[rem(x,2)]
		end
	end
	
#toBinary better conversion	
	def to_better(n) do to_better(n, []) end
	def to_better(0, b) do b end
	def to_better(n, b) do
 		 to_better(div(n, 2), [rem(n, 2) | b])
	end

#to integer conversion from binary
	def to_integer(n) do to_integer(n, 0) end
	def to_integer(n, x) do
		if (n>0) do 
			((2*rem(n,10))**n) + (to_integer(div(n, 10), x+1))
		end 
	end	

#time testing
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



