% pokemon(name,     type,     HP,   attack, defense, speed, list of moves)
pokemon(charmander, fire,     150,  14,     10,     20,     [scratch, flamethrower, fire_blast, fire_spin]).
pokemon(squirtle,   water,    180,  8,      18,     15,     [tackle, water_gun, quick_attack, scratch]).
pokemon(bulbasaur,  grass,    210,  6,      20,     10,     [tackle, vine_whip, quick_attack, scratch]).
pokemon(pikachu,    electric, 180,  10,     15,     30,     [quick_attack, spark, electro_ball, thunderbolt]).
pokemon(charizard,  flying,   170,  15,     20,     10,     [fire_spin, wing_attack, flamethrower, fire_blast]).
pokemon(torterra,   ground,   190,  9,      15,     10,     [earthquake, blazor_leaf, quick_attack, rock_smash]).

% to be refactored
% determine which pokemon moves first
% move_order(pokemon_1, pokemon_2, first_mover, second_mover).
move_order(Pokemon_1, Pokemon_2, Pokemon_1, Pokemon_2) :-
    pokemon(Pokemon_1, speed, S1),
    pokemon(Pokemon_2, speed, S2),
    S2 < S1.

move_order(Pokemon_1, Pokemon_2, Pokemon_2, Pokemon_1) :-
    pokemon(Pokemon_1, speed, S1),
    pokemon(Pokemon_2, speed, S2),
    S1 < S2.

% to be refactored
% drafting check win condition 
% win(turns)
win(0).
win(Turns):-
    Remaining is Turns - 1,
    win(Remaining).
    
:- assertz(file_search_path(library,pce('prolog/lib'))).
:- assertz(file_search_path(pce,swi(xpce))).
:- use_module(library(pce)).

gui :-
    new(Window, dialog('Pokemon Information')),
    send(Window, size, size(400, 200)),
    new(List, menu(pokemon)),
    send(List, layout, vertical),
    send(List, multiple_selection, @off),
    forall(pokemon(Name, _, _, _, _, _, _),
           send(List, append, Name)),
    new(ShowButton, button('Show Information', message(@prolog, show_info, List?selection))),
    send(Window, append, List),
    send(Window, append, ShowButton),
    send(Window, append, button('Quit', message(Window, destroy))),
    send(Window, open),
    event_loop.

show_info(Pokemon) :-
    pokemon(Pokemon, Type, HP, Attack, Defense, Speed, Moves),
    format('Name: ~w~nType: ~w~nHP: ~w~nAttack: ~w~nDefense: ~w~nSpeed: ~w~nMoves: ~w~n',
           [Pokemon, Type, HP, Attack, Defense, Speed, Moves]).
    
event_loop :-
    repeat,
    pce_dispatch,
    fail.