# ————————————————————
# [TODO]
# ————————————————————
knockback and stuff doesn’t match up with position
networking sync playerlists



# ————————————————————
# [WEAPONS]
# ————————————————————
thousand island (flamethrower) G
tembo (gravity hammer) G
radiant apple (glowing apple that burns nearby enemies. light centered, throwable. when on the ground doesn’t burn or shine)
ruler/meterstick with tipper
banana peel (mine)
boomerang sniper

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

# ———————— -DONE- ————————

fix double jump on descending platform X
fix walker unable to move on conveyerPlat X
fix dash hovering on descending platform
fix walker boostPlat not boosting much, make it refuel instead
fix platforms spawning in the middle, overlapping on symmetrical gen

3 basic platforms X
boomerangSniper works to the left X
local multiplayer X
attacking X
getting hurt function X
basic symmetrical platform procedural generation X
inheritance X
walker separate jet hurtbox X
