:- [pokemon, damage].

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