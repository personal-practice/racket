#lang racketlog

father(pavlos, orestis).
mother(alkisti, orestis).

couple(X, Y) :-
  father(X, Z),
  mother(Y, Z).

?couple(pavlos, X).