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


%parent(alice,X)
%parent(Y,bob)
%age(X,30)
gender(X,man)

