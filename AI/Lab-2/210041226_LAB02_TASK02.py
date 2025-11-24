from state_space_search import uninformed_search

# Task 2: Robot Cleaning Trash in Grid
maze_str = """
########
#R...T.#
#..##..#
#..#..T#
########
"""

def parse_grid(maze_str):
    grid = [list(line) for line in maze_str.strip().split('\n')]
    start = None
    trash = []
    for r in range(len(grid)):
        for c in range(len(grid[0])):
            if grid[r][c] == 'R':
                start = (r, c)
            elif grid[r][c] == 'T':
                trash.append((r, c))
    return grid, start, trash

grid, start_pos, trash_positions = parse_grid(maze_str)

def successor(state):
    pos, cleaned = state
    r, c = pos
    directions = [(-1, 0, 'up'), (1, 0, 'down'), (0, -1, 'left'), (0, 1, 'right')]
    successors = []
    for dr, dc, action in directions:
        nr, nc = r + dr, c + dc
        if 0 <= nr < len(grid) and 0 <= nc < len(grid[0]) and grid[nr][nc] != '#':
            new_cleaned = cleaned
            if (nr, nc) in trash_positions and (nr, nc) not in cleaned:
                new_cleaned = cleaned | frozenset([(nr, nc)])
            successors.append(((nr, nc), new_cleaned))
    return successors

def goal_test(state):
    pos, cleaned = state
    return len(cleaned) == len(trash_positions)

def cost_fn(current, neighbor):
    return 1

start_state = (start_pos, frozenset())

for strategy in ['bfs', 'dfs', 'ucs']:
    print(f"\n{strategy.upper()}:")
    path = uninformed_search(start_state, goal_test, successor, cost_fn, strategy)
    if path:
        actions = []
        for i in range(1, len(path)):
            prev_pos = path[i-1][0]
            curr_pos = path[i][0]
            dr = curr_pos[0] - prev_pos[0]
            dc = curr_pos[1] - prev_pos[1]
            if dr == 1:
                actions.append('down')
            elif dr == -1:
                actions.append('up')
            elif dc == 1:
                actions.append('right')
            elif dc == -1:
                actions.append('left')
        print('Actions:', ', '.join(actions))
    else:
        print("No path found")