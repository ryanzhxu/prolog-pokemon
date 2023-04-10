print_list_with_index(List, IsMove) :-
    print_list_with_index(List, 1, IsMove),
    writeln('').

print_list_with_index([], _, _).
print_list_with_index([H|T], I, IsMove) :-
    (IsMove == 1 -> 
        move(H, MoveType, MoveDamage), format('    ~w. ~w (~w) ~w~n', [I, H, MoveType, MoveDamage]);
        format('    ~w. ~w~n', [I, H])),
    NextIndex is I + 1,
    print_list_with_index(T, NextIndex, IsMove). 