:- [pokemon, battle].

start :-
    write('Choose your first pokemon to fight: [charmander, squirtle, bulbasaur, pikachu, charizard, torterra]: '),
    read(Player),
    pokemon(Player, hp, PHP),
    computer_choose_pokemon_randomly(Computer),
    pokemon(Computer, hp, CHP),
    battle(Player, PHP, Computer, CHP).

% computer randomly choose a pokemon
computer_choose_pokemon_randomly(Pokemon) :-
    findall(P, pokemon(P, _, _), Pokemons),
    random_member(Pokemon, Pokemons).