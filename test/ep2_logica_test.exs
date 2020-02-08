defmodule Ep2LogicaTest do
  use ExUnit.Case
  doctest Ep2Logica

  @gramatica1 %{
    "cadeia_inicial" => "S",
    "regras" => [["S", "aA"], ["A", "b"], ["A", "Sb"]]
  }

  @gramatica2 %{
    "cadeia_inicial" => "Z",
    "regras" => [
      ["Z", "aBC"],
      ["Z", "aSBC"],
      ["S", "aBC"],
      ["S", "aSBC"],
      ["aB", "ab"],
      ["bB", "bb"],
      ["bC", "bc"],
      ["cC", "cc"],
      ["CB", "BC"]
    ]
  }

  @gramatica3 %{
    "cadeia_inicial" => "S",
    "regras" => [
      ["S", "aBC"],
      ["S", "aSBC"],
      ["aB", "ab"],
      ["bB", "bb"],
      ["bC", "bc"],
      ["cC", "cc"],
      ["CB", "BC"]
    ]
  }

  @tests [
    [
      @gramatica1,
      "aabb",
      true
    ],
    [
      @gramatica1,
      "aaab",
      false
    ],
    [
      @gramatica2,
      "abc",
      true
    ],
    [
      @gramatica2,
      "aabc",
      false
    ],
    [
      @gramatica3,
      "aaabbbccc",
      true
    ]
  ]

  test "teste de cadeias" do
    Enum.each(@tests, fn [gramatica, cadeia, result] ->
      IO.puts("Buscando a cadeia: #{cadeia} na gramatica:")
      IO.inspect(gramatica)
      IO.inspect(Ep2Logica.reconhecer_cadeia(cadeia, gramatica))
      assert Ep2Logica.reconhecer_cadeia(cadeia, gramatica) == result
    end)
  end
end
