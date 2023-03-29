% pokemon(name, type, HP, attack, defense, speed, list of moves)
pokemon(charmander, fire, 150, 14, 10, 20, [scratch, flamethrower, swords_dance]).
pokemon(squirtle, water, 180, 8, 18, 15, [tackle, water_gun, iron_defense]).
pokemon(bulbasaur, grass, 210, 6, 20, 10, [tackle, vine_whip, synthesis]).

%effectFactor(type of attacker, type of defender, effective factor)
effectFactor(fire, grass, 2).
effectFactor(fire, fire, 0.5).
effectFactor(fire, water, 0.5).
effectFactor(water, fire, 2).
effectFactor(water, water, 0.5).
effectFactor(water, grass, 0.5).
effectFactor(grass, water, 2).
effectFactor(grass, grass, 0.5).
effectFactor(grass, fire, 0.5).
effectFactor(normal, fire, 1).
effectFactor(normal, water, 1).
effectFactor(normal, grass, 1).

%move(move name, type, damage)
move(scratch, normal, 30).
move(flamethrower, fire, 40).
move(tackle, normal, 30).
move(water_gun, water, 40).
move(vine_whip, grass, 40).
move(swords_dance, normal, -1).
move(iron_defense, normal, -2).
move(synthesis, normal, -3).

% 
apply_status(Pokemon, Move, NewPokemon) :-
    pokemon(Pokemon, Type, HP, CAttack, Defense, Speed, Moves),
    move(Move,_,-1),
    NewAttack is (1+2/3)*CAttack,
    NewPokemon = pokemon(Pokemon, Type, HP, NewAttack, Defense, Speed, Moves).

apply_status(Pokemon, Move, NewPokemon) :-
    pokemon(Pokemon, Type, HP, Attack, CDefense, Speed, Moves),
    move(Move,_,-2),
    NewDefense is (1+2/3)*CDefense,
    NewPokemon = pokemon(Pokemon, Type, HP, Attack, NewDefense, Speed, Moves).

apply_status(Pokemon, Move, NewPokemon) :-
    pokemon(Pokemon, Type, CurrentHP, Attack, Defense, Speed, Moves),
    move(Move,_,-3),
    (CurrentHP >= 210/2 -> NewHP is 210; NewHP is CurrentHP + 210/2),
    NewPokemon = pokemon(Pokemon, Type, NewHP, Attack, Defense, Speed, Moves).

apply_status(Pokemon, _, Pokemon).

damage(Attacker, Defender, Move, Damage) :-
    pokemon(Attacker, Type_1, HP_1, Attack_1, Defense_1, Speed_1, Moves_1),
    member(Move, Moves_1),
    move(_,_,BaseDamage),
    BaseDamage > 0,
    pokemon(Defender, Type_2, HP_2, Attack_2, Defense_2, Speed_2, Moves_2),
    (Attacker=Defender;dif(Attacker,Defender)),
    (Type_1=Type_2;dif(Type_1,Type_2)),
    (HP_1=HP_2;dif(HP_1,HP_2)),
    (Attack_1=Attack_2;dif(Attack_1,Attack_2)),
    (Defense_1=Defense_2;dif(Defense_1,Defense_2)),
    (Speed_1=Speed_2;dif(Speed_1,Speed_2)),
    (Moves_1=Moves_2;dif(Moves_1,Moves_2)),
    move(Move, MoveType, BaseDamage),
    effectFactor(MoveType,Type_2, Multiplier),
    Damage is (BaseDamage*Attack_1)*Multiplier/Defense_2.


start :-
    write('Choose your first pokemon to fight: [charmander,squirtle,bulbasaur]:'),
    read(Player),
    pokemon(Player,_,PHP,_,_,_,_),
    computer_choose_pokemon_randomly(Computer),
    pokemon(Computer,_,CHP,_,_,_,_),
    battle(Player,PHP,Computer,CHP).

% computer randomly choose a pokemon
computer_choose_pokemon_randomly(Pokemon) :-
    findall(P,pokemon(P,_,_,_,_,_,_), Pokemons),
    random_member(Pokemon,Pokemons).

% create a loop of battle
battle(Player,PHP,Computer,CHP) :-
    PHP>0,
    write('Player:'),writeln(Player), write('HP:'),writeln(PHP),
    CHP>0,
    write('Computer:'),writeln(Computer), write('HP:'),writeln(CHP),
    write('Choose your move:'),
    pokemon(Player,_,_,_,_,_,Moves),
    writeln(Moves),
    read(Move),
    damage(Player,Computer,Move,Pdamage),
    NewCHP is CHP-Pdamage,
    (NewCHP =< 0 -> writeln('You win!'), !;
    c_turn_randomly_choose_move(Computer,Player,Cdamage),
    NewPHP is PHP-Cdamage,
    (NewPHP =< 0 -> writeln('You lose!'), !;
    battle(Player,NewPHP,Computer,NewCHP))).

% turn of computer, randomly choose the move
c_turn_randomly_choose_move(Computer,Player,Damage) :-
    pokemon(Computer,_,_,_,_,_,Moves),
    random_member(Move,Moves),
    damage(Computer,Player,Move,Damage).




