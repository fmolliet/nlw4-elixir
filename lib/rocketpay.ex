defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate

  alias Rocketpay.Accounts.Deposit
  # Padrão Facade
  # damos uma faxada para chamarmos o metodo sem utilizar todo o caminho (como um alias global)
  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
end
