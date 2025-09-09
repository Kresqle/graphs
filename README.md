## Setup

Prerequisites : OCaml and Dune

`dune build`

## graph2svg

Usage: `dune exec ./_build/default/src/graph2svg.exe <input.json> <output.svg> [width] [height] [iterations]`

Example : `dune exec ./_build/default/src/graph2svg.exe graph.json out.svg 1200 800 500`

> Can produce overlapping edges

## graph_maker

Usage: `dune exec ./_build/default/src/graph_maker.exe`

Then follow the instructions

## de_bruijn_graph_gen

Usage: `de_bruijn_graph_gen <alphabet> <n> <output.json>`

Example: `de_bruijn_graph_gen 01 3 de_bruijn.json`