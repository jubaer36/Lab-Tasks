# jssp_problem.py

import random
from typing import Dict, List, Tuple


class JSSPProblem:
    def __init__(self, N=5, M=4, seed=None):
        if seed is not None:
            random.seed(seed)

        self.N = N
        self.M = M

        self.processing_times = [
            [random.randint(3, 15) for _ in range(M)]
            for _ in range(N)
        ]

    
    def random_solution(self) -> Dict[int, List[int]]:
        solution = {}
        for m in range(self.M):
            jobs = list(range(self.N))
            random.shuffle(jobs)
            solution[m] = jobs
        return solution

    
    def decode(self, solution: Dict[int, List[int]]) -> Tuple[int, Dict]:
        job_ready = [0] * self.N
        machine_ready = [0] * self.M
        start_times = {}

        for m in range(self.M):
            for job in solution[m]:
                start = max(job_ready[job], machine_ready[m])
                start_times[(job, m)] = start

                finish = start + self.processing_times[job][m]

                job_ready[job] = finish
                machine_ready[m] = finish

        makespan = max(job_ready)
        return makespan, start_times

    
    def check_feasibility(self, solution, start_times):
        for j in range(self.N):
            for m in range(1, self.M):
                prev_finish = (
                    start_times[(j, m - 1)]
                    + self.processing_times[j][m - 1]
                )
                if start_times[(j, m)] < prev_finish:
                    return False

        for m in range(self.M):
            intervals = []
            for j in solution[m]:
                s = start_times[(j, m)]
                f = s + self.processing_times[j][m]
                intervals.append((s, f))

            intervals.sort()
            for i in range(1, len(intervals)):
                if intervals[i][0] < intervals[i - 1][1]:
                    return False

        return True