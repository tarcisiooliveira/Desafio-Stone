defmodule DesafioStoneTest do
  use ExUnit.Case
  alias DesafioStone.Item, as: Item
  doctest DesafioStone

  @item_list [
    %Item{name: "Alicate", amount_item: 1, value_unit: 1},
    %Item{name: "Bola", amount_item: 1, value_unit: 501},
    %Item{name: "Dado", amount_item: 1, value_unit: 300},
    %Item{name: "Espuma de Barbear", amount_item: 2, value_unit: 100},
    %Item{name: "Farinha", amount_item: 1.5, value_unit: 3.00},
    %Item{name: "Kit 10 Sabonetes", amount_item: 1, value_unit: 200},
    %Item{name: "Hotel", amount_item: 1, value_unit: 301},
    %Item{name: "Bola", amount_item: 1, value_unit: 400}
  ]

  @email_list [
    "alfa@test.com",
    "bravo@test.com",
    "charlie@test.com",
    "delta@test.com",
    "eco@test.com"
  ]

  test "Perfect case" do
    assert DesafioStone.split_bill(@email_list, @item_list) ==
             %{
               "alfa@test.com" => 470,
               "bravo@test.com" => 470,
               "charlie@test.com" => 471,
               "delta@test.com" => 471,
               "eco@test.com" => 471
             }
  end

  test "testing empty item list" do
    assert DesafioStone.split_bill(@email_list, []) ==
             "Lista de compas vazia, informe ao menos um item"
  end

  test "testing empty email list" do
    assert DesafioStone.split_bill([], @item_list) ==
             "Lista de email vazia, informe ao menos um usuario"
  end

  test "testing bouth empty list" do
    assert DesafioStone.split_bill([], []) ==
             "Listas vazias, informe ao menos um usuario e um item"
  end

  test "two user, even value " do
    result = %{"alfa@test.com" => 301, "bravo@test.com" => 301}

    assert DesafioStone.split_bill(
             ["alfa@test.com", "bravo@test.com"],
             [
               %{name: "Alicate", amount_item: 1, value_unit: 101},
               %{name: "Bola", amount_item: 1, value_unit: 501}
             ]
           ) == result
  end

  test "two user, odd value " do
    result = %{"alfa@test.com" => 300, "bravo@test.com" => 301}

    assert DesafioStone.split_bill(
             ["alfa@test.com", "bravo@test.com"],
             [
               %{name: "Alicate", amount_item: 1, value_unit: 100},
               %{name: "Bola", amount_item: 1, value_unit: 501}
             ]
           ) == result
  end

  test "only one user, odd value" do
    result = %{"alfa@test.com" => 601}

    assert DesafioStone.split_bill(
             ["alfa@test.com"],
             [
               %{name: "Alicate", amount_item: 1, value_unit: 100},
               %{name: "Bola", amount_item: 1, value_unit: 501}
             ]
           ) ==
             result
  end

  test "only one user, even value" do
    result = %{"alfa@test.com" => 602}

    assert DesafioStone.split_bill(
             ["alfa@test.com"],
             [
               %{name: "Alicate", amount_item: 1, value_unit: 101},
               %{name: "Bola", amount_item: 1, value_unit: 501}
             ]
           ) ==
             result
  end
end
