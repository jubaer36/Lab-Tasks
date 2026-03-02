
% Time slots: 

set of int: TIME = 1..4;

% Faculty members
enum FAC = {X, Y};

% Tasks
enum TASK = {G, Q, C, D, L, NONE};

% Schedule matrix: who does what at each time
array[FAC, TIME] of var TASK: schedule;


% Constraint 1: Task durations
% G = 1 hour (exactly once)
constraint sum(f in FAC, t in TIME)(schedule[f,t] = G) = 1;

% C = 1 hour (exactly once)
constraint sum(f in FAC, t in TIME)(schedule[f,t] = C) = 1;

% D = 1 hour (exactly once)
constraint sum(f in FAC, t in TIME)(schedule[f,t] = D) = 1;

% Q = 2 consecutive hours (exactly twice)
constraint sum(f in FAC, t in TIME)(schedule[f,t] = Q) = 2;

% L = 2 consecutive hours (exactly twice)
constraint sum(f in FAC, t in TIME)(schedule[f,t] = L) = 2;

% Q must be consecutive and start at or before 10am (t <= 2) 
constraint
    exists(f in FAC, t in 1..3)(
        schedule[f,t] = Q /\ 
        schedule[f,t+1] = Q /\ 
        (t <= 2)
    );

% L must be consecutive and start at or before 10am (t <= 2)
constraint
    exists(f in FAC, t in 1..3)(
        schedule[f,t] = L /\ 
        schedule[f,t+1] = L /\ 
        (t <= 2)
    );

% AI Class (C) must happen before AI Lab (L)
constraint
    exists(fc in FAC, tc in TIME, fl in FAC, tl in TIME)(
        schedule[fc,tc] = C /\
        schedule[fl,tl] = L /\
        tc < tl
    );

% G before D ---
constraint
    exists(tg in TIME, td in TIME)(
        schedule[X,tg] = G /\
        (exists(f in FAC)(schedule[f,td] = D)) /\
        tg < td
    );

% DBMS Lab (D) finished by 10am (t <= 2) ---
constraint
    exists(f in FAC, t in 1..2)(schedule[f,t] = D);

% X must gather contents (G)
constraint exists(t in TIME)(schedule[X,t] = G);

% Person taking D cannot take L
constraint
    forall(f in FAC)(
        (exists(t in TIME)(schedule[f,t] = D)) ->
        (forall(t in TIME)(schedule[f,t] != L))
    );

% Person taking L must also take C 
constraint
    forall(f in FAC)(
        (exists(t in TIME)(schedule[f,t] = L)) ->
        (exists(t in TIME)(schedule[f,t] = C))
    );

% When one conducts D, the other attends and does nothing
constraint
    forall(t in TIME)(
        (schedule[X,t] = D -> schedule[Y,t] = NONE) /\
        (schedule[Y,t] = D -> schedule[X,t] = NONE)
    );

solve satisfy;

output [
    "Schedule:\n",
    "Time 1 (8-9):   X = ", show(schedule[X,1]), " , Y = ", show(schedule[Y,1]), "\n",
    "Time 2 (9-10):  X = ", show(schedule[X,2]), " , Y = ", show(schedule[Y,2]), "\n",
    "Time 3 (10-11): X = ", show(schedule[X,3]), " , Y = ", show(schedule[Y,3]), "\n",
    "Time 4 (11-12): X = ", show(schedule[X,4]), " , Y = ", show(schedule[Y,4]), "\n"
];