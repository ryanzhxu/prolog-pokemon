%effectFactor(type of attacker, type of defender, effective factor)
effectFactor(fire, grass, 2).
effectFactor(fire, fire, 0.5).
effectFactor(fire, water, 0.5).

effectFactor(water, fire, 2).
effectFactor(water, ground, 2).
effectFactor(water, water, 0.5).
effectFactor(water, grass, 0.5).

effectFactor(grass, ground, 2).
effectFactor(grass, water, 2).
effectFactor(grass, flying, 0.5).
effectFactor(grass, grass, 0.5).
effectFactor(grass, fire, 0.5).

effectFactor(electric, water, 2).
effectFactor(electric, flying, 2).
effectFactor(electric, ground, 0.5).
effectFactor(electric, grass, 0.5).

effectFactor(flying, grass, 2).
effectFactor(flying, electric, 0.5).

effectFactor(ground, fire, 2).
effectFactor(ground, electric, 2).
effectFactor(ground, flying, 0.5).
effectFactor(ground, grass, 0.5).

effectFactor(normal, fire, 1).
effectFactor(normal, water, 1).
effectFactor(normal, grass, 1).