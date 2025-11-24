# Ring Topology Network Explanation

## Basic Network Structure
```
    N0 -------- N3
    |           |
    |           |
    N1 ------- N2
```

Each node is connected to exactly two other nodes, forming a ring/circle.

## IP Address Assignment
- Link N0-N1: 192.6.26.0/24 (interfaces[0])
- Link N1-N2: 192.6.26.0/24 (interfaces[1])
- Link N2-N3: 192.6.26.0/24 (interfaces[2])
- Link N3-N0: 192.6.26.0/24 (interfaces[3])

## Server-Client Iterations

### Iteration 1: Server Node 0
```
    N0(S) ---- N3(C)
    |           |
    |           |
    N1(C) ---- N2(C)
```
- N0 is server (S)
- Communication can go either clockwise or counter-clockwise
- Shortest path routing determines direction
- For N1: Direct connection through interfaces[0]
- For N2: Route through N1 or N3 (two possible paths)
- For N3: Direct connection through interfaces[3]

### Iteration 2: Server Node 1
```
    N0(C) ---- N3(C)
    |           |
    |           |
    N1(S) ---- N2(C)
```
- N1 is server
- For N0: Direct connection through interfaces[0]
- For N2: Direct connection through interfaces[1]
- For N3: Route through N0 or N2

### Iteration 3: Server Node 2
```
    N0(C) ---- N3(C)
    |           |
    |           |
    N1(C) ---- N2(S)
```
- N2 is server
- For N1: Direct connection through interfaces[1]
- For N3: Direct connection through interfaces[2]
- For N0: Route through N1 or N3

### Iteration 4: Server Node 3
```
    N0(C) ---- N3(S)
    |           |
    |           |
    N1(C) ---- N2(C)
```
- N3 is server
- For N0: Direct connection through interfaces[3]
- For N2: Direct connection through interfaces[2]
- For N1: Route through N0 or N2

## Routing Considerations
```cpp
// Pseudo-code for determining interface index
if (abs(serverNode - clientNode) == 1 || 
    abs(serverNode - clientNode) == 3) {
    // Direct connection exists
    interfaceIndex = min(serverNode, clientNode);
    useFirstAddress = (serverNode > clientNode);
} else {
    // Need to route through intermediate node
    // Choose shortest path (clockwise or counter-clockwise)
    interfaceIndex = calculateShortestPath(serverNode, clientNode);
    useFirstAddress = determineAddressOrder(serverNode, clientNode);
}
```

## Key Differences from Star Topology
1. Multiple possible paths between nodes
2. No central routing node
3. Each node has exactly two interfaces
4. Equal network distance between adjacent nodes
5. More complex routing decisions required

## Timing Considerations
- Server starts at 1.0 seconds
- Clients start sequentially based on their position relative to server
- Consider propagation delays in both directions around the ring
- All applications stop at 10.0 seconds

## Performance Characteristics
- Maximum hop count = 2 (half the ring)
- Equal bandwidth on all links
- Redundant paths provide fault tolerance
- Network load is more evenly distributed
