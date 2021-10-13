defmodule Practica01 do
  @moduledoc """
  Primera actividad de laboratorio.
  1. Programar una calculadora utilzando atómicos.
  2. Implementar con caza de patrones la reversa de una lista.
  3. Dada una lista, eliminar sus duplicados sin utilizar 
     funciones de la biblioteca List
  """
  
  @doc """ 
  calculadora_atom: Recibe un atómico que representa la 
                    operación a relizar, y dos números.
		    Regresa la operación hecha.
  1. Calculadora que utiliza atómicos, 
  realiza las operaciones elementales 
  Atomicos validos:
  :suma, :resta, :multiplicacion, :division, 
  :divint, :modulo
  """
  def calculadora_atom(atom, x, y) do    
    case atom do
      :suma  -> x + y
      :resta -> x - y
      :multiplicacion -> x*y
      :division ->
	if(y==0) do
	  raise ErrorDiv
	end
	x/y
      :divint ->
	if(y==0) do
	  raise ErrorDiv
	end
	div(x, y)
      :modulo ->
	if(y==0) do
	  raise ErrorDiv
	end
	rem(x, y)
    end
  end

  @doc """
  reversa: Recibe una lista y regresa su reversa.
  2. Reversa de una lista utilizando caza de patrones.
  """
  def reversa([]) do
    []
  end
  def reversa([x|xs]) do
    reversa(xs)++[x]
  end

  @doc """
  borra_duplicados: Recibe una lista.
  3. Elimina los duplicados de la lista recibida.
  """
  def borra_duplicados([]) do
    []
  end
  def borra_duplicados([x|xs]) do
    if(esta?(x, xs)==true) do
      borra_duplicados(borra(x, xs))
    else
      [x]++borra_duplicados(xs)
    end
  end

  @doc """
  borra: Recibe un elemento, y una lista. Elimina 
         el elemento de la lista, solo UNA vez.
  Funcion auxiliar para borra_duplicados.
  En borra_duplicados verifica que esté, 
  UNICAMENTE utilizar como función auxiliar, pues
  en caso de que el elemento no este en la lista 
  regresa error.
  """
  def borra(a ,[x|xs]) do
    if(a==x) do
      [a]++xs
    else
      [x]++borra(a, xs)
    end
  end

  @doc """
  esta?: Recibe un elemento y una lista.
         Regresa true si el elemento se encuentra en la lista,
         false si no.
  Funcion auxiliar para borra_duplicados.
  """
  def esta?(_, []) do
    false
  end
  def esta?(a, [x|xs]) do
    if(a==x) do
      true
    else
      esta?(a, xs)
    end
  end
end

#modulo que se lanza cuando se quiere dividir entre cero#
defmodule ErrorDiv do
  defexception message: "Division entre cero no definida"
end

#Pruebas calculadora_atom#
cuatro = Practica01.calculadora_atom(:modulo, Practica01.calculadora_atom(
      :suma, 2, 2), 5)
dos = Practica01.calculadora_atom(:resta, 4, 2)
quince = Practica01.calculadora_atom(:multiplicacion, 3, 5)
tresf = Practica01.calculadora_atom(:division, 21, 7)
tres = Practica01.calculadora_atom(:divint, 21, 7)

if(cuatro == 4 && dos == 2 && tresf == 3.0 &&
  tres == 3 && quince == 15) do
  IO.puts "caculadora_atom \tfunciona"
else
  IO.puts "calculadora_atom \tno funciona"
end

#Listas#
lista_unos = [1, 1, 1, 1]
lista = [3, 5, 4, 11, 24]
cumple = [3, 1, 0, 3, 0, 0]

#Pruebas reversa#
if(Practica01.reversa(lista_unos) == lista_unos
  and Practica01.reversa(lista) == [24, 11, 4, 5, 3]) do 
IO.puts "reversa \t\tfunciona"
else
  IO.puts "reversa \tno funciona "
end

#Pruebas borra_duplicados#
if(Practica01.borra_duplicados(lista_unos) == [1]
  and Practica01.borra_duplicados(lista) == lista
  and Practica01.borra_duplicados(cumple) == [1, 3, 0]) do
  IO.puts "borra_duplicados \tfunciona"
else
  IO.puts "borra_duplicados \tno funciona"
end
