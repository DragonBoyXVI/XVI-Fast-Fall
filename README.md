# Fast Fall


# To do!

Gameplay Fast paced action, shoot em up X Player that moves in all directions and is limited to the screen. X Player can dash to gain speed and ignore damage for a bit X Player can shoot down to defeat enemies, but not while dashing We have a test player that fills these, i may consider sperating its functions for reuse

- Enemies spawn periodically

    Enemies either persist on the screen until killed or despawn naturally
    Some enemies can shoot at the player, or move in odd formations

- Players and enemies take damage from bullets

    Entities die after taking too much damage, this is diffrent from just despawning it.

- Damage system needs to inform all relivant nodes: - what took damage - who did the damage - how much damage was dealt - was that damage fatal

- hurtbox detects a hitbox hurtbox emits signal that parent catches and handles

- simplify damage system for now, damage tracking can be hanlded later.

    A "round" should end after a duration of time. (or maybe a quota?)

    There's a shop between rounds that lets the player buy things before moving on to the next round

    Enemies get tankier and tankier endlessly, until a cap is hit or the player dies, ending the game.

    Some enemies should only spawn in later rounds or biomes

    Some shop items should only be sold at later rounds

    Some shop items should be locked behind meta progression, such as an xp bar that builds after games.

    Results screen showing saved scores for the current game type.

    Player customization?

    Unique loadouts? or diffrent player units chosen at the start of a game?



## Credits
# XVI Template

This is a personal template project ive made public for others to use if they
wish.
This project is written wholey in GDScript, a CSharp counterpart can be found
in a diffrent tepo (XVI-Template-CSharp).
DO NOT have both this templates in the same project! They have conflicting
names, and the assets are duped between them. Having both is redundant.

## Translation importer

This class allows parsing json files for translations, rather than using
Godot's CSV system.

This also allows storing other data like arrays, that can be retrived from
the importer class. For example, you could store an array of messages, then
pick one at random. Allowing you to have diffent messages, and a diffent 
number of messages per language.

Another use case is allowing users to make their own translations, that can be
imported and used to add new languages, or change an existing one.
None of this will change your translations files, as this class NEVER writes
to a file.

## Drawing shape nodes

These arent the most useful, mostly just a carry over from some experements.
They draw simple shapes, might add more =3

## Stripped nodes

These nodes have some properties stripped from them.
This is something i like to do to prevent editing of properties that are set
via code (e.g. Setting the collision_layer and collision_mask of a CharacterBody2D).

## State machines

A node based state machine implementation, generalized for most use cases.
There is also a lite state machine for simplier non-node based use cases.
