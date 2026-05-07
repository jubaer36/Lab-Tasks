
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

    
    def destroy(self, solution):
        new_sol = copy.deepcopy(solution)



        
        return new_sol

    
    def run(self, max_iterations=1000):
        current = self.problem.random_solution()
        

        return best_cost


if __name__ == "__main__":
    problem = JSSPProblem(N=5, M=4, seed=42)
    ls = LocalSearch(problem)

    best_solution, best_cost = ls.run(max_iterations=2000)

    print("Processing Times:")
    for j in range(problem.N):
        print(f"Job {j}: {problem.processing_times[j]}")

    