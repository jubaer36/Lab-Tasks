var 1..3: G;
var 1..3: WS;
var 1..3: SS;
var 1..3: CS;
var 1..3: SES;
var 1..3: NS;

constraint G  != NS;
constraint G  != CS;

constraint NS != CS;

constraint CS != WS;
constraint CS != SS;
constraint CS != SES;

constraint WS != SS;

constraint SS != SES;

solve satisfy;
