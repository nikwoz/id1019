defmodule Huffman do 
	
 	def sample() do
    		'the quick brown fox jumps over the lazy dog
    		this is a sample text that we will use when we build
    		up a table we will only handle lower case letters and
    		no punctuation symbols the frequency will of course not
   		represent english but it is probably not that far off'
	end
 	def text()  do
		 'this is something that we should encode'
	end
	
	#create list with char-freq
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



	#build a tree: nodes: {sum, left, right, value}
	def dotree() do 
		list = build(list(sample()))
		tree(list)
	end
	def tree([e]) do [e] end
	def tree([{_, 0}|[h2|t]]) do tree([h2|t]) end
	def tree([h1|[h2|t]]) do
		parent = {elem(h1, 0) + elem(h2, 0), h1, h2}
		tree([parent|t])
	end


	def encode() do 	
		encode(List.to_tuple(dotree()), %{}, [])
	end
	def encode(tree, map, code) do 
		case tuple_size(tree) do
			1 -> IO.puts("length 1: ")
				encode(elem(tree, 0), map, code)
			2 -> IO.puts("** inserting in map: {#{elem(tree, 0)}, #{elem(tree, 1)}}")
			3 -> IO.puts("this is a node: --> left")
				encode(elem(tree, 1), map, code)
		end
		case tuple_size(tree) do 
			1 -> IO.puts("length 11: ")
				encode(elem(tree, 0), map, [code|1])	
			2 -> :ok2 
			3 -> IO.puts("this is a node --> right") 
				encode(elem(tree, 2), map, [code|1])
		end
	end

end
