defmodule Rocketpay.Numbers do

  def sum_from_file_pipe(filename) do #Pipe operator repassa os valores de uma funçao para outra
    "#{filename}.csv" # Ele pega esse string concatenada e passa como parametro para segunda função
    |> File.read() # caso tenha mais que um parametro vc pode passar, basta inserir os adicionais
    |> handle_file() # Nao precisa ficar re atribuindo os valores e código fica mais facil de ler
  end

  def sum_from_file(filename) do
    file = File.read("#{filename}.csv") # exemplo de como faz interpolação (concatenação)
    # {:ok, file} = File.read("#{filename}.csv") #pattern match ( é como uma de estruturação com padrão) é a mesma coisa que [a,b,c,d] = [1,2,3,4]
    handle_file(file)
  end

  # Função privada que recebe um pattern match e caso receba erro ela retornara erro
  # ela só será executada quando receber o pattern
  # Pipe function
  defp handle_file({:ok, result}) do
    result = # armazenamos o resultado para retornar como código de chave e valor
      result
      |> String.split(",")
      #|> Enum.map(fn number -> String.to_integer(number) end) # execução com Enum
      |> Stream.map(fn number -> String.to_integer(number) end) # Execução Stream, ele é um lazy operator, então só quando precisar dos valores ele executa
      # Ele agrupa de maneira inteligente cara converter para inteiro e somar de uma vez só
      |> Enum.sum()

    {:ok, %{result: result}} # Retorna um map com o resultado
  end
  # Função privada de uma linha
  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid File"}} # variavel com _ indicando que iremos ignorar a variavel
end
