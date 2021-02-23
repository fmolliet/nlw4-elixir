defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate
  # Padrão Facade
  # damos uma faxada para chamarmos o metodo sem utilizar todo o caminho (como um alias global)
  defdelegate create_user(params), to: UserCreate, as: :call
end
