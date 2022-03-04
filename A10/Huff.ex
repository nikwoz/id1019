defmodule Huffman do 




###############################################################################################################
	#reads a file in search of text
	#recieves a file and retrieves a charlist
 	def sample(file) do
		{:ok, file} = File.open(file, [:read, :utf8])
		binary = IO.read(file, :all)
		File.close(file)
	
		case :unicode.characters_to_list(binary, :utf8) do
    			{:incomplete, list, _} -> list
			list -> list
		end
	end


###############################################################################################################
	#encodes a sample text	
	#accepts a charlist and retrieves a bin list
	def en_text() do
		charlist = sample("id.txt") 
		tree = tree(build(list(charlist)))			#BST(freqList)
		map = encode(hd(tree))					#mapping
		en_text(charlist, map, [])
	end
	def en_text([], _, acc) do acc end
	def en_text([h|t], map, acc) do
		if(Map.get(map, h) == :nil) do 
			en_text(t, map, acc)
		else
			en_text(t, map, Enum.concat(acc, Map.get(map, h)))
		end
	end


################################################################################################################
	#decodes huffman-compressed text given with given tree
	# accepts a bin list and retrieves a charlist
	def de_text([]) do [] end
	def de_text(bin, tree) do 
		
	end
################################################################################################################
	#create list with char-freq
	#receives a charlist and returns a tuple containing the frequencies for each index. 
	#each index is supposed to map to a character
	def list(sth) do
		tupe = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} #30 space for ASCII characters
		list(sth, tupe)
	end
	def list([], acc) do acc end
	def list([h|t], acc) do
		if((h - 97) < 0) do 
			case h do 
				32 ->  x = 1 + elem(acc, 29)
					list = put_elem(acc, 29, x)
					list(t, list)
				10 ->  x = 1 + elem(acc, 28)
					list = put_elem(acc, 28, x)
					list(t, list)
				_ -> list(t, acc)
			end

		else
			x = 1 + elem(acc, (h-97))
			list = put_elem(acc, (h-97), x)
			list(t, list)
		end
	end

################################################################################################################
	#build a tree: nodes: {freq, left, righ} leaf: {freq, char}
	#receives a list of tuples and outputs a list with one element: a recursive tuple containing the tree
	#def dotree() do 
	#	list = build(list(sample()))
	#	tree(list)
	#end
	def tree([e]) do [e] end
	def tree([{0, _}|[h2|t]]) do tree([h2|t]) end
	def tree([h1|[h2|t]]) do
		parent = {elem(h1, 0) + elem(h2, 0), h1, h2}
		tree(List.keysort([parent|t], 0))
	end

	def build(tup) do 
		build(Tuple.to_list(tup), [], 0)
	end
	def build([], acc, _) do List.keysort(acc, 0) end
	def build([h|t], acc, n) do
		cond do 
			n == 29 -> build(t, acc ++ [{h, 32}], n+1)
			n == 28 -> build(t, acc ++ [{h, 10}], n+1)
			true -> build(t, acc ++ [{h, n+97}], n+1)
		end
	end



################################################################################################################
	#encoding will receive a tree and output a map %{character  => [path]}
	#def encode() do 
	#	encode(hd(dotree()))
	#end
	def encode(tree) do 
		encode(tree, [], %{})
	end
	def encode({_, char}, code, map) do 
		map = Map.put_new(map, char, code)
		map
	end
	def encode({_, left, right}, code, map) do 
		mapLeft = encode(left, code ++ [0], map)
		mapRight = encode(right, code ++ [1], map)
		totalMap = Map.merge(mapLeft, mapRight)
		totalMap
	end
end
