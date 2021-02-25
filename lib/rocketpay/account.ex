defmodule Rocketpay.Account do
  use Ecto.Schema # indica que é um schema

  import Ecto.Changeset #tras funcionalidades do Ecto para o modulo

  alias Rocketpay.User
  # Variaveis de modulo
  @primary_key {:id, :binary_id, autogenerate: true} # Variavel de modulo, como uma constante
  @foreign_key_type :binary_id
  # Qual o formato da chave primaria, binary_id é um UUID
  @required_params [:balance, :user_id]

  # Igual o da migration, basta trocar add por field
  schema "accounts" do
    field       :balance,  :decimal
    belongs_to  :user,     User

    timestamps()
  end

  # Changeset Validação e casting do schema
  # Ele retorna se é valido, erros, etc
  # Chamamos com o @ a variavel de modulo
  def changeset(struct \\ %__MODULE__{}, params) do # \\ é quando argumento default
    struct
    |>cast(params, @required_params) # Faz cast das variaveis no formato do schema
    |>validate_required(@required_params) # Valida os parametros com os schema definido
    |>check_constraint(:balance, name: :balance_must_be_positive_or_zero ) # Validação da constraint
  end

end
