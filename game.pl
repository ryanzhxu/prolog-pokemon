:- [pokemon, battle].

start :-
    prompt_for_pokemon(Player),
    ((member(Player, [charmander, squirtle, bulbasaur, pikachu, charizard, torterra])) -> 
        get_player_and_computer(Player, PHP, Computer, CHP),
        battle(Player, PHP, Computer, CHP)
    ; writeln('\nNot a valid selection. Please try again.'), start).

prompt_for_pokemon(Player) :-
    write('Choose your first pokemon to fight: [charmander, squirtle, bulbasaur, pikachu, charizard, torterra]: '),
    read(Player).

get_player_and_computer(Player, PlayerHP, Computer, ComputerHP) :-
    pokemon(Player, hp, PlayerHP),
    random_member(Computer, [charmander, squirtle, bulbasaur, pikachu, charizard, torterra]),
    pokemon(Computer, hp, ComputerHP).