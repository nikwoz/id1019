defmodule Tree do 
	def member(_, :nil) do :no end
	def member(elem, {:leaf, elem}) do :yes end
	def member(_, {:leaf, _}) do :no end
	def member(elem, {:node, elem, _, _}) do :yes end
	def member(elem, {:node, _, left, right}) do
		case member(elem, left) do
			:yes -> :yes
			:no -> member(elem, right)
		end
	end

	def mem(_, :nil) do :no end
	def mem(ele, {:leaf, ele}) do :yes end 
	def mem(_, {:leaf, _}) do :no end
	def mem(ele, {:node, ele, _, _}) do :yes end
	def mem(ele, {:node, e, left, right}) do 
		if ele>e then do
			mem(ele, right)
		else
			mem(ele, left)
		end
	end
end
