defmodule Ep2Logica do
  @type cadeia :: String.t()
  @type regra :: [cadeia, ...]
  @type gramatica :: %{:cadeia_inicial => cadeia, :regras => [regra, ...]}

  @doc """
  Recebe uma `cadeia` e verifica se pertence à `gramática`.
  """
  @spec reconhecer_cadeia(cadeia, map) :: true | false

  def reconhecer_cadeia(cadeia, %{"cadeia_inicial" => cadeia_inicial, "regras" => regras}) do
    gerar_cadeias(cadeia, String.length(cadeia), regras, [cadeia_inicial], [cadeia_inicial])
  end

  # Gera todas as cadeias a partir das regras da cadeia limitando-se a cadeias com tamanho <= ao tamanho da cadeia alvo (tamanho_maximo)
  defp gerar_cadeias(cadeia_alvo, tamanho_maximo, regras, conjunto_atual, conjuntos) do
    novo_conjunto = gerar_novo_conjunto(conjunto_atual, regras, tamanho_maximo)

    # Debug
    # IO.inspect conjunto_atual, label: "conjunto_atual"
    # IO.inspect novo_conjunto, label: "novo_conjunto"
    # IO.inspect tamanho_atual, label: "tamanho_atual"

    # Verificações de parada
    cond do
      conjunto_atual ++ novo_conjunto == conjunto_atual ->
        if Enum.member?(conjunto_atual ++ novo_conjunto, cadeia_alvo), do: true, else: false

      true ->
        gerar_cadeias(
          cadeia_alvo,
          tamanho_maximo,
          regras,
          novo_conjunto,
          conjuntos ++ [novo_conjunto]
        )
    end
  end

  # Gera uma lista de cadeias a partir de uma lista de listas de cadeias
  defp reduzir_cadeias(novo_conjunto, tamanho_maximo) do
    novo_conjunto
    |> Enum.reduce(fn x, acc -> x ++ acc end)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.filter(fn x -> String.length(x) <= tamanho_maximo end)
  end

  # Gera um novo conjunto a partir de um conjunto de cadeias aplicando-se as regras, limitado ao tamanho
  defp gerar_novo_conjunto(conjunto, regras, tamanho_maximo) do
    novo_conjunto =
      for cadeia <- conjunto do
        aplicar_regras_a_cadeia(cadeia, regras)
      end

    reduzir_cadeias(novo_conjunto, tamanho_maximo)
  end

  # Aplica todas as regras a uma determinada cadeia
  defp aplicar_regras_a_cadeia(cadeia, regras) do
    for [x, y] <- regras do
      if String.contains?(cadeia, x) do
        Regex.replace(~r/#{x}/, cadeia, y)
      else
        nil
      end
    end
  end
end
