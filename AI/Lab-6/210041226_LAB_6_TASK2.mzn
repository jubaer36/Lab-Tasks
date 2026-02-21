var 1..4: Z;
var 1..4: I;
var 1..4: F;
var 1..4: N;

constraint Z != 4;

constraint I != F;

constraint (F = 1) \/ (F = 2);

constraint Z = I;
constraint Z != F;
constraint Z != N;

constraint N != 3;

solve satisfy;

output [
  "Z = ", show(Z), "\n",
  "I = ", show(I), "\n",
  "F = ", show(F), "\n",
  "N = ", show(N), "\n"
];
