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
        format("~nYou are faster! Go first!~n"), player_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP); 
        format("~nComputer is faster!~n"), computer_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP)).

player_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    players_turn(Player, Computer, ComputerHP, NewComputerHP),
    (NewComputerHP > 0 -> 
        computers_turn(Computer, Player, PlayerHP, NewPlayerHP);
        NewPlayerHP is PlayerHP, !).

computer_go_first(Player, PlayerHP, NewPlayerHP, Computer, ComputerHP, NewComputerHP) :-
    computers_turn(Computer, Player, PlayerHP, NewPlayerHP),
    (NewPlayerHP > 0 ->
        players_turn(Player, Computer, ComputerHP, NewComputerHP);
        NewComputerHP is ComputerHP, !).

check_if_continue(Player, NewPlayerHP, Computer, NewComputerHP, P_Win, C_Win) :-
    (one_is_leq_zero(NewPlayerHP, NewComputerHP) -> 
        get_result(NewPlayerHP, NewComputerHP, P_Win, C_Win);
        battle(Player, NewPlayerHP, Computer, NewComputerHP, P_Win, C_Win)).

get_result(PlayerHP, ComputerHP, P_Win, C_Win) :-
    (PlayerHP > ComputerHP -> 
        writeln('\nVictory!\n'), P_Win = 1, C_Win =0; 
        writeln('\nDefeat!\n'), P_Win = 0, C_Win =1),
    !.

prompt_messages(Player, PlayerHP, Computer, ComputerHP) :-
    pokemon(Player, type, PlayerType),
    pokemon(Computer, type, ComputerType),
    format("\nPlayer: ~w (~w) | Computer: ~w (~w)", [Player, PlayerType, Computer, ComputerType]),
    format("\nPlayer HP: ~1f \t| Computer HP: ~1f~n", [PlayerHP, ComputerHP]).

attack(Attacker, Defender, AttackerMove, DefenderOriginalHP, DefenderRemainingHP, IsPlayer) :-
    move(AttackerMove, MoveType, _),
    calculate_damage(Attacker, Defender, AttackerMove, TotalDamage),
    DefenderRemainingHP is DefenderOriginalHP-TotalDamage,
    (IsPlayer == 1 -> (
        format("~w (ally) used ~w (~w)! ~w (enemy) lost ~1f health.~n", [Attacker, AttackerMove, MoveType, Defender, TotalDamage]),
        format("~w (enemy) has ~1f health left.~n", [Defender, DefenderRemainingHP]));
        format("~w (enemy) used ~w (~w)! ~w (ally) lost ~1f health.~n", [Attacker, AttackerMove, MoveType, Defender, TotalDamage]),
        format("~w (ally) has ~1f health left.~n", [Defender, DefenderRemainingHP])).

players_turn(Player, Computer, ComputerHP, NewComputerHP) :-
    pokemon(Player, moves, PlayerMoves),
    write('\nChoose your move:\n\n'),
    print_list_with_index(PlayerMoves, 1),
    read(Selection),
    ((select_item(Selection, PlayerMoves, PlayerMove)) ->
        writeln("\nPlayer's turn:"), attack(Player, Computer, PlayerMove, ComputerHP, NewComputerHP, 1);
        writeln('\nNot a valid selection. Please try again.'), players_turn(Player, Computer, ComputerHP, NewComputerHP)).

computers_turn(Computer, Player, PlayerHP, NewPlayerHP) :-
    pokemon(Computer, moves, ComputerMoves),
    random_member(ComputerChosenMove, ComputerMoves),
    writeln("\nComputer's turn:"),
    attack(Computer, Player, ComputerChosenMove, PlayerHP, NewPlayerHP, 0).   