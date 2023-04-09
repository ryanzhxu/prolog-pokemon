:- [pokemon, damage].

% Create a loop of battle
battle(Player, PlayerHP, Computer, ComputerHP) :-
    PlayerHP>0, ComputerHP>0,
    promptMessages(Player, PlayerHP, Computer, ComputerHP),

    playersTurn(Player, Computer, ComputerHP, NewComputerHP),
    (NewComputerHP =< 0 -> writeln('\nVictory!'), !;

    computersTurn(Computer, Player, PlayerHP, NewPlayerHP),
    (NewPlayerHP =< 0 -> writeln('\nDefeat!'), !;

    battle(Player, NewPlayerHP, Computer, NewComputerHP))).

promptMessages(Player, PlayerHP, Computer, ComputerHP) :-
    write('\nPlayer: '), write(Player), write(' | Computer: '), write(Computer),
    write('\nPlayer HP: '), write(PlayerHP), write(' | Computer HP: '), writeln(ComputerHP).

attack(Attacker, Defender, AttackerMove, DefenderOriginalHP, DefenderRemainingHP) :-
    calculate_damage(Attacker, Defender, AttackerMove, AttackerDamage),
    DefenderRemainingHP is DefenderOriginalHP-AttackerDamage,
    format('~w used ~w! ~w lost ~w health.~n', [Attacker, AttackerMove, Defender, AttackerDamage]),
    format('~w has ~w health left.~n', [Defender, DefenderRemainingHP]).

playersTurn(Player, Computer, ComputerHP, NewComputerHP) :-
    pokemon(Player, _, _, _, _, _, PlayerMoves),
    write('\nChoose your move:'),
    writeln(PlayerMoves), read(PlayerMove),
    writeln("\nPlayer's turn:"),
    attack(Player, Computer, PlayerMove, ComputerHP, NewComputerHP).

computersTurn(Computer, Player, PlayerHP, NewPlayerHP) :-
    computer_choose_move(Computer, ComputerMove),
    writeln("\nComputer's turn:"),
    attack(Computer, Player, ComputerMove, PlayerHP, NewPlayerHP).

computer_choose_move(Computer, ChosenMove) :-
    pokemon(Computer, _, _, _, _, _, Moves),
    random_member(ChosenMove, Moves).