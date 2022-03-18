defmodule Las do 
	def morse() do
	  {:node, :na,
	    {:node, 116,
	      {:node, 109,
	        {:node, 111,
	          {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
	          {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
	        {:node, 103,
	          {:node, 113, nil, nil},
	          {:node, 122,
	            {:node, :na, {:node, 44, nil, nil}, nil},
	            {:node, 55, nil, nil}}}},
	      {:node, 110,
	        {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
	        {:node, 100,
	          {:node, 120, nil, nil},
	          {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
	    {:node, 101,
	      {:node, 97,
	        {:node, 119,
	          {:node, 106,
	            {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
	            nil},
	          {:node, 112,
	            {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
	            nil}},
	        {:node, 114,
	          {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
	          {:node, 108, nil, nil}}},
	      {:node, 105,
	        {:node, 117,
				{:node, 32,
	    			{:node, 50, nil, nil},
	    			{:node, :na, nil, {:node, 63, nil, nil}}},
	  		  	{:node, 102, nil, nil}},
			{:node, 115,
	  			{:node, 118, {:node, 51, nil, nil}, nil},
	  			{:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
  end
########################################################################################################
#RECEIVES MORSE TREE 
#RETRIEVES MAP %{CHAR => SEQUENCE}
	def table(tree) do 
		table(tree, [], %{})
	end
	
	def table(nil, _, map) do map end
	def table({:node, :na, left, right}, seq, map) do 
		left = table(left, seq ++ [45], map)	#dash
		right = table(right, seq ++ [46], left)	#dot
		right 
	end
	def table({:node, v, left, right}, seq, map) do 	
		left = table(left, seq ++ [45], Map.put_new(map, v, seq))
		right = table(right, seq ++ [46], left) #dot
		right
	end
########################################################################################################
#RECEVIES ASCII CHARLIST
#RETRIEVES MORSE CHARLIST
	def name() do 
		'spring term 2022'
	end
	def encode() do 
		encode(name(), table(morse()), [])
	end
	def encode([], _, acc) do to_string(acc) end
	def encode([h|t], map, acc) do 
		encode(t, map, (acc ++ Map.get(map, h) ++ [32]))
	end
########################################################################################################
	#encode receives Morse Charlist
	#encode retrieves ASCII Charlist
	def text0() do 
	    '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... '
	end
	def text1() do 
		'.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- '
	end
	def decode0() do 
		decode(text0(), morse(), [])
	end
	def decode1() do 
		decode(text1(), morse(),[])
	end
	def decode([], _, acc) do (acc) end
	def decode([h|t], {:node, v, left, right}, acc) do
		case h do 
			32 -> decode(t, morse(), acc ++ [v])
			45 -> decode(t, left, acc)
			46 -> decode(t, right, acc)
			_ -> decode(t, {:node, v, left, right}, acc)
		end
	end	
end