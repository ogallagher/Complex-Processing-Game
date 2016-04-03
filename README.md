# Complex
A soon-to-be 3D multiplayer game, written in Processing


# Development
- [x] Framework for 3D environment creation: NxNxN (where N=5, for now) complex of cubicles, each with 6 faces, each with randomly generated features, each with individual component blocks
- [x] Function to remove/modify extraneous (overlapping) blocks
- [x] Moving 1st person camera
- [x] Use Robot class to set mouse position to (0,0), mimicking how most 1st person games have the player look around
- [x] Move 3D camera.target.location according to the horizontal and vertical angles modified by mouse movement
- [x] Have ability to change camera orientation in all 6 cardinal directions
- [x] Edit mouse movement » player viewing function to change for each orientation
- [x] Changing time for camera orientation (so it's less confusing than simply setting the new orientation immediately)
- [x] Collision detection: block w/ camera
- [x] Gravity
- [x] Jumping
- [x] ¿Color blocks according to their appropriate cubicles to lessen disorientation a bit?
- [x] Fix jumping
- [x] Only display rooms within range N
- [ ] ¿Compass that shows where "North" (positive direction along z-axis) is?
- [x] Server: environment
- [x] Server: communication
- [x] Server: players
- [ ] Server: enemies
- [x] Server: projectiles
- [x] Client: read in environment
- [x] Client: store environment
- [ ] Client: update environment when far enough from last update point (add this if I ever want to make the complex larger)
- [x] Client: read in other players
- [x] Client: send self data (location, name, color)
- [ ] Client: read in enemies
- [ ] Server: create AI for enemies, so they move around obstacles
- [x] Client: Sound effects... : I tested playing sound and panning the playback
- [x] Client: aiming and shooting
- [x] Test single client environment transfer
- [x] Debug single client environment transfer
- [x] Client: request environment
- [x] Incorporate color in environment transfer
- [x] Update environment server to take requests from multiple sources
- [x] Update central server to perform consolidation (put multiple broadcasts of the same heading type)
- [x] Store other players as Player objects (subclass of Block with names and lamps)
- [x] Server: players: add new clients
- [x] Server: players: replace client data
- [x] Server: players: send client data
- [ ] Server: players: add clients file
- [ ] Server: players: update clients file
- [ ] Client: add score
- [x] Client: add other players list
- [x] Client: display other players
- [x] Client: collide w/ other players
- [x] Remove color from environment transfer (sending color made loading the environment WAY too slow)
- [x] Test pretending there are other players (quit and restart to see my previous self)
- [x] Test with multiple clients at once
- [x] Client: stop sending color once the player server once player server has mine recorded
- [x] Client: smooth other players' movement through 2-point interpolation (glide to next point)
- [x] Client: store previous and future locations for players
- [x] Client: update previous and future other player locations
- [x] Fix environment transfer to send packets of ~200 to each request
- [ ] Client: change mouse controls to record mouse movement?
- [x] Client: assign random colors to other players (don't send colors over internet)
- [ ] Test running multiple redundant player servers to prevent data loss? Potential problem: one server might send other player updates to a client that are outdated. Solution: have all programs run on a standardized time, and only accept updates with a time-stamp from the future.
- [ ] Client: predict fall for players if in the air?
- [x] Server: have the environment server keep a list of requested blockNumbers. Then send packets for each one at a time.
- [x] Client: if end header is not visible, read everything to the end of the data string
- [x] Debug blockNumber list and reading broken messages
- [ ] Client: other players' movement is better (smoother), but still jumps. Solution: ??... for now, just examine the program to find the problem.
- [x] Introduce standardized time.
- [x] Server: Put time stamps on sent player data
- [x] Client: Only read in other player data if time-stamp > that player's last time-stamp
- [x] Test other players' updates w/ and w/o time-stamp condition above RESULT: doesn't make a very notable difference, especially with only 2 players at a time...
- [x] Server: have projectile server load in a saved environment and check projectile-block collisions
- [x] Client: introduce protocols for projectile requests, deletions, and updates 
- [x] Server: sends out deleted projectiles as well as current ones
- [x] Client: incorporate multiple key-presses at once. Solution: have a boolean array of important keys, and update based both upon keyPressed() and keyReleased()
- [x] Server: have player server read corrupted incoming messages
- [x] Server: have projectile server read corrupted incoming messages
- [x] Client: display projectiles
- [ ] Client: detect collision with projectiles and request their deletions
- [x] Client: display collided projectiles
- [x] Client: try playing sounds for collided projectiles w/ location suggested by amplitude and Left-Right panoramic effect
- [x] Fix conversion from long to string (get rid of scientific notation). Solution: place each value at positions n, convert round((time % (10^n)) / (10^(n-1))) to characters, and concatenate them into a string
- [ ] Server: projectile server moves projectiles, then checks for block collisions, then sends their new locations
- [ ] Server: use above change to make projectiles move much faster
- [ ] Client: only keep track of initial location and latest location of each projectile, tracking their paths of movement. Draw these paths of movement as fading streaks
- [ ] ¿Client: add projectile flying sound in addition to impact sound?
- [ ] Client: collision animation for projectiles
