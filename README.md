# Pokémon

### What is the problem?

We'd like to build a BO5 Player vs Computer Pokémon game where each takes turn to cast a move and go against each other using their selected Pokémons.

  - There will be a number of Pokemons for selection.
  - Each Pokemon has
    - its own type, and each type has an advantage on another (i.e. fire > grass > water > fire)
    - 3 to 4 attack moves
    - The damage calculations will be based on a number of factors (current health, current status, element, etc.)
    - The game will 3 Pokemons versus 3 Pokemons. The player will be against a computer. When a player does not have any Pokemon "alive", the player lose the game.
    

### What is the something extra?
  - We have created a simple GUI using library XPCE. It shows 6 buttons of 6 pokemons. Once clicking the button, a new window showing the information of the corresponding pokemon will pop up. (The GUI only works on Windows OS).

### What did we learn from doing this?

  - Unlike other programming language, Prolog does not have something like "global variable". For example, when we need to track a value through different predicates, we have to ensure this value is passed through different predicates as a variable. Alternatively, we can have a recursion that updates or tracks the value, and have other predicates nested inside the recursion predicate.
  - Prolog does not have the directly access to the members of a list via index. We solve this issue by hard coding the index for each member of the list. This can be inefficient if the size of the list is large.
  - The Triple data structure is helpful for our project since our Pokemon has many properties. Using the Triple data data structure helps to write predicates that use the specific properties via the key words in the Triples, rather than passing a long list of properties.
