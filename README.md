# Ep2Logica

Implementação de um reconhecedor de cadeias para gramáticas de estrutura de frase recursiva.

## Representação da gramática

Para representação da gramática utiliza-se um Map que contém a cadeia inicial da gramática e suas regras de geração:

```
%{
  "cadeia_inicial" => cadeia,
  "regras" => [[cadeia, cadeia], ...]
} 
```

Sendo que cada regra aprensenta o formato ```[cadeia, cadeia]``` de forma que os elementos da cadeia a esquerda serão substituídos pelos da direita.

## Funcionamento do algoritmo

Partindo de um conjunto contendo apenas a cadeia inicial o algoritmo atua de forma recursiva gerando, a cada iteração, todas as possíveis cadeias de tamanho menor ou igual ao tamanho da cadeia-alvo (que se deseja reconhecer) aplicando as regras de formação de cadeias da gramática.

Em cada passo compara-se o novo conjunto gerado com o anterior e, caso sejam iguais, verifica se a cadeia-alvo está presente. Caso esteja retorna true e false caso contrário.

Como *todas* as cadeias de tamanho menor ou igual ao da cadeia-alvo são geradas nesse processo, a presença ou não da cadeia-alvo no último conjunto de cadeias garante a presença ou ausência desta na gramática.

## Execução do programa

Um exemplo de execução do programa é o seguinte:

Seja a gramática:

```
%{
  "cadeia_inicial" => "S",
  "regras" => [["S", "aA"], ["A", "b"], ["A", "Sb"]]
}
```

Roda-se o programa executando ```iex -S mix``` na pasta raiz do projeto:

```
  > iex -S mix
  iex(1)> gramatica = %{ "cadeia_inicial" => "S", "regras" => [["S", "aA"], ["A", "b"], ["A", "Sb"]]  }
  %{"cadeia_inicial" => "S", "regras" => [["S", "aA"], ["A", "b"], ["A", "Sb"]]}

```

Que gera cadeias do tipo a^n.b^n, testa-se a cadeia `aabb` retornando true:

```
  iex(2)> Ep2Logica.reconhecer_cadeia("aabb", gramatica)
  true
``` 

E testa-se a cadeia `abbb` retornando false:

```
  iex(3)> Ep2Logica.reconhecer_cadeia("abbb", gramatica)
  false
```
