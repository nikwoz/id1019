
defmodule Find do 
	def find(xs, ys) do 
		find(xs, ys, [])
	end
	def find(xs, [], _) do xs end 
	def find(xs, [n], _) do [n] end
	def find(xs, [hy|ty], steps) do
		{main, one, two} = split(xs, hy)
		steps = [steps|[{:one, length(one)}, {:two, length(two)}, {:one, -length(one)}, {:two, -length(two)}]]
		{main, one, two} = Tra.single({:one, (-1 * length(one))}, {main, [hy|one], two})
		{[hm|tm], one, two} = Tra.single({:two, (-1 * length(two))}, {main, one, two})
		IO.inspect([hm|tm], label: "** current: ")
		IO.inspect(steps, label: "** steps: ")
		[hm|find(tm, ty, steps)]
	end
	
	def split([], _) do [] end
	def split(list, a) do 
		i = Lists.position(list, a)
		{[], Lists.take(list, i-1), Lists.drop(list, i)}
	end
end


defmodule Few do 
	def few(xs, []) do xs end
	def few(xs, [n]) do [n] end
	def few([hx|tx], [hy|ty]) do 
		if hx == hy do 
			[hx|few(tx, ty)]
		else
			{main, one, two} = Find.split([hx|tx],hy)
			{main, one, two} = Tra.single({:one, (-1 * length(one))}, {main, [hy|one], two})
			{[hm|tm], one, two} = Tra.single({:two, (-1 * length(two))}, {main, one, two})
			IO.inspect([hm|tm], label: "** current: ")
			[hm|few(tm, ty)]
		end
	end
end



defmodule Moves do 
	def move(list, state) do 
		moves(list, state, [state])
	end	
	def moves([], _, acc) do acc end
	def moves([h|t], state, acc) do 
		next = Tra.single(h, state)
		moves(t, next, acc ++ [next])
	end
end


defmodule Tra do
	def single({dest, amount}, {main, one, two}) do
		set = length(main) - amount
		if amount == 0 do {main, one, two} end 
		if amount > 0 do 
			case dest do 
			:one -> {Lists.take(main, set), Lists.append(Lists.drop(main, set), one), two}
			:two -> {Lists.take(main, set), one, Lists.append(Lists.drop(main, set), two)}
			end
		else
			case dest do 
			:one -> {Lists.append(main, Lists.take(one, amount)), Lists.drop(one, amount), two}
			:two -> {Lists.append(main, Lists.take(two, amount)), one, Lists.drop(two, amount)}
			end
		end 
	end

end

defmodule Lists do
	def take(_, 0) do [] end
	def take([], _) do [] end
	def take([h|t], n) do	
		if(n != 0 ) do  
			[h|take(t, n-1)]	
		else 	
			[]
		end
	end
	
	def drop([], _) do [] end
	def drop([h|t], n) do 
		if(n != 0) do 
			drop(t, n-1)
		else 
			[h|t]
		end
	end
	
	def append(xs, ys) do 
		xs ++ ys
	end
	
	def member([], _) do :no end
	def member([h|t], y) do 
		case h do 
			^y -> :yes
			_ -> member(t, y)
		end
	end
	
	def position([h|t], y) do 
		case h do 
			^y -> 1
			_ -> 1 + position(t, y)
		end
	end
	
	def reverse([]) do [] end
	def reverse([h|t]) do 
		reverse(t) ++ [h]
	end
end
