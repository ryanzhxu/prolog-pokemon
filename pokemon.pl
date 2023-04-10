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
pokemon(torterra, moves, [earthquake, blazor_leaf, quick_attack, rock_smash]).

% index for selecting pokemons
pokemon_index(1, charmander).
pokemon_index(2, squirtle).
pokemon_index(3, bulbasaur).
pokemon_index(4, pikachu).
pokemon_index(5, charizard).
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

% Predicate to create the main window and its components
gui :-
    new(Window, dialog('Pokémon Information')),
    send(Window, append, button('Charmander', message(@prolog, show_pokemon_info, 'Charmander'))),
    send(Window, append, button('Squirtle', message(@prolog, show_pokemon_info, 'Squirtle'))),
    send(Window, append, button('Bulbasaur', message(@prolog, show_pokemon_info, 'Bulbasaur'))),
    send(Window, append, button('Pikachu', message(@prolog, show_pokemon_info, 'Pikachu'))),
    send(Window, append, button('Charizard', message(@prolog, show_pokemon_info, 'Charizard'))),
    send(Window, append, button('Torterra', message(@prolog, show_pokemon_info, 'Torterra'))),

    send(Window, append, button('Close', message(Window, destroy))),

    send(Window, open),
    event_loop.

% Predicate to display the Pokémon information
show_pokemon_info(PokemonName) :-
    pokemon_atom_to_lower(PokemonName, LowerPokemonName),
    pokemon(LowerPokemonName, type, Type),
    pokemon(LowerPokemonName, hp, HP),
    pokemon(LowerPokemonName, attack, Attack),
    pokemon(LowerPokemonName, defense, Defense),
    pokemon(LowerPokemonName, speed, Speed),
    pokemon(LowerPokemonName, moves, Moves),
    format_pokemon_info(PokemonName, Type, HP, Attack, Defense, Speed, Moves, Info),
    new(InfoDialog, dialog(PokemonName)),
    send(InfoDialog, append, new(T, text(Info))),
    send(InfoDialog, append, button('Close', message(InfoDialog, destroy))),
    send(InfoDialog, open).


% Convert the Pokémon name to a lowercase atom
pokemon_atom_to_lower(PokemonName, LowerPokemonName) :-
    downcase_atom(PokemonName, LowerPokemonName).

% Format the Pokémon information as a string
format_pokemon_info(PokemonName, Type, HP, Attack, Defense, Speed, Moves, Info) :-
    format(string(Info), "Name: ~w\nType: ~w\nHP: ~d\nAttack: ~d\nDefense: ~d\nSpeed: ~d\nMoves: ~w", [PokemonName, Type, HP, Attack, Defense, Speed, Moves]).

event_loop :-
    repeat,
    pce_dispatch,
    fail.
