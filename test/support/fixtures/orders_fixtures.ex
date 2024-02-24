defmodule PhxTemplate1711.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxTemplate1711.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        total_price: "120.5"
      })
      |> PhxTemplate1711.Orders.create_order()

    order
  end
end
