defmodule Oceanize.User do
  @moduledoc """
    User Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :full_name, :string
    field :password, :string
    field :age, :string

    timestamps()
  end

  def changeset(user, _attrs \\ %{}) do
    user
  end
end
