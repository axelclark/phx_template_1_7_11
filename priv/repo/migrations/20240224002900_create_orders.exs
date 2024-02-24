defmodule PhxTemplate1711.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :total_price, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
