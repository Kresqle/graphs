open Printf
open Yojson.Basic

type node = {
  id : string;
  label : string;
}

type edge = {
  source : string;
  target : string;
  label : string;
}

(* Build De Bruijn graph as JSON *)
let rec all_words alph n =
  if n = 0 then [""]
  else
    let shorter = all_words alph (n - 1) in
    List.concat (List.map (fun w -> List.map (fun a -> w ^ a) alph) shorter)

(* B(k,n) *)
let de_bruijn_graph alph n =
  let nodes = List.map (fun w -> {id = w; label = w}) (all_words alph n) in
  let edges =
    List.concat (
      List.map (fun w ->
        List.map (fun a ->
          let src = w in
          let tgt = (String.sub w 1 (n - 1)) ^ a in
          { source = src; target = tgt; label = w ^ a }
        ) alph
      ) (all_words alph n)
    )
  in
  (nodes, edges)

(* JSON conversion *)
let graph_to_yojson directed nodes edges =
  `Assoc [
    ("directed", `Bool directed);
    ("nodes", `List (List.map (fun n ->
      `Assoc [("id", `String n.id); ("label", `String n.label)]
    ) nodes));
    ("edges", `List (List.map (fun e ->
      `Assoc [
        ("from", `String e.source);
        ("to", `String e.target);
        ("label", `String e.label)
      ]
    ) edges))
  ]

(* MAIN *)
let () =
  if Array.length Sys.argv < 4 then (
    prerr_endline "Usage: de_bruijn_graph_gen <alphabet> <n> <output.json>";
    prerr_endline "Example: de_bruijn_graph_gen 01 3 graph.json";
    exit 1
  );

  let alph_str = Sys.argv.(1) in
  let n = int_of_string Sys.argv.(2) in
  let output_file = Sys.argv.(3) in

  let alph = List.init (String.length alph_str) (fun i -> String.make 1 alph_str.[i]) in
  let (nodes, edges) = de_bruijn_graph alph n in
  let json = graph_to_yojson true nodes edges in

  let oc = open_out output_file in
  pretty_to_channel oc json;
  close_out oc;

  printf "Graph B(%d,%d) written to %s\n"
    (List.length alph) n output_file