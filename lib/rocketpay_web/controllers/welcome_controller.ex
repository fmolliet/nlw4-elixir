defmodule RocketpayWeb.WelcomeController do # Modulo que agrupa funções
  use RocketpayWeb, :controller # Modulo especial que é um controller

  alias Rocketpay.Numbers

  # Usando pattern matching vamos pegar o parametro da URL o %{} indica que é um mapping que posibilita realizar o pattern matching sem ordem
  def index(conn, %{"filename" => filename}) do # quando tem _ antes da variavel ele está falando para ignorar os parametros
    filename
    |> Numbers.sum_from_file_pipe()
    |> handle_response(conn)
    # text(conn, "Welcome to the rocketpay API") # ele sempre deve retornar a conexao, metodo que retorna um texto de boas vindas
  end

  defp handle_response({:ok, %{result: result} }, conn) do
    conn
    |>IO.inspect() # inspect da conexao
    |>put_status(:ok)
    |>json(%{message: "Welcome to the Rocketpay API. Here is your number #{result}"})
  end

  defp handle_response({:error, reason}, conn) do
    conn
    |>put_status(:bad_request)
    |>json(reason)
  end
end
