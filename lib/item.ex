defmodule DesafioStone.Item do
  @keys [:name, :amount_item, :value_unit]
  @moduledoc """
  An item struct, used to employ a buy list.
  """
  @enforce_keys @keys
  defstruct name: String, amount_item: Float, value_unit: Float
end
