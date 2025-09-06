type node = {
  id : string;
  label : string;
}

type edge = {
  source : string;
  target : string;
  label : string;
}

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

  
let de_bruijn_seq k = de_bruijn_seq_alphabet (Array.init k string_of_int)

let binary_de_bruijn_seq = de_bruijn_seq 2

