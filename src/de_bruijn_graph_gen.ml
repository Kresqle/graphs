[@@@ocaml.warning "-32"]

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

(* De Bruijn sequence generator *)
let de_bruijn_seq_alphabet alph n =
  let k = Array.length alph in
  let a = Array.make (k * n) 0 in
  let seq = Buffer.create 128 in

  let rec db t p =
    if t = n + 1 then (
      if n mod p = 0 then
        for j = 1 to p do
          Buffer.add_string seq alph.(a.(j))
        done
    ) else (
      a.(t) <- a.(t - p);
      db (t + 1) p;
      for j = a.(t - p) + 1 to k - 1 do
        a.(t) <- j;
        db (t + 1) t
      done
    )
  in
  db 1 1;
  Buffer.contents seq

  
(* let de_bruijn_seq k = de_bruijn_seq_alphabet (Array.init k string_of_int) *)

(* let binary_de_bruijn_seq = de_bruijn_seq 2 *)

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