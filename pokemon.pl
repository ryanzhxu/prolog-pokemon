%pokemon(Name, Data type, Data).
pokemon(charmander, type, fire).
pokemon(charmander, hp, 150).
pokemon(charmander, attack, 14).
pokemon(charmander, defense, 10).
pokemon(charmander, speed, 20).
pokemon(charmander, moves, [scratch, flamethrower, fire_blast, fire_spin]).

pokemon(squirtle, type, water).
pokemon(squirtle, hp, 180).
pokemon(squirtle, attack, 8).
pokemon(squirtle, defense, 18).
pokemon(squirtle, speed, 15).
pokemon(squirtle, moves, [tackle, water_gun, quick_attack, scratch]).

pokemon(bulbasaur, type, grass).
pokemon(bulbasaur, hp, 210).
pokemon(bulbasaur, attack, 6).
pokemon(bulbasaur, defense, 20).
pokemon(bulbasaur, speed, 10).
pokemon(bulbasaur, moves, [tackle, vine_whip, quick_attack, scratch]).

pokemon(pikachu, type, electric).
pokemon(pikachu, hp, 180).
pokemon(pikachu, attack, 10).
pokemon(pikachu, defense, 15).
pokemon(pikachu, speed, 30).
pokemon(pikachu, moves, [quick_attack, spark, electro_ball, thunderbolt]).

pokemon(charizard, type, flying).
pokemon(charizard, hp, 170).
pokemon(charizard, attack, 15).
pokemon(charizard, defense, 20).
pokemon(charizard, speed, 10).
pokemon(charizard, moves, [fire_spin, wing_attack, flamethrower, fire_blast]).

pokemon(torterra, type, ground).
pokemon(torterra, hp, 190).
pokemon(torterra, attack, 9).
pokemon(torterra, defense, 15).
pokemon(torterra, speed, 10).
pokemon(torterra, move, [earthquake, blazor_leaf, quick_attack, rock_smash]).

% index for selecting pokemons
pokemon_index(1, bulbasaur).
pokemon_index(2, charizard).
pokemon_index(3, charmander).
pokemon_index(4, pikachu).
pokemon_index(5, squirtle).
pokemon_index(6, torterra).

% select three pokemons
select_pokemon(3,[]).
select_pokemon(Num_Pokemon_Selected, [Pokemon|Result]) :-
    write('Choose your pokemon'),
    writeln([charmander, squirtle, bulbasaur, pikachu, charizard, torterra]),
    read(Selection),
    pokemon_index(Selection,Pokemon),
    Updated_Num is Num_Pokemon_Selected + 1,
    select_pokemon(Updated_Num, Result).

% index for selecting moves
% the move array can be in length 3 or 4
select_move(1,[A | _], A).
select_move(2,[_, B |_], B).
select_move(3,[_, _, C |_], C).
select_move(4,[_, _, _, D], D).

get_all_pokemons(Pokemons) :-
    findall(Name, pokemon(Name, _, _), Names),
    sort(Names, Pokemons).
    
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