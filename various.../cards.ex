#mergesorting a specified deck (spades, hearts, diamonds and clubs)

defmodule Cards do 
	
	#sorting section: calls the partitioning and the merging
	def sort([n]) do [n] end
	def sort(list) do 
		{a, b} = split(list)
		merge(sort(a), sort(b))
	end

	#comparison clauses
	def lt({:card, s, v1}, {:card, s, v2}) do v1 < v2 end
	def lt({:card, :club, _}, {:card, _, _}) do true end
	def lt({:card, :diamond, _}, {:card, :heart, _}) do true end
	def lt({:card, :diamond, _}, {:card, :spade, _}) do true end
	def lt({:card, :heart, _}, {:card, :spade, _}) do true end
	def lt({:card, _, _}, {:card, _, _}) do false end

	#partitioning process
	def split(deck) do split(deck, [], []) end	
	def split([], s1, s2) do {s1, s2} end
	def split([c|t], s1, s2) do
		split(t, [c|s2], s1)
	end

	#merging process
	def merge([], s2) do s2 end
	def merge(s1, []) do s1 end
	def merge([c1|r1] = s1, [c2|r2] = s2) do 
		if lt(c1, c2) do 
			[c1|merge(r1, s2)]
		else
			[c2|merge(s1, r2)]
		end
	end	
	
	#main method
	def test() do 
		deck=[
			{:card, :heart, 5}, 
			{:card, :heart, 7}, 
			{:card, :spade, 2}, 
			{:card, :club, 9}, 
			{:card, :diamond, 4},	
		]
		sort(deck)
	end
end
	
