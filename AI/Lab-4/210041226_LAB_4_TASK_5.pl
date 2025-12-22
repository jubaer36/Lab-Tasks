edge(a, b).
edge(b, c).
edge(c, d).
edge(d, b).
edge(c, e).

path(Start, End, Path) :-
    path(Start, End, [Start], Path).

% Base case
path(End, End, Visited, Path) :-
    reverse(Visited, Path).

% Recursive case with cycle check
path(Current, End, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    path(Next, End, [Next|Visited], Path).
path(a, e, P).
