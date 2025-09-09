Examples of graphs generated using `graph_maker.ml`.

All of the graphs generated are visualized using `graph2svg.ml`.

## 1

Input :

```bash
kamal@lnx:graphs$ dune exec ./_build/default/src/graph_maker.exe
=== Graph Maker ===                
Enter node id (empty to stop): a
Enter label for node a: A
Enter node id (empty to stop): b
Enter label for node b: B
Enter node id (empty to stop): c
Enter label for node c: C
Enter node id (empty to stop): d
Enter label for node d: D
Enter node id (empty to stop): 
Enter edge source id (empty to stop): a
Enter edge target id: b
Enter label for this edge: A->B
Enter edge source id (empty to stop): c
Enter edge target id: d
Enter label for this edge: C->D
Enter edge source id (empty to stop): d
Enter edge target id: a
Enter label for this edge: D->A
Enter edge source id (empty to stop): a
Enter edge target id: c
Enter label for this edge: A->C
Enter edge source id (empty to stop): b
Enter edge target id: d
Enter label for this edge: B to D   
Enter edge source id (empty to stop): 
Graph written to graph.json
```

Output :

`1.json`

```json
{
  "directed": true,
  "nodes": [
    { "id": "a", "label": "A" },
    { "id": "b", "label": "B" },
    { "id": "c", "label": "C" },
    { "id": "d", "label": "D" }
  ],
  "edges": [
    { "from": "a", "to": "b", "label": "A->B" },
    { "from": "c", "to": "d", "label": "C->D" },
    { "from": "d", "to": "a", "label": "D->A" },
    { "from": "a", "to": "c", "label": "A->C" },
    { "from": "b", "to": "d", "label": "B to D" }
  ]
}
```

Result :

![graph_maker example 1](https://github.com/Kresqle/graphs/blob/main/examples/graph_maker/1.svg?raw=true)