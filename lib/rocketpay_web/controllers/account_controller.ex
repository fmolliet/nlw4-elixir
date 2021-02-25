defmodule RocketpayWeb.AccountController do # Modulo que agrupa funções
  use RocketpayWeb, :controller # Modulo especial que é um controller

  alias Rocketpay.Account
  # Indica qual o fallback controller desse controller
  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do

    with {:ok, %Account{} = account } <- Rocketpay.deposit(params) do
      conn
      |>put_status(:ok)
      |>render("update.json", account: account )
    end
    #params
    #|> Rocketpay.create_user()
    #|> handle_response(conn)
  end

end
