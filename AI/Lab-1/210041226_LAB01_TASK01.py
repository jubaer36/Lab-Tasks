from collections import deque
maze_str = '''
########
#S.....#
#..#...#
#..#..G#
########
'''
def parse_maze(maze_str):
    maze = []
    start = None
    goal = None
    line_index = 0
    char_index = 0
    for line in maze_str.strip().split('\n'):
        char_index = 0
        line_index += 1
        for char in line:
            char_index += 1
            if char == 'S':
                start=(line_index - 1, char_index - 1)
            elif char == 'G':
                goal=(line_index - 1, char_index - 1)
        maze.append(list(line))

    return maze, start, goal

def path_exists(maze, start, goal):
    rows, cols = len(maze), len(maze[0])
    visited = set()
    
    def dfs(r,c):
        if (r, c) == goal:
            return True
        if (r < 0 or r >= rows or c < 0 or c >= cols or 
            maze[r][c] == '#' or (r, c) in visited):
            return False
        
        visited.add((r, c))
        
        return (dfs(r-1, c) or dfs(r+1, c) or 
                dfs(r, c-1) or dfs(r, c+1))
    
    return dfs(start[0], start[1])

if __name__ == "__main__":
    print("For example maze:\n")
    maze, start, goal = parse_maze(maze_str)
    print(maze_str)
    print(f"Start: {start[0]}, {start[1]}")
    print(f"End: {goal[0]}, {goal[1]}")
    print("( Bonus ) Possible to reach goal ?: ", end=" ")
    if path_exists(maze, start, goal):
        print("Yes")
    else:
        print("No")
    
    print("\nInput your own maze (use '#' for walls, '.' for paths, 'S' for start, 'G' for goal):")
    user_maze_str = []
    print("Enter maze line by line. Type 'END' to finish:")
    while True:
        line = input()
        if line == 'END':
            break
        user_maze_str.append(line)  
    user_maze_str = '\n'.join(user_maze_str)
    maze, start, goal = parse_maze(user_maze_str)
    print("\nYour maze:")
    print(user_maze_str)
    print(f"Start: {start[0]}, {start[1]}")
    print(f"End: {goal[0]}, {goal[1]}")
    print("( Bonus ) Possible to reach goal ?: ", end=" ")
    if path_exists(maze, start, goal):
        print("Yes")
    else:
        print("No")