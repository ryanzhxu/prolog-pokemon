:- [pokemon, move].

apply_status(Pokemon, Move, NewPokemon) :-
    pokemon(Pokemon, Type, HP, CAttack, Defense, Speed, Moves),
    move(Move,_,-1),
    NewAttack is (1+2/3)*CAttack,
    NewPokemon = pokemon(Pokemon, Type, HP, NewAttack, Defense, Speed, Moves).

apply_status(Pokemon, Move, NewPokemon) :-
    pokemon(Pokemon, Type, HP, Attack, CDefense, Speed, Moves),
    move(Move,_,-2),
    NewDefense is (1+2/3)*CDefense,
    NewPokemon = pokemon(Pokemon, Type, HP, Attack, NewDefense, Speed, Moves).

apply_status(Pokemon, Move, NewPokemon) :-
    pokemon(Pokemon, Type, CurrentHP, Attack, Defense, Speed, Moves),
    move(Move,_,-3),
    (CurrentHP >= 210/2 -> NewHP is 210; NewHP is CurrentHP + 210/2),
    NewPokemon = pokemon(Pokemon, Type, NewHP, Attack, Defense, Speed, Moves).

apply_status(Pokemon, _, Pokemon).