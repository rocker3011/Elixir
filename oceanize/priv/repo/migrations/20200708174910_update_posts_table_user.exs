defmodule Oceanize.Repo.Migrations.UpdatePostsTableUser do
  use Ecto.Migration

  def up do
    create table("user") do
      add :full_name, :string
      add :password, :string
      add :age, :string

      timestamps()
    end
  end
end
