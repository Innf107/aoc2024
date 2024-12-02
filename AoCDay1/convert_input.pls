#!/usr/bin/env polaris
options {
    "--reduced" as reduced: "use the reduced input file"
}

let unzip : forall a b. List((a, b)) -> (List(a), List(b))
let unzip(list) = match list {
    [] -> ([], [])
    ((x, y) :: rest) -> {
        let (xs, ys) = unzip(rest)
        (x :: xs, y :: ys)
    }
}

let parseIntPair : String -> (Number, Number)
let parseIntPair(string) = match regexpMatchGroups("(.*)   (.*)", string) {
    [[_, x, y]] -> (parseInt(x), parseInt(y))
    result -> fail("invalid number pair '${string}' matched as: ${toString(result)}")
}

let input = lines(!cat (scriptLocal(if reduced then "input_reduced.txt" else "input.txt")))

let (list1, list2) = unzip([parseIntPair(line) | let line <- input])

print("data modify storage input list1 set value ${toString(list1)}")
print("data modify storage input list2 set value ${toString(list2)}")
