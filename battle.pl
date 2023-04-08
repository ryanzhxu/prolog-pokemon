:- [pokemon, damage].

% create a loop of battle
battle(Player, PlayerHP, Computer, ComputerHP) :-
    PlayerHP>0, ComputerHP>0,
    promptMessages(Player, PlayerHP, Computer, ComputerHP),
    pokemon(Player, _, _, _, _, _, PlayerMoves), writeln(PlayerMoves),

    read(PlayerMove),
    calculate_damage(Player, Computer, PlayerMove, PlayerDamage),
    NewComputerHP is ComputerHP-PlayerDamage,

    format('~n~w used ~w! ~w lost ~w health.~n', [Player, PlayerMove, Computer, PlayerDamage]),
    format('~w has ~w health left.~n~n', [Computer, NewComputerHP]),

    (NewComputerHP =< 0 -> writeln('Victory!'), !;

    computer_choose_move(Computer, ComputerMove),
    calculate_damage(Computer, Player, ComputerMove, ComputerDamage),
    NewPlayerHP is PlayerHP-ComputerDamage,

    writeln("Computer's turn:"),

    format('~w used ~w! ~w lost ~w health.~n', [Computer, ComputerMove, Player, ComputerDamage]),
    format('~w has ~w health left.~n', [Player, NewPlayerHP]),

    (NewPlayerHP =< 0 -> writeln('Defeat!'), !;

    battle(Player, NewPlayerHP, Computer, NewComputerHP))).

computer_choose_move(Computer, ChosenMove) :-
    pokemon(Computer, _, _, _, _, _, Moves),
    random_member(ChosenMove, Moves).
    % write('Computer picked:'), writeln(ChosenMove).

promptMessages(Player, PlayerHealth, Computer, ComputerHealth) :-
    writeln(''),
    write('Player: '),writeln(Player), write('Player HP: '),writeln(PlayerHealth),
    writeln(''),
    write('Computer: '),writeln(Computer), write('Computer HP: '),writeln(ComputerHealth),
    writeln(''),
    write('Choose your move:').
    

% turn of computer, randomly choose the move
% c_turn_randomly_choose_move(Computer,Player,Damage,Health) :-
%     pokemon(Computer,_,_,_,_,_,Moves),
%     random_member(Move,Moves),
%     % damage(Computer,Player,Move,Damage).
%     calculate_health(Player, Move, NewHealth),
%     Health is NewHealth.