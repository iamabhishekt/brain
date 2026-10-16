# CodeCrafters Redis — Learning Guide

Your `src/main.c` currently does: socket → bind → listen → accept once → close.
The challenge turns this into a real Redis server. Here is the map.

---

## 1. The accept loop (Stage: Bind to a port)

You already have this. The bug is that `accept()` is called **once** and the program exits.

Fix: wrap it in a loop.

```c
while (1) {
    int client_fd = accept(server_fd, ...);
    // handle client
}
```

## 2. RESP — the Redis Serialization Protocol

This is the core skill. Redis speaks a text protocol over TCP.

A client sends:
```
*3\r\n$3\r\nSET\r\n$3\r\nfoo\r\n$3\r\nbar\r\n
```

Reading it back:
- `*3` → array of 3 elements
- `$3` → bulk string, length 3
- `SET` → the string "SET"

**Your first task:** read bytes from `client_fd` with `read()`, parse this structure, extract the command name, and reply.

## 3. Reply format

Server → client:
- Simple string: `+OK\r\n`
- Error: `-ERR unknown command\r\n`
- Integer: `:1\r\n`
- Bulk string: `$5\r\nhello\r\n`
- Null: `$-1\r\n`
- Array: `*2\r\n$3\r\nfoo\r\n$3\r\nbar\r\n`

PING test: client sends `*1\r\n$4\r\nPING\r\n`, expects `+PONG\r\n`.

## 4. Reading without blocking forever

`read()` blocks until data arrives. That's fine for one client. When you hit the "concurrent clients" stage you'll need `select()`/`poll()` or threads. Start simple.

## 5. Command dispatch

```c
if (strcmp(cmd, "PING") == 0) {
    write(client_fd, "+PONG\r\n", 7);
} else if (strcmp(cmd, "ECHO") == 0) {
    // echo back the argument
} else if (strcmp(cmd, "SET") == 0) {
    store[key] = value;
    write(client_fd, "+OK\r\n", 5);
} else if (strcmp(cmd, "GET") == 0) {
    if (store.find(key) != store.end())
        // reply $len\r\nvalue\r\n
    else
        // reply $-1\r\n  (null)
}
```

## 6. Data storage

Use a hash table. In C23 with no external deps you can:
- Write a simple chained-hashmap yourself (good exercise)
- Or use `uthash.h` (single header, MIT) — but check your challenge rules allow it

## 7. Stage order (from the challenge page)

1. Bind to a port — done
2. Respond to PING
3. Respond to multiple PINGs
4. Handle concurrent clients
5. ECHO
6. SET & GET
7. Expiry
8. Lists (LPUSH/RPUSH/LLEN/LINDEX/LREM/LPOP/RPOP)
9. Streams (XADD/XREAD/TYPE)
10. Transactions (MULTI/EXEC/DISCARD/INCR)
11. Replication + RDB + AOF

## 8. How to test yourself

Start the server, then in another terminal:
```sh
redis-cli -p 6379 ping
# or
exec 3<>/dev/tcp/localhost/6379; printf '*1\r\n$4\r\nPING\r\n' >&3; cat <&3
```

## 9. Build command

```sh
cmake -B build -S . -G Ninja && cmake --build ./build
```
(No vcpkg locally; remote buildpack uses it. Makefiles aren't available — use Ninja.)

## 10. Submit

```sh
codecrafters submit
```

---

**Your first concrete step:** change `accept()` into a loop, `read()` from the client, and reply `+PONG\r\n` to any PING. That passes stage 2.

Want me to walk through writing that first piece with you, or do you want to try and ask when you're stuck?