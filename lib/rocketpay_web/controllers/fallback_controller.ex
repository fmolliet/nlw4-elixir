defmodule RocketpayWeb.FallbackController do # Modulo que agrupa funções
  use RocketpayWeb, :controller # Modulo especial que é um controller

  def call(conn, {:error, result}) do
    # Para printar no console
    #IO.puts("Foi eu quem fui chamado")
    conn
    |> put_status(:bad_request)
    |> put_view(RocketpayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
