defmodule Rocketpay.Users.Create do
  alias Rocketpay.{ Repo, User} # Faz o alias de multiplos modulos

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
