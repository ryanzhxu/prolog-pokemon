:- [pokemon, damage, helpers].

% Create a loop of battle
battle(Player, PlayerHP, Computer, ComputerHP, P_Win, C_Win) :-
    PlayerHP>0, ComputerHP>0,
    prompt_messages(Player, PlayerHP, Computer, ComputerHP),
    faster_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP),
    check_if_continue(Player, NewPlayerHP, Computer, NewComputerHP, P_Win, C_Win).

faster_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    pokemon(Player, speed, PlayerSpeed),
    pokemon(Computer, speed, ComputerSpeed),
    (PlayerSpeed >= ComputerSpeed -> 
        player_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP); 
        computer_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP)).

player_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    players_turn(Player, Computer, ComputerHP, NewComputerHP),
    computers_turn(Computer, Player, PlayerHP, NewPlayerHP).

computer_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    computers_turn(Computer, Player, PlayerHP, NewPlayerHP),
    players_turn(Player, Computer, ComputerHP, NewComputerHP).

check_if_continue(Player, NewPlayerHP, Computer, NewComputerHP, P_Win, C_Win) :-
    (NewPlayerHP > 0, NewComputerHP > 0 ->
        battle(Player, NewPlayerHP, Computer, NewComputerHP, P_Win, C_Win)
    ; NewPlayerHP =< 0, NewComputerHP =< 0 ->
        faster_to_win(Player, Computer, P_Win, C_Win)
    ; get_result(NewPlayerHP, NewComputerHP, P_Win, C_Win)
    ).

get_result(PlayerHP, ComputerHP, P_Win, C_Win) :-
    (PlayerHP > ComputerHP -> writeln('\nVictory!\n'), P_Win = 1, C_Win =0
    ; writeln('\nDefeat!\n'), P_Win = 0, C_Win =1),
    !.

faster_to_win(Player, Computer, P_Win, C_Win) :-
    pokemon(Player, speed, PlayerSpeed),
    pokemon(Computer, speed, ComputerSpeed),
    (PlayerSpeed >= ComputerSpeed -> writeln('\nYou were faster! Victory!\n'), P_Win = 1, C_Win =0
    ; writeln('\nComputer was faster! Defeat!\n'), P_Win = 0, C_Win =1),
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
    write('\nChoose your move:\n\n'),
    print_list_with_index(PlayerMoves, 1),
    read(Selection),
    ((select_item(Selection, PlayerMoves, PlayerMove)) ->
    writeln("\nPlayer's turn:"),
    attack(Player, Computer, PlayerMove, ComputerHP, NewComputerHP, 1)
    ; writeln('\nNot a valid selection. Please try again.'), players_turn(Player, Computer, ComputerHP, NewComputerHP)).

computers_turn(Computer, Player, PlayerHP, NewPlayerHP) :-
    pokemon(Computer, moves, ComputerMoves),
    random_member(ComputerChosenMove, ComputerMoves),
    writeln("\nComputer's turn:"),
    attack(Computer, Player, ComputerChosenMove, PlayerHP, NewPlayerHP, 0).   