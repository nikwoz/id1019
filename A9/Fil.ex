defmodule Chopstick do 
	def start do 
		stick = spawn_link(fn -> available() end)
	end
	
	def available() do 
		receive do 
			{:request, from} -> 
				send(from, :granted)
				gone()
			:quit -> :ok
		end
	end
	
	def gone() do
		receive do 
			:return -> available()
			:quit -> :ok
		end 
	end
	
	def request(stick) do 
		send(stick, self())
		receive do
			:granted -> :ok
			:no -> :no
		end
	end
	
	def return(stick) do 
		send(stick, :return)
	end

	def terminate(stick) do 
		send(stick, :quit)
	end	
end

defmodule Philosopher do 
	

	def sleep(0) do :ok end
	def sleep(t) do
  		:timer.sleep(:rand.uniform(t))
	end
	
	
	def start(hunger, right, left, name, ctrl) do
		IO.puts("** Welcome #{name}!")
		spawn_link(fn -> dreaming(hunger, right, left, name, ctrl) end)
	end	
	
	
	def dreaming(0, right, left, name, ctrl) do 
		IO.puts("#{name} is done")
		send(ctrl, :done)
	end
	def dreaming(hunger, right, left, name, ctrl) do
		IO.puts("#{name} is dreaming")
		sleep(10)
		IO.puts("#{name} is hungry again")
		waiting(hunger, right, left, name, ctrl)
	end 
	
	
	def waiting(hunger, right, left, name, ctrl) do
		IO.puts("#{name} is waiting")
		case Chopstick.request(left) do 
			:ok ->	case Chopstick.request(right) do 	
					:ok ->	IO.puts("#{name} can eat")
						eating(hunger, left, right, name, ctrl)
					:no -> 	Chopstick.return(right)
						waiting(hunger, right, left, name, ctrl)
				end 
			:no ->	Chopstick.return(left)
				waiting(hunger, right, left, name, ctrl)
		end
	end					
	

	def eating(hunger, right, left, name, ctrl) do 
		IO.puts("#{name} is eating")
		sleep(20)
		Chopstick.return(left)
		Chopstick.return(right)
		dreaming(hunger-1, left, right, name, ctrl)
	end
	
end

defmodule Main do 
	
	def start(), do: spawn(fn -> init() end)
	def init() do 
		c1 = Chopstick.start()
		c2 = Chopstick.start()
		c3 = Chopstick.start()
		c4 = Chopstick.start()
		c5 = Chopstick.start()
		c6 = Chopstick.start()
		ctrl = self()
		Philosopher.start(5, c1, c2, "Arendt", ctrl)
 		Philosopher.start(5, c2, c3, "Hypatia", ctrl)
 		Philosopher.start(5, c3, c4, "Simone", ctrl)
 		Philosopher.start(5, c4, c5, "Elisabeth", ctrl)
		Philosopher.start(5, c5, c1, "Ayn", ctrl)
		wait(5, [c1, c2, c3, c4, c5])
	end
	def wait(0, chopsticks) do
		Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
	end
	def wait(n, chopsticks) do
		receive do
    			:done -> wait(n - 1, chopsticks)
    			:abort -> Process.exit(self(), :kill)
		end 
	end
end
