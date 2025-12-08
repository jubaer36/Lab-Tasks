parent(alice, bob).
parent(bob,charlie).
parent(alice,diana).
parent(diana, eric).
sibling(bob, diana).
sibling(eric, charlie).
gender(alice, woman).
gender(bob, man).
gender(charlie, man).
gender(diana, woman).
gender(eric, man).
age(alice,50).
age(bob,30).
age(charlie,15).
age(diana, 31).
age(eric, 13).

grandparent(X,Z) :- parent(X,Y), parent(Y, Z).
grandson(X,Z) :- parent(X,Y), parent(Y,Z), gender(Z,man).

%grandparent(alice,Y)
%grandparent(alice,eric)
grandson(alice,Y)


