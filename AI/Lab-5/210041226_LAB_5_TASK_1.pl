% ---------- Graph ----------
edge(a, b, 3).
edge(a, c, 5).
edge(b, c, 2).
edge(b, d, 4).
edge(c, d, 1).

path(Start, End, Visited, [Start, End], Cost, MaxEdge) :-
    edge(Start, End, W),
    \+ member(End, Visited),
    Cost is W,
    MaxEdge is W.

path(Start, End, Visited, [Start | Path], Cost, MaxEdge) :-
    edge(Start, Next, W),
    \+ member(Next, Visited),
    path(Next, End, [Next | Visited], Path, Cost1, MaxEdge1),
    Cost is Cost1 + W,
    MaxEdge is max(W, MaxEdge1).

all_paths(Start, End, Paths) :-
    findall(
        (Path, Cost, MaxEdge),
        path(Start, End, [Start], Path, Cost, MaxEdge),
        Paths
    ).

shortest_path(Start, End, BestPath, BestCost, BestMaxEdge) :-
    all_paths(Start, End, Paths),
    sort_paths(Paths, [(BestPath, BestCost, BestMaxEdge) | _]).

sort_paths(Paths, Sorted) :-
    predsort(compare_paths, Paths, Sorted).

compare_paths(<, (_, C1, M1), (_, C2, M2)) :-
    C1 < C2 ;
    (C1 =:= C2, M1 < M2).
compare_paths(>, (_, C1, M1), (_, C2, M2)) :-
    C1 > C2 ;
    (C1 =:= C2, M1 > M2).
    
    
shortest_path(a,d,Path,Cost,MaxEdge)
