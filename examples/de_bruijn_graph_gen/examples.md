Examples of De Bruijn graphs generated using `de_bruijn_graph_gen.ml`.

All of the graphs generated are visualized using `graph2svg.ml`.

## De Bruijn graphs

In graph theory, an $n$-dimensional De Bruijn graph of $k$ symbols (that is,
on an alphabet of $k$ symbols) is a directed graph representing overlaps between
sequences of symbols of length $n$ (the same symbol may appear multiple times in 
a sequence).

From now on, let $B(k, n)$ be the $n$-dimensional De Bruijn of $k$ symbols.

## Stats

$\forall (k, n) \in (\mathbb{N}^*)^2, B(k, n) = (V, E)$ such that $|V| = k^n$ and $|E| = k^{n + 1} = k|V|$

| Graph | Nodes | Edges |
| ----- | ----- | ----- |
| [B(2, 3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/examples.md#b2-3) | 8 | 16 |
| [B(4, 3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/examples.md#b4-3) | 64 | 256 |

## B(2, 3)

Input :

```bash
kamal@lnx:graphs$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 01 3 b_2_3.json
Graph B(2,3) written to b_2_3.json
```

Output : [JSON for B(2,3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_3.json)

Result :

![de_bruijn_graph_gen example 1](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_3.svg?raw=true)

## B(4, 3)

Input :

```bash
kamal@lnx:graphs$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 0123 3 b_4_3.json
Graph B(4,3) written to b43.json
```

Output : [JSON for B(4,3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_3.json)

Result :

![de_bruijn_graph_gen example 1](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_3.svg?raw=true)