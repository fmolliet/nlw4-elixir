defmodule Rocketpay.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table :accounts do
      add :balance,       :decimal # decimal é expecifico para valores monetarios
      add :user_id,       references(:users, type: :binary_id)

      timestamps()
    end
    # constraint tras lógica para tabela, extender funcionalidades dos dados
    # recebe 3 parametros: Nome da tabela, nome da constrait e o check
    create constraint(:accounts, :balance_must_be_positive_or_zero, check: "balance >= 0")
  end
end
