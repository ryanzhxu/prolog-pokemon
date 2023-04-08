:- [pokemon, battle].

start :-
    write('Choose your first pokemon to fight: [charmander,squirtle,bulbasaur, pikachu, charizard, torterra]: '),
    read(Player),
    pokemon(Player,_,PHP,_,_,_,_),
    computer_choose_pokemon_randomly(Computer),
    pokemon(Computer,_,CHP,_,_,_,_),
    battle(Player,PHP,Computer,CHP).

% computer randomly choose a pokemon
computer_choose_pokemon_randomly(Pokemon) :-
    findall(P,pokemon(P,_,_,_,_,_,_), Pokemons),
    random_member(Pokemon,Pokemons).