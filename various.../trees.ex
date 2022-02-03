defmodule Tre do

###################################################################################################################################################	
	#deleting
	def del(key, {:node, k, v, left, right}) do 
		if key < k do 
			{:node, k, v, del(key, left), right}
		else
			{:node, k, v, left, del(key, right)}
		end
	end
	
###################################################################################################################################################
	#inserting
	def ins(key, val, :nil) do {:node, key, val, :nil, :nil} end
	def ins(key, val, {:node, k, v, left, right}) do 
		if key < k do 
			{:node, k, v, ins(key, val, left), right}
		else
			{:node, k, v, left, ins(key, val, right)}
		end
	end	
	
###################################################################################################################################################
	#modifying
	def mod(_, _, :nil) do :nil end
	def mod(key, val, {:node, key, _, right, left}) do 
		{:node, key, val, right, left}
	end
	def mod(key, val, {:node, k, v, left, right}) do
		if key < k do 
			{:node, k, v, mod(key, val, left), right}
		else
			{:node, k, v, left, mod(key, val, right)}
		end
	end

###################################################################################################################################################
	#contains
	def member(_, :nil) do :no end
	def member(elm, {:leaf, elm}) do :yes end
	def member(_, {:leaf, _}) do :no end
	def member(elm, {:node, elm, _, _}) do :yes end
	def member(elm, {:node, e, left, right}) do 
		if elm < e  do 
			member(elm, left)
		else 
			member(elm, right)
		end
	end

###################################################################################################################################################
	#lookup key->value
	def lup(_, :nil) do :no end
	def lup(elm, {:node, elm, val, _, _}) do {:value, val} end
	def lup(elm, {:node, e, _, left, right}) do 
		if elm < e do 
			lup(elm, left)
		else
			lup(elm, right)
		end
	end
end
