:- [pokemon, damage].

% Create a loop of battle
battle(Player, PlayerHP, Computer, ComputerHP) :-
    PlayerHP>0, ComputerHP>0,
    promptMessages(Player, PlayerHP, Computer, ComputerHP),
    pokemon(Player, _, _, _, _, PlayerSpeed, _),
    pokemon(Computer, _, _, _, _, ComputerSpeed, _),
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

attack(Attacker, Defender, AttackerMove, DefenderOriginalHP, DefenderRemainingHP) :-
    calculate_damage(Attacker, Defender, AttackerMove, AttackerDamage),
    DefenderRemainingHP is DefenderOriginalHP-AttackerDamage,
    format('~w used ~w! ~w lost ~1f health.~n', [Attacker, AttackerMove, Defender, AttackerDamage]),
    format('~w has ~1f health left.~n', [Defender, DefenderRemainingHP]).

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