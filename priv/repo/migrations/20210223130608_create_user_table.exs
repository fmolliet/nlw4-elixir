defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table :users do
      add :name,          :string
      add :age,           :integer
      add :email,         :string
      add :password_hash, :string
      add :nickname,      :string

      timestamps() # adiciona automaticamente na table 2 colunas inserted at e update at
    end

    # Para criar unique index utilizamos o metodo unique_index()
    # passamos como primeiro parametro o nome da tabela e segundo uma lista com a coluna
    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end
