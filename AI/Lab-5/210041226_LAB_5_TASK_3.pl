coins([1, 5, 10, 50]).

coin_seq(0, _, _, []).
coin_seq(Amount, Coins, Prev, [C | Rest]) :-
    Amount > 0,
    member(C, Coins),
    C =\= Prev,
    Amount1 is Amount - C,
    Amount1 >= 0,
    coin_seq(Amount1, Coins, C, Rest).

change(Amount, BestCoins, NumCoins) :-
    coins(Coins),
    findall(
        Seq,
        coin_seq(Amount, Coins, -1, Seq),
        Seqs
    ),
    Seqs \= [],
    max_length(Seqs, BestCoins),
    length(BestCoins, NumCoins).

max_length([X], X).
max_length([H | T], Max) :-
    max_length(T, M),
    length(H, L1),
    length(M, L2),
    (L1 >= L2 -> Max = H ; Max = M).
