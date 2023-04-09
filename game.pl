:- [pokemon, battle].

start :-
    prompt_for_pokemon(Selection),
    ((pokemon_index(Selection, Player)) -> 
        pokemon(Player, hp, PHP),
        computer_choose_pokemon_randomly(Computer),
        pokemon(Computer, hp, CHP),
        battle(Player, PHP, Computer, CHP)
    ; writeln('\nNot a valid selection. Please try again.'), start).

% computer randomly choose a pokemon
computer_choose_pokemon_randomly(Pokemon) :-
    random_member(Pokemon, [charmander, squirtle, bulbasaur, pikachu, charizard, torterra]).

prompt_for_pokemon(Player) :-
    write('Choose your first pokemon to fight: [charmander, squirtle, bulbasaur, pikachu, charizard, torterra]: '),
    read(Selection).
