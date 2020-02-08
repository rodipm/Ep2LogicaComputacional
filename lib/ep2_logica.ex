defmodule Ep2Logica do

  def reconhecer_cadeia(cadeia, gramatica)
  def reconhecer_cadeia(cadeia, %{"cadeia_inicial" => cadeia_inicial, "regras" => regras}) do
    gerar_cadeias(cadeia, String.length(cadeia), regras, [cadeia_inicial], [cadeia_inicial])
  end

  def gerar_cadeias(cadeia_alvo, tamanho_maximo, regras, conjunto_atual, conjuntos) do
    novo_conjunto = percorrer_conjunto(conjunto_atual, regras)
    tamanho_atual = obter_tamanho_maior_cadeia(conjunto_atual)

    # Debug
    IO.inspect(conjuntos, label: "conjuntos")
    IO.inspect(conjunto_atual, label: "conjunto_atual")
    IO.inspect(novo_conjunto, label: "novo_conjunto")
    IO.inspect(tamanho_atual, label: "tamanho_atual")
  
    # Verificações de parada
    cond do
      conjunto_atual ++ novo_conjunto == conjunto_atual or tamanho_atual == tamanho_maximo ->
        IO.inspect conjuntos ++ [novo_conjunto]
        if Enum.member?(conjunto_atual ++ novo_conjunto, cadeia_alvo), do: true, else: false
      true ->
        gerar_cadeias(cadeia_alvo, tamanho_maximo, regras, novo_conjunto, conjuntos ++ [novo_conjunto])
      end
  end

  defp obter_tamanho_maior_cadeia([]) do
    0
  end

  defp obter_tamanho_maior_cadeia(cadeias) do
    cadeias
    |> Enum.map(fn(x) -> String.length(x) end)
    |> Enum.max
    |> IO.inspect
  end

  defp percorrer_conjunto(conjunto, regras) do
    novo_conjunto = for cadeia <- conjunto do
      aplicar_regras_a_cadeia(cadeia, regras)
    end
    
    reduzir_cadeias(novo_conjunto)
  end

  defp reduzir_cadeias([]) do
    []
  end

  defp reduzir_cadeias(novo_conjunto) do
    novo_conjunto
    |> Enum.reduce(fn(x, acc) -> x ++ acc end)
    |> Enum.filter(fn x -> x != nil end)
  end

  # defp aplicar_regras_a_cadeia(cadeia, regras) do
  #   for regra <- regras do
  #     regra.(cadeia)
  #   end
  # end

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

# Regras da Gramatica:
gramatica = %{
  "cadeia_inicial" => "S",
  "regras" => [["S", "aA"], ["A", "b"], ["A", "Sb"]]
}

IO.inspect(Ep2Logica.reconhecer_cadeia("aaaaaabbbbbb", gramatica))