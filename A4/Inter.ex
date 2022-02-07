##author: Niklas Woznak
##assignment: 4
##Interpreter: creating an Elixir interpreter
####################################environment 
defmodule Env do
	def new() do 
		[]
	end
	
	def add(e, env) do 
		[e|env]
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
#	def eval_match(:ingore, ...) do ... end
	def eval_match({:atm, id}, id, []) do
		{:ok, []}
	end
	def eval_match({:var, id}, str, env) do 
		case Env.lookup(id, env) do
			nil -> {:ok, Env.add(id, str, env)}
			{_, ^str} -> {:ok, Env.add(id, str, env)}
			{_, _} -> :fail
		end
	end
	def eval_match({:cons, hp, tp}, str, env) do
		case eval_match(hp, str, env) do 
			:fail -> eval_match(tp, str, Env.add(hp, env))
			_ -> :fail
		end
	end
	def eval_match(_, _, _) do
  		:fail
	end
end
