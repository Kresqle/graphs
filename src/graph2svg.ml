open Yojson.Basic.Util

(* ---------- types ---------- *)

type node = {
  id : string;
  label : string;
}

type edge = {
  src : string;
  dst : string;
  label : string;
}

type graph = {
  directed : bool;
  nodes : node list;
  edges : edge list;
}

(* ---------- JSON parsing ---------- *)

let parse_graph json =
  let directed =
    match json |> member "directed" with
    | `Bool b -> b
    | _ -> false
  in
  let nodes =
    json |> member "nodes" |> to_list |> List.map (fun n ->
      let id = n |> member "id" |> to_string in
      let label =
        match n |> member "label" with
        | `String s -> s
        | _ -> id
      in
      { id; label }
    )
  in
  let edges =
    json |> member "edges" |> to_list |> List.map (fun e ->
      let src = e |> member "from" |> to_string in
      let dst = e |> member "to" |> to_string in
      let label =
        match e |> member "label" with
        | `String s -> s
        | _ -> ""
      in
      { src; dst; label }
    )
  in
  { directed; nodes; edges }

let load_graph filename =
  let j = Yojson.Basic.from_file filename in
  parse_graph j

(* ---------- helpers ---------- *)

let escape_xml s =
  let buf = Buffer.create (String.length s) in
  String.iter (function
    | '&' -> Buffer.add_string buf "&amp;"
    | '<' -> Buffer.add_string buf "&lt;"
    | '>' -> Buffer.add_string buf "&gt;"
    | '"' -> Buffer.add_string buf "&quot;"
    | '\'' -> Buffer.add_string buf "&apos;"
    | c -> Buffer.add_char buf c
  ) s;
  Buffer.contents buf

(* ---------- force-directed layout (Fruchterman–Reingold) ---------- *)

let fr_layout ~width ~height ~iterations graph =
  let n = List.length graph.nodes in
  if n = 0 then ([||], [||], [||]) else
  let ids = Array.of_list (List.map (fun v -> v.id) graph.nodes) in
  let labels = Array.of_list (List.map (fun (v : node) -> v.label) graph.nodes) in
  let index_of = Hashtbl.create n in
  Array.iteri (fun i id -> Hashtbl.add index_of id i) ids;
  let edges_idx =
    graph.edges
    |> List.fold_left (fun acc e ->
        try
          let s = Hashtbl.find index_of e.src in
          let t = Hashtbl.find index_of e.dst in
          (s,t,e.label)::acc
        with Not_found -> acc
      ) []
    |> List.rev
  in
  let rand = Random.State.make_self_init () in
  let pos = Array.init n (fun _ -> (Random.State.float rand (float_of_int width), Random.State.float rand (float_of_int height))) in
  let disp = Array.init n (fun _ -> (0.,0.)) in
  let area = (float_of_int width) *. (float_of_int height) in
  let k = sqrt (area /. (float_of_int n)) in
  let epsilon = 1e-6 in
  let temperature = ref (min (float_of_int width) (float_of_int height) /. 10.) in
  let cool_rate = 0.95 in

  let add_disp i (dx,dy) =
    let (x,y) = disp.(i) in
    disp.(i) <- (x +. dx, y +. dy)
  in

  for _ = 1 to iterations do
    (* reset disp *)
    for i = 0 to n-1 do disp.(i) <- (0.,0.) done;

    (* repulsive forces O(n^2) *)
    for i = 0 to n-1 do
      for j = i+1 to n-1 do
        let (xi, yi) = pos.(i) in
        let (xj, yj) = pos.(j) in
        let dx = xi -. xj in
        let dy = yi -. yj in
        let dist = sqrt (dx*.dx +. dy*.dy) |> max epsilon in
        let force = (k *. k) /. dist in
        let ux = dx /. dist in
        let uy = dy /. dist in
        add_disp i (ux *. force, uy *. force);
        add_disp j (-. ux *. force, -. uy *. force)
      done
    done;

    (* attractive forces on edges *)
    List.iter (fun (u,v,_) ->
      let (xu,yu) = pos.(u) in
      let (xv,yv) = pos.(v) in
      let dx = xu -. xv in
      let dy = yu -. yv in
      let dist = sqrt (dx*.dx +. dy*.dy) |> max epsilon in
      let force = (dist*.dist) /. k in
      let ux = dx /. dist in
      let uy = dy /. dist in
      add_disp u (-. ux *. force, -. uy *. force);
      add_disp v (ux *. force, uy *. force)
    ) edges_idx;

    (* apply displacements with temperature cap and keep inside box *)
    for i = 0 to n-1 do
      let (dx,dy) = disp.(i) in
      let d = sqrt (dx*.dx +. dy*.dy) in
      let max_disp = !temperature in
      let (ux,uy) =
        if d > epsilon then (dx /. d, dy /. d) else (0.,0.)
      in
      let disp_len = if d < max_disp then d else max_disp in
      let (x,y) = pos.(i) in
      let newx = x +. ux *. disp_len in
      let newy = y +. uy *. disp_len in
      (* clamp inside margins *)
      let margin = 20. in
      let minx = margin and maxx = (float_of_int width) -. margin in
      let miny = margin and maxy = (float_of_int height) -. margin in
      let nx = if newx < minx then minx else if newx > maxx then maxx else newx in
      let ny = if newy < miny then miny else if newy > maxy then maxy else newy in
      pos.(i) <- (nx, ny)
    done;

    (* cool *)
    temperature := !temperature *. cool_rate
  done;
  ids, labels, pos

(* ---------- SVG rendering ---------- *)

let node_radius = 14.0

let render_svg ~width ~height ~directed ids labels pos edges out_chan =
  let pr fmt = Printf.fprintf out_chan fmt in
  pr "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
  pr "<svg xmlns='http://www.w3.org/2000/svg' width='%d' height='%d' viewBox='0 0 %d %d'>\n" width height width height;
  if directed then (
    pr "<defs>\n";
    pr "<marker id='arrow' viewBox='0 0 10 10' refX='10' refY='5' markerUnits='strokeWidth' markerWidth='8' markerHeight='6' orient='auto'>\n";
    pr "<path d='M 0 0 L 10 5 L 0 10 z' />\n";
    pr "</marker>\n";
    pr "</defs>\n";
  );
  pr "<rect width='100%%' height='100%%' fill='white' />\n";

  (* edges (straight lines) *)
  List.iter (fun (u,v,label) ->
    let (xu,yu) = pos.(u) in
    let (xv,yv) = pos.(v) in
    (* shorten line so it doesn't go inside the circles *)
    let dx = xv -. xu in
    let dy = yv -. yu in
    let d = sqrt (dx*.dx +. dy*.dy) |> max 1e-6 in
    let ux = dx /. d and uy = dy /. d in
    let startx = xu +. ux *. node_radius in
    let starty = yu +. uy *. node_radius in
    let endx = xv -. ux *. node_radius in
    let endy = yv -. uy *. node_radius in
    if directed then
      pr "<line x1='%f' y1='%f' x2='%f' y2='%f' stroke='#999' stroke-width='1.5' marker-end='url(#arrow)' />\n"
        startx starty endx endy
    else
      pr "<line x1='%f' y1='%f' x2='%f' y2='%f' stroke='#999' stroke-width='1.2' />\n"
        startx starty endx endy;
    (* label at midpoint *)
    if label <> "" then
      let mx = (startx +. endx) /. 2. in
      let my = (starty +. endy) /. 2. in
      pr "<text x='%f' y='%f' font-family='Arial' font-size='10' text-anchor='middle' alignment-baseline='middle'>%s</text>\n"
        mx my (escape_xml label)
  ) edges;

  (* nodes *)
  for i = 0 to Array.length ids - 1 do
    let lbl = labels.(i) in
    let (x,y) = pos.(i) in
    pr "<g class='node'>\n";
    pr "<circle cx='%f' cy='%f' r='%f' fill='#69b3a2' stroke='#333' stroke-width='1.2' />\n" x y node_radius;
    pr "<text x='%f' y='%f' font-family='Arial' font-size='12' text-anchor='middle' alignment-baseline='middle' fill='white'>%s</text>\n"
      x y (escape_xml lbl);
    pr "</g>\n";
  done;

  pr "</svg>\n"

(* ---------- main ---------- *)

let () =
  if Array.length Sys.argv < 3 then begin
    prerr_endline "Usage: graph2svg <input.json> <output.svg> [width] [height] [iterations]";
    prerr_endline "Example: graph2svg graph.json out.svg 1200 800 500";
    exit 1
  end;
  let in_file = Sys.argv.(1) in
  let out_file = Sys.argv.(2) in
  let width = if Array.length Sys.argv > 3 then int_of_string Sys.argv.(3) else 1200 in
  let height = if Array.length Sys.argv > 4 then int_of_string Sys.argv.(4) else 800 in
  let iterations = if Array.length Sys.argv > 5 then int_of_string Sys.argv.(5) else 400 in

  let g = load_graph in_file in
  let n = List.length g.nodes in
  Printf.eprintf "Loaded graph: %d nodes, %d edges\n%!" n (List.length g.edges);

  (* compute layout *)
  let ids_array, labels_array, pos = fr_layout ~width ~height ~iterations g in

  (* map edges to indices and labels *)
  let id_to_index = Hashtbl.create (Array.length ids_array) in
  Array.iteri (fun i id -> Hashtbl.add id_to_index id i) ids_array;
  let edges_idx =
    g.edges
    |> List.fold_left (fun acc e ->
        try
          let u = Hashtbl.find id_to_index e.src in
          let v = Hashtbl.find id_to_index e.dst in
          (u, v, e.label)::acc
        with Not_found ->
          prerr_endline ("Warning: edge references unknown node: " ^ e.src ^ " or " ^ e.dst);
          acc
      ) []
    |> List.rev
  in

  (* open output and render svg *)
  let oc = open_out_bin out_file in
  render_svg ~width ~height ~directed:g.directed ids_array labels_array pos edges_idx oc;
  close_out oc;
  Printf.eprintf "Wrote SVG to %s\n%!" out_file
