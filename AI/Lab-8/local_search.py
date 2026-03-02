# local_search.py

import random
import copy
from jssp_problem import JSSPProblem


class LocalSearch:
    def __init__(self, problem: JSSPProblem):
        self.problem = problem

        self.max_no_improve = 80
        self.max_restarts = 4
        self.bad_move_limit = 30
        self.bad_move_window = 0

        self.block_min = 2
        self.block_max = 3
        self.restart_count = 0

    # ---------------------------------------------------------
    # Destroy operator
    # ---------------------------------------------------------
    def destroy(self, solution):
        new_sol = copy.deepcopy(solution)

        machines = [random.randint(0, self.problem.M - 1)]

        # If neighborhood increased
        if self.restart_count >= 4:
            machines = random.sample(range(self.problem.M), 2)

        for m in machines:
            seq = new_sol[m]
            if len(seq) < self.block_min:
                continue

            block_size = random.randint(self.block_min, self.block_max)
            start = random.randint(0, len(seq) - block_size)

            block = seq[start:start + block_size]
            random.shuffle(block)
            seq[start:start + block_size] = block

        return new_sol

    # ---------------------------------------------------------
    # Main search loop
    # ---------------------------------------------------------
    def run(self, max_iterations=1000):
        current = self.problem.random_solution()
        best = copy.deepcopy(current)

        best_cost, _ = self.problem.decode(best)
        current_cost = best_cost

        no_improve_counter = 0

        for iteration in range(max_iterations):

            candidate = self.destroy(current)
            candidate_cost, _ = self.problem.decode(candidate)

            if candidate_cost < best_cost:
                best = copy.deepcopy(candidate)
                best_cost = candidate_cost
                current = candidate
                current_cost = candidate_cost
                no_improve_counter = 0
                self.bad_move_window = 0

            else:
                # Allow bad move up to 10% worse
                if (
                    candidate_cost <= 1.10 * best_cost
                    and self.bad_move_window < self.bad_move_limit
                ):
                    current = candidate
                    current_cost = candidate_cost
                    self.bad_move_window += 1
                else:
                    self.bad_move_window = 0

                no_improve_counter += 1

            # Random restart
            if no_improve_counter >= self.max_no_improve:
                self.restart_count += 1
                no_improve_counter = 0

                current = self.problem.random_solution()
                current_cost, _ = self.problem.decode(current)

                if self.restart_count >= 4:
                    self.block_min = 3
                    self.block_max = 5

        return best, best_cost


if __name__ == "__main__":
    problem = JSSPProblem(N=5, M=4, seed=42)
    ls = LocalSearch(problem)

    best_solution, best_cost = ls.run(max_iterations=2000)

    print("Processing Times:")
    for j in range(problem.N):
        print(f"Job {j}: {problem.processing_times[j]}")

    print("\nBest Makespan:", best_cost)