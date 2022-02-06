##Author: Niklas Wozniak
##Assignment: 3.5
##Task: Benchmarking the creation of an ordered List
##Task: Benchmarking the creation of an ordered BST
##Task: Contrasting both performances to reality & draw conclusions

################################################################Main method
defmodule Bench do

  def bench() do

    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    time = fn (i, f) ->
      seq = Enum.map(1..i, fn(_) -> :rand.uniform(100000) end)
      elem(:timer.tc(fn () -> f.(seq) end),0)
    end

    bench = fn (i) ->

      list = fn (seq) ->
        List.foldr(seq, list_new(), fn (e, acc) -> list_insert(e, acc) end)
      end

      tree = fn (seq) ->
        List.foldr(seq, tree_new(), fn (e, acc) -> tree_insert(e, acc) end)
      end      

      tl = time.(i, list) 
      tt = time.(i, tree)     

      IO.write("  #{tl}\t\t\t#{tt}\n")
    end

    IO.write("# benchmark of lists and tree \n")
    Enum.map(ls, bench)

    :ok
  end
########################################################################################################################
#lists
	def list_new() do [] end
 
  	#tail recursion for insertion
  	def list_insert(e, []) do [e] end
  	def list_insert(e, [h|t]) do 
  		if h > e do 
  			[e | [h|t]]
  		else
  			[h | list_insert(e, t)]
  		end
  	end
	
  ########################################################################################################################
  #ordered BST	 
  	def tree_new() do {:node, :nil, :nil, :nil} end
  
  #insertion 
	
  	def tree_insert(key, {:node, :nil, _, _}) do {:node, key, {:node, :nil, :nil, :nil}, {:node, :nil, :nil, :nil}} end
  	def tree_insert(key, {:node, k, left, right}) do 
  		if key < k do 
  			{:node, k, tree_insert(key, left), right}
  		else
  			{:node, k, left, tree_insert(key, right)}
  		end
		end
	end
end
