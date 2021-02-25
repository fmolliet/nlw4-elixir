defmodule Rocketpay.User do
  use Ecto.Schema # indica que é um schema

  import Ecto.Changeset #tras funcionalidades do Ecto para o modulo
  alias Ecto.Changeset
  alias Rocketpay.Account
  # Variaveis de modulo
  @primary_key {:id, :binary_id, autogenerate: true} # Variavel de modulo, como uma constante
  # Qual o formato da chave primaria, binary_id é um UUID
  @required_params [:name, :age, :email, :password, :nickname]

  # Igual o da migration, basta trocar add por field
  schema "users" do
    field :name,          :string
    field :age,           :integer
    field :email,         :string
    field :password,      :string, virtual: true # Campo virtual significa que ele vai receber mas quando gravar ele nao existe
    field :password_hash, :string
    field :nickname,      :string

    has_one  :account,     Account

    timestamps()
  end

  # Changeset Validação e casting do schema
  # Ele retorna se é valido, erros, etc
  # Chamamos com o @ a variavel de modulo
  def changeset(params) do
    %__MODULE__{}
    |>cast(params, @required_params) # Faz cast das variaveis no formato do schema
    |>validate_required(@required_params) # Valida os parametros com os schema definido
    |>validate_length(:password, min: 6) # Valida o comprimento da string
    |>validate_number(:age, greater_than_or_equal_to: 18) # Nao aceita datas menors que 18
    |>validate_format(:email, ~r/@/) # valida email com regex
    |>unique_constraint([:email])  # Valida se nao existe no banco
    |>unique_constraint([:nickname]) # Valida se nao existe no banco
    |>put_password_hash()
  end

  # precisa fazer o alias do Changeset
  defp put_password_hash(%Changeset{valid?: true, changes: %{ password: password }} = changeset) do # Atribui a uma variavel changeset
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
