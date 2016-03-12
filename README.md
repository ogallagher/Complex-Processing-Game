# Complex
A soon-to-be 3D multiplayer game, written wholly in Processing


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
- [ ] Server: players
- [ ] Server: enemies
- [ ] Server: projectiles
- [x] Client: read in environment
- [x] Client: store environment
- [ ] Client: update environment when far enough from last update point (add this if I ever want to make the complex larger)
- [ ] Client: read in other players
- [ ] Client: send self data (location, name, color)
- [ ] Client: read in enemies
- [ ] Server: create AI for enemies, so they move around obstacles
- [ ] Client: ¿Sound effects... how much will this slow the game down, and is it worth the effort?
- [ ] Client: aiming and shooting
- [x] Test single client environment transfer
- [x] Debug single client environment transfer
- [x] Client: request environment
- [ ] Add color to environment transfer
- [ ] Update environment server to take requests from multiple sources
- [ ] Update central server to perform consolidation (put multiple broadcasts of the same heading type under a single heading)
- [ ] Store other players as Player objects (subclass of Block with names and lamps)
