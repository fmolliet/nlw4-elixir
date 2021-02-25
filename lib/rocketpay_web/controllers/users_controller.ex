defmodule RocketpayWeb.UsersController do # Modulo que agrupa funções
  use RocketpayWeb, :controller # Modulo especial que é um controller

  alias Rocketpay.User
  # Indica qual o fallback controller desse controller
  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    # With é um pattern match que caso de sucesso ele executa
    # Caso de erro, ele devolve o erro para quem chamou, que no caso é o phoenix
    # Então quem vai tratar o erro é o Fallback controller
    # o WITH permite adicionar varios casos separadas por virgula
    # {:ok, %User{} = user } <- Rocketpay.create_user(params), {:ok, %User{} = user } <- Rocketpay.create_user(params), ...
    # mas se der erro em todas etapas ele retorna o erro
    # With é comum nos controllers
    with {:ok, %User{} = user } <- Rocketpay.create_user(params) do
      conn
      |>put_status(:created)
      |>render("create.json", user: user )
    end
    #params
    #|> Rocketpay.create_user()
    #|> handle_response(conn)
  end

  #defp handle_response({:ok, %User{} = user }, conn) do
  #  conn
  #    |>put_status(:created)
  #    |>render("create.json", user: user )
  #end

  #defp handle_response({:error, _result} = error , _conn), do: error
end
