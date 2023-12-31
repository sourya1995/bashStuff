function less() {
    if [ -t 0 ]; then #is terminal connected to standard input?
        command less -N "$@"
    else
        command less "$@"
    fi
}

