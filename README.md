# Fast Fall


# To do!

-- Bullet engine
- What do bullets do?
X have a position
X have collision
X disapear when hitting something or going off map
X some may need to have special properties, visuals or behaviours
X how many bullets could there be at once? Possibly over 100 at most.,.

-- Player abilities
X Shoot bullets (duh)
dash for iframes?
powerups and upgrades.,.,

-- Enemy Spawning system

-- Game over screen

-- Score screen

-- Area transition

-- Player upgrades

-- Shop?



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
