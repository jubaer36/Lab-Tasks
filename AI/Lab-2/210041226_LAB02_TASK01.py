from state_space_search import uninformed_search

# Task 1: Graph Traversal
graph = {
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': ['F'],
    'F': []
}

def successor(state):
    return graph.get(state, [])

def goal_test(state):
    return state == 'F'

def cost_fn(current, neighbor):
    return 1

start_state = 'A'

for strategy in ['bfs', 'dfs', 'ucs']:
    print(f"\n{strategy.upper()}:")
    path = uninformed_search(start_state, goal_test, successor, cost_fn, strategy)
    if path:
        print(' '.join(path))
    else:
        print("No path found")