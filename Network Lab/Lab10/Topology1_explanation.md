# Network Topology Explanation

## Basic Network Structure

```
         N1
         |
         |
    N2---N0---N3
```

Node 0 (N0) is the central node connected to all other nodes.

## IP Address Assignment

- Link N0-N1: 192.6.26.0/24 (interfaces[0])
- Link N0-N2: 192.6.26.0/24 (interfaces[1])
- Link N0-N3: 192.6.26.0/24 (interfaces[2])

## Server-Client Iterations

### Iteration 1: Server Node 0 (Central Node)

```
         N1(C)
         |
         |
    N2(C)─N0(S)─N3(C)
```

- N0 is server (S)
- N1, N2, N3 are clients (C)
- Direct connections used
- interfaceIndex = clientNode - 1
- useFirstAddress = false (use client-side IP)

### Iteration 2: Server Node 1

```
         N1(S)
         |
         |
    N2(C)─N0(C)─N3(C)
```

- N1 is server
- All communication goes through N0
- For N0: interfaceIndex = 0, useFirstAddress = true
- For N2,N3: interfaceIndex = 0, useFirstAddress = true

### Iteration 3: Server Node 2

```
         N1(C)
         |
         |
    N2(S)─N0(C)─N3(C)
```

- N2 is server
- Similar routing through N0
- For N0: interfaceIndex = 1, useFirstAddress = true
- For N1,N3: interfaceIndex = 1, useFirstAddress = true

### Iteration 4: Server Node 3

```
         N1(C)
         |
         |
    N2(C)─N0(C)─N3(S)
```

- N3 is server
- Similar routing through N0
- For N0: interfaceIndex = 2, useFirstAddress = true
- For N1,N2: interfaceIndex = 2, useFirstAddress = true

## Interface Index Logic

```cpp
if (serverNode == 0) {
    interfaceIndex = clientNode - 1;  // Direct connection from center
    useFirstAddress = false;          // Use client's address
}
else if (clientNode == 0) {
    interfaceIndex = serverNode - 1;  // Direct connection to server
    useFirstAddress = true;           // Use server's address
}
else {
    interfaceIndex = serverNode - 1;  // Route through center node
    useFirstAddress = true;           // Use server's address
}
```

## Timing

- Server starts at 1.0 seconds
- Each client starts at (2.0 + clientNode) seconds to avoid conflicts
- All applications stop at 10.0 seconds
