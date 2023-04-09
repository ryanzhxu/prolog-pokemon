:- [pokemon, damage].

% Create a loop of battle
battle(Player, PlayerHP, Computer, ComputerHP) :-
    PlayerHP>0, ComputerHP>0,
    prompt_messages(Player, PlayerHP, Computer, ComputerHP),
    pokemon(Player, speed, PlayerSpeed),
    pokemon(Computer, speed, ComputerSpeed),
    faster_go_first(Player, PlayerSpeed, PlayerHP, NewPlayerHP, Computer, ComputerSpeed, ComputerHP, NewComputerHP),
    check_if_continue(Player, PlayerSpeed, NewPlayerHP, Computer, ComputerSpeed, NewComputerHP).

faster_go_first(Player, PlayerSpeed, PlayerHP, NewPlayerHP, Computer, ComputerSpeed, ComputerHP, NewComputerHP) :-
    (PlayerSpeed >= ComputerSpeed -> 
        player_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP); 
        computer_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP)).

player_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    players_turn(Player, Computer, ComputerHP, NewComputerHP),
    computers_turn(Computer, Player, PlayerHP, NewPlayerHP).

computer_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    computers_turn(Computer, Player, PlayerHP, NewPlayerHP),
    players_turn(Player, Computer, ComputerHP, NewComputerHP).

check_if_continue(Player, PlayerSpeed, NewPlayerHP, Computer, ComputerSpeed, NewComputerHP) :-
    (NewPlayerHP > 0, NewComputerHP > 0 ->
        battle(Player, NewPlayerHP, Computer, NewComputerHP)
    ; NewPlayerHP =< 0, NewComputerHP =< 0 ->
        faster_to_win(PlayerSpeed, ComputerSpeed)
    ; get_result(NewPlayerHP, NewComputerHP)
    ).

get_result(PlayerHP, ComputerHP) :-
    (PlayerHP > ComputerHP -> writeln('\nVictory!\n'); writeln('\nDefeat!\n')),
    !.

faster_to_win(PlayerSpeed, ComputerSpeed) :-
    (PlayerSpeed >= ComputerSpeed -> writeln('\nYou were faster! Victory!\n'); writeln('\nComputer was faster! Defeat!\n')),
    !.

prompt_messages(Player, PlayerHP, Computer, ComputerHP) :-
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

players_turn(Player, Computer, ComputerHP, NewComputerHP) :-
    pokemon(Player, moves, PlayerMoves),
    write('\nChoose your move:'),
    writeln(PlayerMoves), read(PlayerMove),
    writeln("\nPlayer's turn:"),
    attack(Player, Computer, PlayerMove, ComputerHP, NewComputerHP, 1).

computers_turn(Computer, Player, PlayerHP, NewPlayerHP) :-
    pokemon(Computer, moves, ComputerMoves),
    random_member(ComputerChosenMove, ComputerMoves),
    writeln("\nComputer's turn:"),
    attack(Computer, Player, ComputerChosenMove, PlayerHP, NewPlayerHP, 0).
    