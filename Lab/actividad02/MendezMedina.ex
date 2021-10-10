defmodule Actividad02 do
  @moduledoc """
  Segunda actividad de laboratorio.
  
  Se debe crear un proceso que seleccione un número del uno
  al tres, el proceso principal debe de seleccionar uno tambien y 
  enviarle un mensaje al proceso A, para obetener el número del 
  proceso A, si el número de ambos empata, entonces se debe imprimir
  "El reto debe hacerse" si los números no empatan, entonces "No se
  debe de hacer el reto.
  """

  @doc """
  queProbabilidadHay: función principal, crea ambos procesos
                      y manda a llamar la función que determina
		      si se debe jugar o no.
  """
  def queProbabilidadHay() do
    principal = self()
    num_principal = :rand.uniform(3)
    identificate(principal, num_principal)

    procesoA = spawn(fn -> send(principal, {self(), :rand.uniform(3)}) end)
    receive do
      {^procesoA, num} -> identificate(procesoA, principal, num, num_principal)
      _ -> :error
    end
  end

  @doc """
  identificate(proceso, num): El proceso imprime su número pid y dice que 
                             número escojio
  identificate(mensajero, receptor, num, num_principal: El proceso se 
                            identifica, la función imprime si el juego debe 
			    hacerse o no.
  """
  def identificate(proceso, num) do
    IO.puts("--Msg Soy el proceso #{inspect proceso} y escojo el número #{inspect num}")
  end
  
  def identificate(mensajero, receptor, num, num_principal) do
    IO.puts("--Msg El proceso #{inspect mensajero} le envio a #{inspect receptor} el número #{inspect num}\n")
    
    if(num == num_principal) do
      IO.puts("El reto debe hacerse")
    else
      IO.puts("El reto NO debe hacerse")
    end
  end
  
end
