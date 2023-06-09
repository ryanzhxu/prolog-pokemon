print_list_with_index(List, IsMove) :-
    print_list_with_index(List, 1, IsMove),
    writeln('').

print_list_with_index([], _, _).
print_list_with_index([H|T], I, IsMove) :-
    (IsMove == 1 -> 
        move(H, MoveType, MoveDamage), format("    ~w. ~w (~w) ~w~n", [I, H, MoveType, MoveDamage]);
        format("    ~w. ~w~n", [I, H])),
    NextIndex is I + 1,
    print_list_with_index(T, NextIndex, IsMove).

get_sum_plus_one(A, B, Sum) :-
    Sum is A + B + 1.

one_is_leq_zero(X, Y) :-
    X =< 0; Y =< 0.

% index for selecting moves or pokemons
% the list can be in length 3 or 4
select_item(1,[A | _], A).
select_item(2,[_, B |_], B).
select_item(3,[_, _, C |_], C).
select_item(4,[_, _, _, D], D).

advance_index(Wins, New_Wins, Index, New_Index) :-
    (New_Wins > Wins -> 
        New_Index is Index;
        New_Index is Index + 1).