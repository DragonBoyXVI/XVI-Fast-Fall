# Fast Fall

Fast Fall is a fast paced shoot em up/falling simulator!
Decent into an endless pit of danger, avoiding obstacles and
shooting enemies.
Pass the round and you can buy upgrades to better mow down the
 challenges ahead, how deep into the earth can you go?

#Tasks
Mark off the relivant to do notes when you do something

Establish the main gameplay loop
X A player that moves
X Player can shoot bulltes
X Player has health
X Player can dash
- A game over screen thats shown when player dies
- A next layer transition that happens after some citeria

# Todo!

Player Abilites
X Moves in all four directions
X Dash that gives iframes and speed boost
X Shoot primary weapon (cant shoot while dashing)
- Extra button for a special action
- Stats modifiable in the shop (speed, atk, hp, etc)
- LT: Player models/loadouts that affect gameplay

Damage System
X Hitbox component that emits a signal when hit
X Hurtbox component that emits a signal when it finds a hitbox
X Bullets should act similar to hurtboxes
- Damage should be logged for player stats. (ex. player has done x damage to y enemy type in all their play history)

Bullet System
X Bullet manager that ticks bullet objects
X Tick offsets so not every bullet is ticked per frame
X Base bullet class to allow for diffrent bullet types,
though this should mostly handle simple samey bullets.
- Advanced bullets or attacks can ignore this system and be scenes.

Health System
X Health component that can draw a health bar if enabled
- Should be able to grab hp % and tell it to scale hp
- Should be able to query death state
- Player hp in a global state?

# To do!

Gameplay Fast paced action, shoot em up

X Player that moves in all directions and is limited to the screen.
X Player can dash to gain speed and ignore damage for a bit
X Player can shoot down to defeat enemies, but not while dashing We have a test player that fills these,
i may consider sperating its functions for reuse



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
