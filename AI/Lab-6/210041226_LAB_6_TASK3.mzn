var 1..3: A;
var 1..3: S;
var 1..3: M;
var 1..3: R;

constraint A != S;

constraint (A = M) -> (A = 2 /\ M = 2);

constraint (A != M) -> (A = 3 \/ M = 3);

constraint R != A;
constraint R != S;
constraint R != M;

constraint R > M;

solve satisfy;

output [
  "A = ", show(A), "\n",
  "S = ", show(S), "\n",
  "M = ", show(M), "\n",
  "R = ", show(R), "\n"
];
