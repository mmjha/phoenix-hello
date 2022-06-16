defmodule Hello.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :bio, :string
    field :email, :string
    field :name, :string
    field :number_of_pets, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :bio, :number_of_pets])
    |> validate_required([:name, :email, :bio])
    |> validate_length(:bio, min: 2)
    |> validate_length(:bio, max: 140)
    |> validate_format(:email, ~r/@/)
  end
end

# changeset = User.changeset(%User{}, %{email: "@example.com"})
# changeset.valid?
# changeset.errors[:email]
# Repo.insert(%User{email: "user1@example.com"})
# Repo.insert(%User{email: "user2@example.com"})
# Repo.all(User)
# import Ecto.Query
# Repo.all(from u in User, select: u.email)
# Repo.all(from u in User, select: [u.email, u.name])
# Repo.one(from u in User, where: ilike(u.email, "%1%"), select: count(u.id))
# Repo.all(from u in User, select: %{u.id => u.email})
