% Base case
sumto(0, 0).
sumto(1, 1).

% Recursive case
sumto(N, Sum) :-
    N > 1,
    N1 is N - 1,
    sumto(N1, S1),
    (   N mod 2 =:= 1
    ->  Sum is S1 + N
    ;   Sum is S1
    ).
    
sumto(5,N)

