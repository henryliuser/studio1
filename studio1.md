fix double jump on descending platform X
fix walker unable to move on conveyerPlat X
fix dash hovering on descending platform
fix walker boostPlat not boosting much, make it refuel instead
fix platforms spawning in the middle, overlapping on symmetrical gen

3 basic platforms X
local multiplayer X
attacking X
getting hurt function X
basic symmetrical platform procedural generation X
inheritance X
walker separate jet hurtbox X

when descending platform, trigger shape moves ahead of body shape and sprite
fix with    if velocity.y > 0 && is_on_floor(): 
					position += funcOfVelocity()

players have localNumber, globalNumber: _LOCALNUMBER determines controls_
figure out good interface for connecting multiple machines with varying numbers of players, i.e. Machine A (host) has P1, Machine B has P2 & P3, Machine C has P4.
:::: **ENetGlobal.machines **contains all the connected machines, with each machine have a list its players??? 

sync hit() fire() on multiplayer
can’t pass objects over RPC.


hitstop
healthbar crashing into ground and breaking anim 
melee attacks
platform length standardization? 
create kill plane for falling platforms, and hurts players and tosses em back up

in-game console 
shade trail
—————————————————————————————————
walker:
	make the wheel spin more noticeable for running	missing short
char2:
	walking
char3:
	split flame on short
	make long range a seperate projectile



plat variants
char variants

