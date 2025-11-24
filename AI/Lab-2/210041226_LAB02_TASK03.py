
def heuristic_task1(state, heuristic_map):
    
    return heuristic_map.get(state, float('inf'))


def heuristic_task2(state, trash_positions):
    
    current_pos, cleaned_trash = state
    r, c = current_pos
    
    uncleaned = [t for t in trash_positions if t not in cleaned_trash]
    
    if not uncleaned:
        return 0
    
    min_dist = float('inf')
    for tr, tc in uncleaned:
        dist = abs(r - tr) + abs(c - tc)
        if dist < min_dist:
            min_dist = dist
            
    return min_dist


if __name__ == "__main__":
    #For first task
    print("--- Task 1 Heuristic ---")
    h_map_task1 = {
        'A': 2, 'B': 2, 'C': 1, 'D': float('inf'), 'E': 1, 'F': 0
    }
    
    states_t1 = ['A', 'B', 'C', 'D', 'E', 'F']
    for s in states_t1:
        print(f"h({s}) = {heuristic_task1(s, h_map_task1)}")

    
    #For second task
    
    print("\n--- Task 2 Heuristic ---")
    trash_locs = [(1, 5), (3, 6)]
    
    # Case 1: Start position, no trash cleaned
    start_state = ((1, 1), frozenset())
    print(f"Start State {start_state[0]}, Cleaned {len(start_state[1])}/{len(trash_locs)}")
    print(f"Heuristic: {heuristic_task2(start_state, trash_locs)}")
    
    # Case 2: Moved closer to first trash
    near_trash_state = ((1, 4), frozenset())
    print(f"Near Trash {near_trash_state[0]}, Cleaned {len(near_trash_state[1])}/{len(trash_locs)}")
    print(f"Heuristic: {heuristic_task2(near_trash_state, trash_locs)}")
    
    # Case 3: Cleaned first trash
    cleaned_one_state = ((1, 5), frozenset([(1, 5)]))
    print(f"At Trash 1 {cleaned_one_state[0]}, Cleaned {len(cleaned_one_state[1])}/{len(trash_locs)}")
    print(f"Heuristic: {heuristic_task2(cleaned_one_state, trash_locs)}")
    
    # Case 4: All cleaned
    all_cleaned_state = ((3, 6), frozenset([(1, 5), (3, 6)]))
    print(f"All Cleaned {all_cleaned_state[0]}, Cleaned {len(all_cleaned_state[1])}/{len(trash_locs)}")
    print(f"Heuristic: {heuristic_task2(all_cleaned_state, trash_locs)}")
