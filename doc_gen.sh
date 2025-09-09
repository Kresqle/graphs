path_to_executable() {
    local filename=$1
    echo "./_build/default/src/${filename}.exe"
}

path_to_example() {
    local filename=$1
    echo "./examples/${filename}"
}

doc_dbgg() {
    filename="de_bruijn_graph_gen"
    example_path="$(path_to_example ${filename})"
    executable="$(path_to_executable ${filename})"
    printf "Examples of De Bruijn graphs generated using \`${filename}.ml\`.\n\n" > "${example_path}.md"
    printf "All of the graphs generated are visualized using \`graph2svg.ml\`.\n\n" >> "${example_path}.md"
    printf "## De Bruijn graphs\n\n" >> "${example_path}.md"
    printf "In graph theory, an $n$-dimensional De Bruijn graph of $k$ symbols (that is,\n" >> "${example_path}.md"
    printf "on an alphabet of $k$ symbols) is a directed graph representing overlaps between\n" >> "${example_path}.md"
    printf "sequences of symbols of length $n$ (the same symbol may appear multiple times in\n" >> "${example_path}.md"
    printf "a sequence).\n\n" >> "${example_path}.md"
    printf "## Stats\n\n" >> "${example_path}.md"
    printf '$\\forall (k, n) \in (\mathbb{N}^*)^2, B(k, n) = (V, E)$ such that $|V| = k^n$ and $|E| = k^{n + 1} = k|V|$\n\n' >> "${example_path}.md"
    printf "| Graph | Nodes | Edges | Time to generate | Time to render |\n" >> "${example_path}.md"
    printf "| ----- | ----- | ----- | ---------------- | -------------- |\n" >> "${example_path}.md"
    table=""
    paragraphs=""
    K_MAX=4
    N_MAX=3
    for k in $(seq 1 $K_MAX)
    do
        s=$(seq 0 $((k-1)) | tr -d '\n')
        for n in $(seq 1 $N_MAX)
        do
            GEN_COMMAND="dune exec ${executable} ${s} ${n} ${example_path}/b_${k}_${n}.json"
            GEN_TIME=$({ TIMEFORMAT=%E; time $GEN_COMMAND >log.out 2>log.err; } 2>&1)
            RENDER_COMMAND="dune exec $(path_to_executable graph2svg) ${example_path}/b_${k}_${n}.json ${example_path}/b_${k}_${n}.svg 1200 800 500"
            RENDER_TIME=$({ TIMEFORMAT=%E; time $RENDER_COMMAND >log.out 2>log.err; } 2>&1)
            
            # echo "b_${k}_${n}.json took $GEN_TIME to generate and $RENDER_TIME to render"
            
            table="${table}| [B(${k}, ${n})](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen.md#b${k}-${n}) "
            table="${table}| $((k ** n)) "
            table="${table}| $((k ** (n + 1))) "
            table="${table}| ${GEN_TIME}s "
            table="${table}| ${RENDER_TIME}s "
            table="${table}|\n"

            paragraphs="${paragraphs}## B(${k}, ${n})\n\n"
            paragraphs="${paragraphs}Input :\n\n\`\`\`bash\n\$ ${GEN_COMMAND}\nGraph B(${k},${n}) written to ${example_path}/b_${k}_${n}.json\n\`\`\`\n\n"
            paragraphs="${paragraphs}Output : [JSON for B(${k},${n})](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_${k}_${n}.json)\n\n"
            paragraphs="${paragraphs}Result :\n\n![de_bruijn_graph_gen example $(((k - 1) * N_MAX + n))](https://github.com/Kresqle/graphs/blob/main/examples/de_bruijn_graph_gen/b_${k}_${n}.svg)\n\n"
        done
    done
    printf "${table}\n" >> "${example_path}.md"
    printf "${paragraphs}" >> "${example_path}.md"
}

# Call the function
doc_dbgg
