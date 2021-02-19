defmodule DesafioStone do
  @moduledoc """
  Documentation for `DesafioStone`.
  """

  @doc """
  split_bill will verify the entrance by pattern matching  to decide who should be called.

  ## Examples

      iex> DesafioStone.split_bill([], [])
      "Listas vazias, informe ao menos um usuario e um item"

      iex> DesafioStone.split_bill([],[%{name: "Alicate", amount_item: 1, value_unit: 1},%{name: "Bola", amount_item: 1, value_unit: 501}])
      "Lista de email vazia, informe ao menos um usuario"

      iex> DesafioStone.split_bill(["alfa@test.com","bravo@test.com"], [])
      "Lista de compas vazia, informe ao menos um item"

      iex> DesafioStone.split_bill(["alfa@test.com","bravo@test.com"],      [%{name: "Alicate", amount_item: 1, value_unit: 1},%{name: "Bola", amount_item: 1, value_unit: 501}] )
      %{"alfa@test.com" => 251, "bravo@test.com" => 251}

      iex> DesafioStone.split_bill(["bravo@test.com"],[%{name: "Alicate", amount_item: 1, value_unit: 1},%{name: "Bola", amount_item: 1, value_unit: 501}] )
      %{"bravo@test.com" => 502}

  """
  def split_bill([], []), do: "Listas vazias, informe ao menos um usuario e um item"
  def split_bill([], _list), do: "Lista de email vazia, informe ao menos um usuario"
  def split_bill(_list, []), do: "Lista de compas vazia, informe ao menos um item"

  def split_bill(email_list, item_list) do
    amount_all(item_list)
    |> share_bill(email_list)
    |> create_list(email_list)
  end

  defp amount_all(list),
    do:
      Enum.reduce(list, 0, fn x, acc ->
        acc + parse_to_integer(x.amount_item * (x.value_unit * 100))
      end)

  defp parse_to_integer(float_number) when is_float(float_number) do
    float_number
    |> Float.to_string()
    |> String.slice(0..-3)
    |> String.to_integer()
  end

  defp parse_to_integer(integer_number), do: integer_number / 100

  defp share_bill(amount, email_list) do
    int = parse_to_integer(amount)
    email_size = length(email_list)
    integer = div(int, email_size)
    rest = Integer.mod(int, email_size)
    %{integer: integer, rest: rest}
  end

  defp create_list(%{integer: integer, rest: rest}, email_list) do
    Enum.map(email_list, fn x -> {x, integer} end)
    |> Map.new()
    |> new_function(rest, email_list)
  end

  defp new_function(map, 0, _email_list), do: map

  defp new_function(map, rest, email_list) do
    Map.get_and_update(
      map,
      Enum.at(email_list, -rest),
      fn current_value ->
        {current_value, Map.get(map, Enum.at(email_list, -rest)) + 1}
      end
    )
    |> elem(1)
    |> new_function(rest - 1, email_list)
  end
end
