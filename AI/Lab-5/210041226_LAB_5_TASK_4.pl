student(alice, 100, 70, 90).
student(bob, 80, 80, 80).
student(charlie, 100, 50, 100).
student(diana, 70, 70, 70).

% Grading logic WITH CUT (restructured)
subject_grade(Marks, 'A') :- Marks >= 90, !.
subject_grade(Marks, 'B') :- Marks >= 80, !.
subject_grade(Marks, 'C') :- Marks >= 70, !.
subject_grade(Marks, 'D') :- Marks >= 60, !.
subject_grade(_, 'F').

% Calculate lowest grade and total marks for a student
student_info(Name, LowestGrade, TotalMarks) :-
    student(Name, M1, M2, M3),
    subject_grade(M1, G1),
    subject_grade(M2, G2),
    subject_grade(M3, G3),
    TotalMarks is M1 + M2 + M3,
    min_grade([G1, G2, G3], LowestGrade).

% Find minimum grade (F < D < C < B < A)
min_grade([G], G).
min_grade([G1, G2 | Rest], MinGrade) :-
    (grade_less(G1, G2) -> Lower = G1 ; Lower = G2),
    min_grade([Lower | Rest], MinGrade).

% Grade comparison (lower grade is "less than")
grade_less('F', 'D').
grade_less('F', 'C').
grade_less('F', 'B').
grade_less('F', 'A').
grade_less('D', 'C').
grade_less('D', 'B').
grade_less('D', 'A').
grade_less('C', 'B').
grade_less('C', 'A').
grade_less('B', 'A').

% Collect all student information
all_students(Students) :-
    findall(
        [LowestGrade, TotalMarks, Name],
        student_info(Name, LowestGrade, TotalMarks),
        Students
    ).

% Main ranking predicate
rank_students(RankedList) :-
    all_students(Students),
    predsort(compare_students, Students, SortedDesc),
    reverse(SortedDesc, RankedList).

% Compare students: higher rank is better (B > C, higher total > lower total)
compare_students(<, [G1, T1, _], [G2, T2, _]) :-
    (grade_less(G2, G1) ; (G1 = G2, T1 > T2)).
compare_students(>, [G1, T1, _], [G2, T2, _]) :-
    (grade_less(G1, G2) ; (G1 = G2, T1 < T2)).