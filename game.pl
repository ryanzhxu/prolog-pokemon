:- [pokemon, battle, helpers].

go :-
    writeln('\nWelcome to Pokémon Game!\n'),
    start.

start :-
    get_all_pokemons(Pokemons),
    ((player_selected_pokemon(Pokemons, 0, Player_Pokemons),
    computer_selected_pokemon(0, Computer_Pokemons)) -> 
        track_game_process(Player_Pokemons, Computer_Pokemons, 1, 1, 0, 0)
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

% select three pokemons
player_selected_pokemon(_, 3,[]).
player_selected_pokemon(Pokemons, Num_Pokemon_Selected, [Pokemon|Result]) :-
    write('Please choose your pokemon to fight:\n\n'),
    print_list_with_index(Pokemons, 0),
    read(Selection),
    pokemon_index(Selection,Pokemon),
    Updated_Num is Num_Pokemon_Selected + 1,
    format('*Number of selected Pokemon: ~d \n\n', [Updated_Num]),
    player_selected_pokemon(Pokemons, Updated_Num, Result).

computer_selected_pokemon(3,[]).
computer_selected_pokemon(Num_Pokemon_Selected, [Pokemon|Result]) :-
    random_between(1, 6, Selection),
    pokemon_index(Selection,Pokemon),
    Updated_Num is Num_Pokemon_Selected + 1,
    computer_selected_pokemon(Updated_Num, Result).

% track game process
track_game_process(_, _, _, _, _, 3).
track_game_process(_, _, _, _, 3, _).
track_game_process(Player_Pokemons, Computer_Pokemons, P_Index, C_Index, P_Wins, C_Wins):-
    select_item(P_Index, Player_Pokemons, Player),
    select_item(C_Index, Computer_Pokemons, Computer),
    get_selected_pokemons_and_hps(Player, PHP, Computer, CHP),
    battle(Player, PHP, Computer, CHP, P_Win, C_Win),
    Updated_P_Wins is P_Wins + P_Win,
    Updated_C_Wins is C_Wins + C_Win,
    advance_index(P_Win, C_Win, P_Index, C_Index),
    format('*Player Win ~d times.\n *Computer Win ~d times.\n\n', [Updated_P_Wins, Updated_C_Wins]),
    track_game_process(Player_Pokemons, Computer_Pokemons, Updated_P_Index, Updated_C_Index, Updated_P_Wins, Updated_C_Wins).






