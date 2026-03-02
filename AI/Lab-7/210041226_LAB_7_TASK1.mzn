include "globals.mzn";

% Houses (1 = leftmost, 5 = rightmost)
set of int: HOUSES = 1..5;

enum Color = {Red, Green, Ivory, Yellow, Blue};
enum Nationality = {Englishman, Spaniard, Norwegian, Ukrainian, Japanese};
enum Candy = {Hershey, KitKat, Smarties, Snickers, MilkyWay};
enum Drink = {Coffee, Tea, Milk, OrangeJuice, Water};
enum Pet = {Dog, Fox, Snails, Horse, Zebra}; % 5th random animal

array[Nationality] of var HOUSES: nat_pos;
array[Color] of var HOUSES: color_pos;
array[Candy] of var HOUSES: candy_pos;
array[Drink] of var HOUSES: drink_pos;
array[Pet] of var HOUSES: pet_pos;

constraint all_different(nat_pos);
constraint all_different(color_pos);
constraint all_different(candy_pos);
constraint all_different(drink_pos);
constraint all_different(pet_pos);

constraint nat_pos[Englishman] = color_pos[Red];
constraint nat_pos[Spaniard] = pet_pos[Dog];
constraint nat_pos[Norwegian] = 1;
constraint color_pos[Green] = color_pos[Ivory] + 1;
constraint abs(candy_pos[Hershey] - pet_pos[Fox]) = 1;
constraint candy_pos[KitKat] = color_pos[Yellow];
constraint abs(nat_pos[Norwegian] - color_pos[Blue]) = 1;
constraint candy_pos[Smarties] = pet_pos[Snails];
constraint candy_pos[Snickers] = drink_pos[OrangeJuice];
constraint nat_pos[Ukrainian] = drink_pos[Tea];
constraint nat_pos[Japanese] = candy_pos[MilkyWay];
constraint abs(candy_pos[KitKat] - pet_pos[Horse]) = 1;
constraint drink_pos[Coffee] = color_pos[Green];
constraint drink_pos[Milk] = 3;

solve satisfy;

output [
  "Nationality: ", show(nat_pos), "\n",
  "Color: ", show(color_pos), "\n",
  "Candy: ", show(candy_pos), "\n",
  "Drink: ", show(drink_pos), "\n",
  "Pet: ", show(pet_pos), "\n"
];