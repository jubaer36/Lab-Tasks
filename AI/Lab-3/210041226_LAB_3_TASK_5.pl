count([],0).

count( [_| L], N):-
    count(L, N1),
    N is N1+1.