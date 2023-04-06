:- [pokemon, move, factor].

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

% redesigned damage function
damage(Attacker, Defender, Move, Damage) :-
    pokemon(Attacker, attack, A),
    pokemon(Attacker, move, M),
    member(Move, M),
    move(Move, MoveType, BaseDamage),
    BaseDamage > 0,
    pokemon(Defender, defense, D),
    pokemon(Defender, type, T),
    effectFactor(MoveType, T, Multiplier),
    Damage is ((BaseDamage * A) * Multiplier)/D.