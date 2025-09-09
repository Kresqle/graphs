Examples of De Bruijn graphs generated using `de_bruijn_graph_gen.ml`.

All of the graphs generated are visualized using `graph2svg.ml`.

## De Bruijn graphs

In graph theory, an hBdimensional De Bruijn graph of $ symbols (that is,
on an alphabet of $ symbols) is a directed graph representing overlaps between
sequences of symbols of length $ (the same symbol may appear multiple times in
a sequence).

## Stats

$\forall (k, n) \in (\mathbb{N}^*)^2, B(k, n) = (V, E)$ such that $|V| = k^n$ and $|E| = k^{n + 1} = k|V|$

| Graph | Nodes | Edges | Time to generate | Time to render |
| ----- | ----- | ----- | ---------------- | -------------- |
| [B(1, 1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b1-1) | 1 | 1 | 0,055s | 0,054s |
| [B(1, 2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b1-2) | 1 | 1 | 0,053s | 0,055s |
| [B(1, 3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b1-3) | 1 | 1 | 0,053s | 0,056s |
| [B(2, 1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b2-1) | 2 | 4 | 0,055s | 0,056s |
| [B(2, 2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b2-2) | 4 | 8 | 0,060s | 0,058s |
| [B(2, 3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b2-3) | 8 | 16 | 0,054s | 0,059s |
| [B(3, 1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b3-1) | 3 | 9 | 0,057s | 0,057s |
| [B(3, 2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b3-2) | 9 | 27 | 0,055s | 0,058s |
| [B(3, 3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b3-3) | 27 | 81 | 0,059s | 0,070s |
| [B(4, 1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b4-1) | 4 | 16 | 0,056s | 0,057s |
| [B(4, 2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b4-2) | 16 | 64 | 0,049s | 0,057s |
| [B(4, 3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b4-3) | 64 | 256 | 0,053s | 0,122s |

## B(1, 1)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 0 1 ./examples/de_bruijn_graph_gen/b_1_1.json
Graph B(1,1) written to ./examples/de_bruijn_graph_gen/b_1_1.json
```

Output : [JSON for B(1,1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_1_1.json)

Result :

![de_bruijn_graph_gen example 1](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_1_1.svg)

## B(1, 2)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 0 2 ./examples/de_bruijn_graph_gen/b_1_2.json
Graph B(1,2) written to ./examples/de_bruijn_graph_gen/b_1_2.json
```

Output : [JSON for B(1,2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_1_2.json)

Result :

![de_bruijn_graph_gen example 2](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_1_2.svg)

## B(1, 3)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 0 3 ./examples/de_bruijn_graph_gen/b_1_3.json
Graph B(1,3) written to ./examples/de_bruijn_graph_gen/b_1_3.json
```

Output : [JSON for B(1,3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_1_3.json)

Result :

![de_bruijn_graph_gen example 3](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_1_3.svg)

## B(2, 1)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 01 1 ./examples/de_bruijn_graph_gen/b_2_1.json
Graph B(2,1) written to ./examples/de_bruijn_graph_gen/b_2_1.json
```

Output : [JSON for B(2,1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_1.json)

Result :

![de_bruijn_graph_gen example 4](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_1.svg)

## B(2, 2)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 01 2 ./examples/de_bruijn_graph_gen/b_2_2.json
Graph B(2,2) written to ./examples/de_bruijn_graph_gen/b_2_2.json
```

Output : [JSON for B(2,2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_2.json)

Result :

![de_bruijn_graph_gen example 5](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_2.svg)

## B(2, 3)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 01 3 ./examples/de_bruijn_graph_gen/b_2_3.json
Graph B(2,3) written to ./examples/de_bruijn_graph_gen/b_2_3.json
```

Output : [JSON for B(2,3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_3.json)

Result :

![de_bruijn_graph_gen example 6](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_2_3.svg)

## B(3, 1)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 012 1 ./examples/de_bruijn_graph_gen/b_3_1.json
Graph B(3,1) written to ./examples/de_bruijn_graph_gen/b_3_1.json
```

Output : [JSON for B(3,1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_3_1.json)

Result :

![de_bruijn_graph_gen example 7](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_3_1.svg)

## B(3, 2)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 012 2 ./examples/de_bruijn_graph_gen/b_3_2.json
Graph B(3,2) written to ./examples/de_bruijn_graph_gen/b_3_2.json
```

Output : [JSON for B(3,2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_3_2.json)

Result :

![de_bruijn_graph_gen example 8](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_3_2.svg)

## B(3, 3)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 012 3 ./examples/de_bruijn_graph_gen/b_3_3.json
Graph B(3,3) written to ./examples/de_bruijn_graph_gen/b_3_3.json
```

Output : [JSON for B(3,3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_3_3.json)

Result :

![de_bruijn_graph_gen example 9](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_3_3.svg)

## B(4, 1)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 0123 1 ./examples/de_bruijn_graph_gen/b_4_1.json
Graph B(4,1) written to ./examples/de_bruijn_graph_gen/b_4_1.json
```

Output : [JSON for B(4,1)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_1.json)

Result :

![de_bruijn_graph_gen example 10](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_1.svg)

## B(4, 2)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 0123 2 ./examples/de_bruijn_graph_gen/b_4_2.json
Graph B(4,2) written to ./examples/de_bruijn_graph_gen/b_4_2.json
```

Output : [JSON for B(4,2)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_2.json)

Result :

![de_bruijn_graph_gen example 11](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_2.svg)

## B(4, 3)

Input :

```bash
$ dune exec ./_build/default/src/de_bruijn_graph_gen.exe 0123 3 ./examples/de_bruijn_graph_gen/b_4_3.json
Graph B(4,3) written to ./examples/de_bruijn_graph_gen/b_4_3.json
```

Output : [JSON for B(4,3)](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_3.json)

Result :

![de_bruijn_graph_gen example 12](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_4_3.svg)

