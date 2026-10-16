# Task Board: codecrafters-redis-c

## Today
- [x] Verified project builds locally (Ninja generator; Makefiles unavailable)
- [ ] Implement Redis protocol: accept loop + PING/PONG response

## In Progress
- `src/main.c` — server skeleton: socket/bind/listen/accept, then close. No client loop yet.

## Done
- [x] Auto-registered project in Universal Brain
- [x] Submitted first stage (`2d1185a`)

## Notes
- Build: `cmake -B build -S . -G Ninja && cmake --build ./build` (vcpkg toolchain not present locally; remote uses it)
- Run: `./your_program.sh`
- Remote: https://git.codecrafters.io/90eca40c20c543ce