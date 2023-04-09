:- [pokemon, damage].

% Create a loop of battle
battle(Player, PlayerHP, Computer, ComputerHP) :-
    PlayerHP>0, ComputerHP>0,
    promptMessages(Player, PlayerHP, Computer, ComputerHP),
    pokemon(Player, speed, PlayerSpeed),
    pokemon(Computer, speed, ComputerSpeed),
    fasterGoFirst(Player, PlayerSpeed, PlayerHP, NewPlayerHP, Computer, ComputerSpeed, ComputerHP, NewComputerHP),
    checkIfContinue(Player, PlayerSpeed, NewPlayerHP, Computer, ComputerSpeed, NewComputerHP).

fasterGoFirst(Player, PlayerSpeed, PlayerHP, NewPlayerHP, Computer, ComputerSpeed, ComputerHP, NewComputerHP) :-
    (PlayerSpeed >= ComputerSpeed -> 
        playerGoFirst(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP); 
        computerGoFirst(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP)).

playerGoFirst(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    playersTurn(Player, Computer, ComputerHP, NewComputerHP),
    computersTurn(Computer, Player, PlayerHP, NewPlayerHP).

computerGoFirst(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    computersTurn(Computer, Player, PlayerHP, NewPlayerHP),
    playersTurn(Player, Computer, ComputerHP, NewComputerHP).

checkIfContinue(Player, PlayerSpeed, NewPlayerHP, Computer, ComputerSpeed, NewComputerHP) :-
    (NewPlayerHP > 0, NewComputerHP > 0 ->
        battle(Player, NewPlayerHP, Computer, NewComputerHP)
    ; NewPlayerHP =< 0, NewComputerHP =< 0 ->
        fasterToWin(PlayerSpeed, ComputerSpeed)
    ; getResult(NewPlayerHP, NewComputerHP)
    ).

getResult(PlayerHP, ComputerHP) :-
    (PlayerHP > ComputerHP -> writeln('\nVictory!\n'); writeln('\nDefeat!\n')),
    !.

fasterToWin(PlayerSpeed, ComputerSpeed) :-
    (PlayerSpeed >= ComputerSpeed -> writeln('\nYou were faster! Victory!\n'); writeln('\nComputer was faster! Defeat!\n')),
    !.

promptMessages(Player, PlayerHP, Computer, ComputerHP) :-
    write('\nPlayer: '), write(Player), write(' | Computer: '), write(Computer),
    format('\nPlayer HP: ~1f | Computer HP: ~1f~n', [PlayerHP, ComputerHP]).

attack(Attacker, Defender, AttackerMove, DefenderOriginalHP, DefenderRemainingHP, IsPlayer) :-
    calculate_damage(Attacker, Defender, AttackerMove, AttackerDamage),
    DefenderRemainingHP is DefenderOriginalHP-AttackerDamage,
    (IsPlayer == 1 -> (
    format('~w (ally) used ~w! ~w (enemy) lost ~1f health.~n', [Attacker, AttackerMove, Defender, AttackerDamage]),
    format('~w (enemy) has ~1f health left.~n', [Defender, DefenderRemainingHP]));
    format('~w (enemy) used ~w! ~w (ally) lost ~1f health.~n', [Attacker, AttackerMove, Defender, AttackerDamage]),
    format('~w (ally) has ~1f health left.~n', [Defender, DefenderRemainingHP])).

playersTurn(Player, Computer, ComputerHP, NewComputerHP) :-
    pokemon(Player, moves, PlayerMoves),
    write('\nChoose your move:'),
    writeln(PlayerMoves), read(PlayerMove),
    writeln("\nPlayer's turn:"),
    attack(Player, Computer, PlayerMove, ComputerHP, NewComputerHP, 1).

computersTurn(Computer, Player, PlayerHP, NewPlayerHP) :-
    pokemon(Computer, moves, ComputerMoves),
    random_member(ComputerChosenMove, ComputerMoves),
    writeln("\nComputer's turn:"),
    attack(Computer, Player, ComputerChosenMove, PlayerHP, NewPlayerHP, 0).
    