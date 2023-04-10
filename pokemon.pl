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
pokemon_index(1, bulbasaur).
pokemon_index(2, charizard).
pokemon_index(3, charmander).
pokemon_index(4, pikachu).
pokemon_index(5, squirtle).
pokemon_index(6, torterra).


get_all_pokemons(Pokemons) :-
    findall(Name, pokemon(Name, _, _), Names),
    sort(Names, Pokemons).

    
:- assertz(file_search_path(library,pce('prolog/lib'))).
:- assertz(file_search_path(pce,'C:/Program Files/swipl/xpce/')). 
:- assertz(file_search_path(pce,swi(xpce))).
:- use_module(library(pce)).
:- use_module(library(pce_style_item)).
:- use_module(library(pce_util)).

:- multifile user:file_search_path/2.
:- dynamic   user:file_search_path/2.
user:file_search_path(images, '.').

% Predicate to create the main window and its components
gui :-
    new(Window, dialog('Pokémon Information')),

    send(Window, append, button('Charmander', message(@prolog, pokemon_information, 'Charmander'))),
    send(Window, append, button('Squirtle', message(@prolog, pokemon_information, 'Squirtle'))),
    send(Window, append, button('Bulbasaur', message(@prolog, pokemon_information, 'Bulbasaur'))),
    send(Window, append, button('Pikachu', message(@prolog, pokemon_information, 'Pikachu'))),
    send(Window, append, button('Charizard', message(@prolog, pokemon_information, 'Charizard'))),
    send(Window, append, button('Torterra', message(@prolog, pokemon_information, 'Torterra'))),
    
    send(Window, append, button('Close', message(Window, destroy))),
    send(Window, open),
    event_loop(Window).

    
% display the Pokémon information
pokemon_information(PokemonName) :-
    pokemon_to_lower(PokemonName, LowerPokemonName),
    pokemon(LowerPokemonName, type, Type),
    pokemon(LowerPokemonName, hp, HP),
    pokemon(LowerPokemonName, attack, Attack),
    pokemon(LowerPokemonName, defense, Defense),
    pokemon(LowerPokemonName, speed, Speed),
    pokemon(LowerPokemonName, moves, Moves),
    format_info(PokemonName, Type, HP, Attack, Defense, Speed, Moves, Info),
    new(InfoDialog, dialog(PokemonName)),
    send(InfoDialog, append, new(_, text(Info))),
    send(InfoDialog, append, button('Close', message(InfoDialog, destroy))),
    send(InfoDialog, open).

pokemon_to_lower(PokemonName, LowerPokemonName) :-
    downcase_atom(PokemonName, LowerPokemonName).

format_info(PokemonName, Type, HP, Attack, Defense, Speed, Moves, Info) :-
    format(string(Info), "Name: ~w\nType: ~w\nHP: ~d\nAttack: ~d\nDefense: ~d\nSpeed: ~d\nMoves: ~w", [PokemonName, Type, HP, Attack, Defense, Speed, Moves]).


event_loop(Window) :-
    repeat,
    (   object(Window)
    ->  pce_dispatch,
        fail
    ;!
    ).
