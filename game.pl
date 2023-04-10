:- [pokemon, battle, helpers].

go :-
    writeln('\nWelcome to Pokémon Game!\n'),
    start.

start :-
    get_all_pokemons(Pokemons),
    player_selects_pokemon(Selection, Pokemons),
    computer_selects_pokemon(Computer, Pokemons),
    ((pokemon_index(Selection, Player)) -> 
        get_selected_pokemons_and_hps(Player, PHP, Computer, CHP),
        battle(Player, PHP, Computer, CHP)
    ; writeln('\nNot a valid selection. Please try again.'), start).

player_selects_pokemon(Selection, Pokemons) :-
    write('Please choose your pokemon to fight:\n\n'),
    print_list_with_index(Pokemons, 0),
    read(Selection).

computer_selects_pokemon(Computer, Pokemons) :-
    random_member(Computer, Pokemons).

get_selected_pokemons_and_hps(Player, PlayerHP, Computer, ComputerHP) :-
    pokemon(Player, hp, PlayerHP),
    pokemon(Computer, hp, ComputerHP).