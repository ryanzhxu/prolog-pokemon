%weakness(Type1, Type2).    
weakness(fire, grass).

weakness(water, fire).
weakness(water, ground).

weakness(grass, water).
weakness(grass, ground).
weakness(grass, flying).

weakness(electric, water).
weakness(electric, flying).

weakness(ground, fire).
weakness(ground, electric).

weakness(flying, grass).

%resistance(Type1, Type2).
resistance(fire, fire).
resistance(fire, water).

resistance(water, water).