edge(a, b, 3).
edge(a, c, 5).
edge(b, c, 2).
edge(b, d, 4).
edge(c, d, 1).

food(a, sushi).
food(b, pizza).
food(c, sushi).
food(d, burger).

food_path(Start, End, Visited, Foods, [Start, End], Cost) :-
    edge(Start, End, W),
    \+ member(End, Visited),
    food(End, F),
    \+ member(F, Foods),
    Cost is W.

food_path(Start, End, Visited, Foods, [Start | Path], Cost) :-
    edge(Start, Next, W),
    \+ member(Next, Visited),
    food(Next, F),
    \+ member(F, Foods),
    food_path(Next, End, [Next | Visited], [F | Foods], Path, Cost1),
    Cost is Cost1 + W.

all_food_paths(Start, End, Paths) :-
    food(Start, F),
    findall(
        (Path, Cost),
        food_path(Start, End, [Start], [F], Path, Cost),
        Paths
    ).

compare_cost_asc(<, (_, C1), (_, C2)) :- C1 < C2.
compare_cost_asc(>, (_, C1), (_, C2)) :- C1 > C2.
compare_cost_asc(=, (_, C),  (_, C)).

compare_cost_desc(<, (_, C1), (_, C2)) :- C1 > C2.
compare_cost_desc(>, (_, C1), (_, C2)) :- C1 < C2.
compare_cost_desc(=, (_, C),  (_, C)).

shortest_food_path(Start, End, Path, Cost) :-
    all_food_paths(Start, End, Paths),
    Paths \= [],
    predsort(compare_cost_asc, Paths, [(Path, Cost) | _]).

longest_food_path(Start, End, Path, Cost) :-
    all_food_paths(Start, End, Paths),
    Paths \= [],
    predsort(compare_cost_desc, Paths, [(Path, Cost) | _]).
