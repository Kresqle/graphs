type node = {
  id : string;
  label : string;
}

type edge = {
  source : string;
  target : string;
  label : string;
}

let rec read_nodes acc =
  print_string "Enter node id (empty to stop): ";
  let id = read_line () in
  if id = "" then List.rev acc
  else (
    print_string ("Enter label for node " ^ id ^ ": ");
    let label = read_line () in
    read_nodes ({id; label} :: acc)
  )

let rec read_edges acc =
  print_string "Enter edge source id (empty to stop): ";
  let src = read_line () in
  if src = "" then List.rev acc
  else (
    print_string "Enter edge target id: ";
    let dst = read_line () in
    print_string "Enter label for this edge: ";
    let label = read_line () in
    read_edges ({source=src; target=dst; label} :: acc)
  )

let node_to_json n =
  `Assoc [("id", `String n.id); ("label", `String n.label)]

let edge_to_json e =
  `Assoc [
    ("from", `String e.source);
    ("to", `String e.target);
    ("label", `String e.label)
  ]

(* MAIN *)

let () =
  print_endline "=== Graph Maker ===";
  let nodes = read_nodes [] in
  let edges = read_edges [] in
  let json =
    `Assoc [
      ("directed", `Bool true); (* you can change this later *)
      ("nodes", `List (List.map node_to_json nodes));
      ("edges", `List (List.map edge_to_json edges))
    ]
  in
  let oc = open_out "graph.json" in
  Yojson.Basic.pretty_to_channel oc json;
  close_out oc;
  print_endline "Graph written to graph.json"
