color(red).
color(green).
color(blue).

same(X,Y) :- color(X),color(Y),X=Y.
different(X,Y) :- color(X), color(Y) , X\=Y.


%same(X,Y)
different(X,Y)
