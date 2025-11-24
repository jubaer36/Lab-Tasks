# Tree Topology Network Explanation

## Basic Network Structure
```
           N0
          /  \
         /    \
        N1    N2
       /  \  /  \
      N3  N4 N5  N6
```
A binary tree structure where each parent node connects to two child nodes.

## IP Address Assignment
- Link N0-N1: 10.1.1.0/24 (interfaces[0])
- Link N0-N2: 10.1.2.0/24 (interfaces[1])
- Link N1-N3: 10.1.3.0/24 (interfaces[2])
- Link N1-N4: 10.1.4.0/24 (interfaces[3])
- Link N2-N5: 10.1.5.0/24 (interfaces[4])
- Link N2-N6: 10.1.6.0/24 (interfaces[5])

## Node Relationships
```cpp
// Helper functions for tree relationships
parentIndex = (nodeIndex - 1) / 2
leftChildIndex = 2 * nodeIndex + 1
rightChildIndex = 2 * nodeIndex + 2
isLeafNode = leftChildIndex >= totalNodes
isRootNode = nodeIndex == 0
```

## Server-Client Iterations

### Iteration 1: Root Node (N0) as Server
```
           N0(S)
          /    \
         /      \
      N1(C)    N2(C)
     /    \    /    \
  N3(C) N4(C) N5(C) N6(C)
```
- Direct connections to level 1 nodes (N1, N2)
- Two-hop connections to leaf nodes
- Path: Root → Parent → Leaf

### Iteration 2: Level 1 Node (N1) as Server
```
           N0(C)
          /    \
         /      \
      N1(S)    N2(C)
     /    \    /    \
  N3(C) N4(C) N5(C) N6(C)
```
- Upward connection to parent (N0)
- Direct connections to children (N3, N4)
- Multi-hop to other branches through root

### Iteration 3: Leaf Node (N3) as Server
```
           N0(C)
          /    \
         /      \
      N1(C)    N2(C)
     /    \    /    \
  N3(S) N4(C) N5(C) N6(C)
```
- Only upward communication initially
- All other communications go through parent nodes
- Maximum path length = height of tree × 2

## Routing Logic
```cpp
// Pseudo-code for determining route
if (isDirectParentChild(serverNode, clientNode)) {
    // Direct connection exists
    interfaceIndex = calculateDirectInterface(serverNode, clientNode);
    useFirstAddress = isParent(serverNode, clientNode);
} else {
    // Find lowest common ancestor (LCA)
    int lca = findLowestCommonAncestor(serverNode, clientNode);
    // Route through path: server → LCA → client
    interfaceIndex = getFirstHopInterface(serverNode, lca, clientNode);
    useFirstAddress = determineAddressOrder(serverNode, clientNode);
}
```

## Key Characteristics
1. Hierarchical structure
2. Single path between any two nodes
3. Predictable routing through parent nodes
4. Variable node depths
5. Scalable design

## Communication Patterns
1. **Vertical Communication**
   - Parent ↔ Child: Direct connection
   - Example: N0 ↔ N1 (1 hop)

2. **Horizontal Communication**
   - Sibling ↔ Sibling: Through parent
   - Example: N3 ↔ N4 (2 hops through N1)

3. **Cross-Branch Communication**
   - Leaf ↔ Leaf in different branches: Through common ancestor
   - Example: N3 ↔ N5 (4 hops: N3→N1→N0→N2→N5)

## Performance Considerations
- Maximum path length = 2 × (tree height)
- Bottleneck at root node
- Higher latency for cross-branch communication
- Parent nodes handle more traffic than leaf nodes

## Timing Strategy
- Root node (level 0): Start time = 1.0s
- Level 1 nodes: Start time = 2.0s + node_offset
- Level 2 nodes: Start time = 4.0s + node_offset
- Stop time = Start time + communication_window

## Addressing Strategy
```
Level 0: 10.1.x.1
Level 1: 10.1.x.2
Level 2: 10.1.x.3
Where x varies by connection
```
