# jssp_problem.py

import random
from typing import Dict, List, Tuple


class JSSPProblem:
    def __init__(self, N=5, M=4, seed=None):
        """
        N = number of jobs
        M = number of machines
        Each job has exactly M operations (fixed machine order 0..M-1)
        Processing times randomly generated in [3, 15]
        """
        if seed is not None:
            random.seed(seed)

        self.N = N
        self.M = M

        # processing_times[j][m] = time of job j on machine m
        self.processing_times = [
            [random.randint(3, 15) for _ in range(M)]
            for _ in range(N)
        ]

    # ---------------------------------------------------------
    # Random initial solution
    # ---------------------------------------------------------
    def random_solution(self) -> Dict[int, List[int]]:
        """
        Represent solution as:
        solution[machine] = permutation of jobs
        """
        solution = {}
        for m in range(self.M):
            jobs = list(range(self.N))
            random.shuffle(jobs)
            solution[m] = jobs
        return solution

    # ---------------------------------------------------------
    # Decode permutation into full schedule
    # ---------------------------------------------------------
    def decode(self, solution: Dict[int, List[int]]) -> Tuple[int, Dict]:
        """
        Standard decoding procedure.
        Returns:
            makespan,
            start_times[(job, machine)] = start time
        """
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

    # ---------------------------------------------------------
    # Constraint checker
    # ---------------------------------------------------------
    def check_feasibility(self, solution, start_times):
        """
        Verify:
        1. Job order respected
        2. No machine overlap
        """
        # Job order constraint
        for j in range(self.N):
            for m in range(1, self.M):
                prev_finish = (
                    start_times[(j, m - 1)]
                    + self.processing_times[j][m - 1]
                )
                if start_times[(j, m)] < prev_finish:
                    return False

        # Machine overlap constraint
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