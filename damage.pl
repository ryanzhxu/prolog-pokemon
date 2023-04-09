:- [pokemon, move, weakness].

calculate_damage(Attacker, Defender, Move, Damage) :-
    pokemon(Attacker, attack, AttackerAttack),
    pokemon(Defender, type, DefenderType),
    pokemon(Defender, defense, DefenderDefense),
    move(Move, MoveType, MoveDamage),
    calculate_adjusted(AttackerAttack, MoveType, MoveDamage, DefenderType, DefenderDefense, Adjusted),
    Damage is Adjusted.
    
calculate_adjusted(AttackerAttack, MoveType, MoveDamage, DefenderType, DefenderDefense, Adjusted) :-
    calculate_modifier(MoveType, DefenderType, Modifier),
    Adjusted is Modifier * (0.5 + 0.5 * AttackerAttack / DefenderDefense) * MoveDamage.
    
calculate_modifier(MoveType, DefenderType, Modifier) :-
    (weakness(MoveType, DefenderType) -> 
        (resistance(MoveType, DefenderType) -> Modifier=1; Modifier=2); Modifier=1).