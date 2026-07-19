# Fast Fall
Fast Fall is a rougelike shoot em up game in which you play as a 
special splelunker op falling down a massive pit.
Survive massive waves of enemies, buy/earn upgrades, and progress deeper
into the pit; all while using an array of specialized weaponry!
 How high of a score can you get before perishing?

# To do!

Gameplay
Fast paced action, shoot em up
X Player that moves in all directions and is limited to the screen.
X Player can dash to gain speed and ignore damage for a bit
X Player can shoot down to defeat enemies, but not while dashing
We have a test player that fills these, i may consider sperating its
functions for reuse

X Enemies spawn periodically
- Enemies either persist on the screen until killed or despawn naturally
- Some enemies can shoot at the player, or move in odd formations

- Players and enemies take damage from bullets
- Entities die after taking too much damage, this is diffrent from
just despawning it.

- Damage system needs to inform all relivant nodes:
	- what took damage
	- who did the damage
	- how much damage was dealt
	- was that damage fatal

hurtbox detects a hitbox
hurtbox emits signal that parent or other node catches
parent node sends a damage event signal over the radio
hitbox owner recives the radio event and handles it

simplify damage system for now, damage tracking can be hanlded later.


- A "round" should end after a duration of time. (or maybe a quota?)
- There's a shop between rounds that lets the player buy things before
moving on to the next round

- Enemies get tankier and tankier endlessly, until a cap is hit or the player
dies, ending the game.
- Some enemies should only spawn in later rounds or biomes
- Some shop items should only be sold at later rounds
- Some shop items should be locked behind meta progression, such as an xp bar
that builds after games.

- Results screen showing saved scores for the current game type.

- Player customization?
- Unique loadouts? or diffrent player units chosen at the start of a game?













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
