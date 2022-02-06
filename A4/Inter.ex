##author: Niklas Woznak
##assignment: 4
##Interpreter: creating an Elixir interpreter
####################################environment 
defmodule Env do
	def new() do 
		[]
	end
	
	def add(id, str, env) do
		[{id, str}|env]
	end
	
	def lookup(_, []) do :nil end
	def lookup(id, [h|t]) do 
		case h do 
			{^id, str} -> {id, str}
			[] -> :nil
			_ -> lookup(id, t)
		end
	end
	
	def remove(id, env) do 
		List.delete(env, lookup(env, id))
	end
end

####################################expression evaluation
defmodule Eager do 
	def eval_expr({:atm, id}, []) do {:ok, id} end
	def eval_expr({:atm, id}, _) do {:ok, id} end
	def eval_expr({:var, id}, env) do 
		case Env.lookup(id, env) do
			:nil -> :error
			{_, str} -> {:ok, str} 
		end 
	end
	def eval_expr({:cons, head, tail}, env) do	
		case eval_expr(head, env) do 
			:error -> :error
			{:ok, acc} ->
				case eval_expr(tail, env) do 
					:error -> :nil
					{:ok, ts} -> {:ok, Tuple.append({acc}, ts)}
				end
		end
	end
end
