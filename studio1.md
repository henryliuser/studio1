# ————————————————————
# [TODO]
# ————————————————————

_**Content**_
-grappling hook 
-display other weapon (so it doesn’t ‘disappear’ )
-movement core
-drop items on death
-stage patterns 
weapon angling
-POLISH
-content
…
-figure out incentive to make players fight for positioning more fiercely
		maybe just hella health pickups to make lives longer
		don’t want down time, no respawn / rounds stuff. non-stop
-make render order consistent
-clean up player code
-clean up projectile code

_**Details**_
-double damage explosion bug (2 people right next to each other)
	keep log of players per explosion? 
wallRelease should push u away
reduce boomerang end animation radius 
		also while moving backwards u can lock it cuz lerp is slow
				nvm this is only without fixFlip on turn around LOL
boomerang angles the correct way, disappears on hitting owner
-boomerang sniper can only have X number out at a time
-state while attacking melee that means u can’t turn move (only some ig)
-decide whether u can pass through enemies or not
-dedicated flip for weapons to make it smoother
-weapons flip with storedDirection instead of currentDirection
-animate weapon idle bobbing through script, leave idle effects to kethan
-getting hit interrupts attacks? super armor?
-damagetext outline color corresponds with GlobalNum
…
REFACTOR EVERYTHING WITH SIGNALS LOL

_**Networking**_
-networking sync playerlists
-spectators
-lobbies / dbfz round robin thing?
-don’t call RPCs if it’s a local game

_**Interface**_
-main menu
-character select
-multiplayer lobby (waiting room?)
-audio/video options
-controls

_**Polish**_
-chain damage text pops with each chain (Use Separate Tween EZ)
-italicize character when moving
-floating damage text (scale in and out)
-floating item pickup text 
-hitstop
-hit effects (rivals, slo-mo)
-screenshake
-camera balancing (smash)


_**Art**_
increase framerate on a lot of stuff (enerang)
…
boomer looks weird zoomed out


_**Learn**_
coroutines
Noise texture
Noise randomization for uneven surfaces/walls 
Light
Particle effects
shaders (dissolve)
Inverse Kinematics
Separately animated limbs

# ————————————————————
# [WEAPONS]
# ————————————————————
thousand island (flamethrower) G
tembo (gravity hammer) G
radiant apple (glowing apple that burns nearby enemies. light centered, throwable. when on the ground doesn’t burn or shine)

0 gravity hammer thing X
1 boomerang sniper XX
2 ruler/meterstick with tipper P
3 grenade launcher banana peel (mine)  X
thousand island flamethrower
torch ( DoT around it)

clock / time 
pets / turrets
stuns, other traps
some disarm shit
boots with trails / effects
shield reflects projectiles
darts with status effects
slingshot - basic ranged
boxing gloves - basic melee
knockback with no damage
reroll platform grenade launcher
pickups like cures 
shoot a projectile that drills through platforms it touches 
portal gun 
grappling hook  ( also vertical platforms? )


clone powerup

some short hits can deflect projectiles
can angle long upward on the ground and downward in the air 


if u hold some button then all boomerangs in play become spectral tears 
	go thru obstacles also enemies, gotta time it to do cool stuff? 

when descending platform, trigger shape moves ahead of body shape and sprite
fix with    if velocity.y > 0 && is_on_floor(): 
					position += funcOfVelocity()

players have localNumber, globalNumber: _LOCALNUMBER determines controls_
figure out good interface for connecting multiple machines with varying numbers of players, i.e. Machine A (host) has P1, Machine B has P2 & P3, Machine C has P4.
:::: **ENetGlobal.machines **contains all the connected machines, with each machine have a list its players??? 

sync hit() fire() on multiplayer
can’t pass objects over RPC.

clean up Everything
hitstop
smashbros camera balancing
healthbar crashing into ground and breaking anim 
melee attacks
platform length standardization? 
create kill plane for falling platforms, and hurts players and tosses em back up

in-game console 
shade trail
—————————————————————————————————
plat variants
char variants

# —————————  -CUT-  —————————

-boomerang collisionshape constantly spinning for nice bounces
	rotation angle of AnimatedSprite is just pointing in movement direc
-use coroutine to do cooldowns

# ———————— -DONE- ————————

fix double jump on descending platform X
fix walker unable to move on conveyerPlat X
fix dash hovering on descending platform
knockback and stuff doesn’t match up with position X
fix walker boostPlat not boosting much, make it refuel instead
fix platforms spawning in the middle, overlapping on symmetrical gen
-fix weird splitting bug on boomerang sniper + clipping at high speeds 
-ruler implementation
3 basic platforms X
boomerangSniper works to the left X
local multiplayer X
attacking X
getting hurt function X
basic symmetrical platform procedural generation X
inheritance X
walker separate jet hurtbox X
-big damage gets shader effect yo
-floating damage text
-potassium cannon
-death gravity/ragdoll
-shade getting hit resets dash
-shade only gets one midair dashreset from getHurt
-added cd on potassium cannon
-instant damage on burnPlat
-bananas stick to surfaces and move with moving platform
boomerang disappears on contact with self
-weapon pickup / ownership system
	neutral items exchange with last used item
		pressing button will still “use” the item even without ammo
-wall jump / hang