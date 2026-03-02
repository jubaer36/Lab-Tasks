# test_jssp.py

from jssp_problem import JSSPProblem


def test_instance_generation():
    print("Testing instance generation...")

    problem = JSSPProblem(N=5, M=4, seed=42)

    assert problem.N == 5
    assert problem.M == 4

    # Check matrix dimensions
    assert len(problem.processing_times) == 5
    for row in problem.processing_times:
        assert len(row) == 4

    # Check processing time bounds
    for j in range(problem.N):
        for m in range(problem.M):
            pt = problem.processing_times[j][m]
            assert 3 <= pt <= 15

    print("✓ Instance generation test passed\n")


def test_random_solution():
    print("Testing random solution generation...")

    problem = JSSPProblem(N=5, M=4, seed=42)
    solution = problem.random_solution()

    # Check all machines exist
    assert len(solution) == problem.M

    for m in range(problem.M):
        seq = solution[m]

        # Must contain all jobs exactly once
        assert len(seq) == problem.N
        assert set(seq) == set(range(problem.N))

    print("✓ Random solution test passed\n")


def test_decode_and_feasibility():
    print("Testing decode and feasibility...")

    problem = JSSPProblem(N=5, M=4, seed=42)
    solution = problem.random_solution()

    makespan, start_times = problem.decode(solution)

    # Makespan must be positive
    assert makespan > 0

    # Every operation must have a start time
    for j in range(problem.N):
        for m in range(problem.M):
            assert (j, m) in start_times

    # Check feasibility
    assert problem.check_feasibility(solution, start_times)

    print("✓ Decode and feasibility test passed\n")


def test_makespan_consistency():
    print("Testing makespan consistency...")

    problem = JSSPProblem(N=5, M=4, seed=42)
    solution = problem.random_solution()

    makespan, start_times = problem.decode(solution)

    # Manually compute last finish times
    job_finish_times = []

    for j in range(problem.N):
        last_machine = problem.M - 1
        finish = (
            start_times[(j, last_machine)]
            + problem.processing_times[j][last_machine]
        )
        job_finish_times.append(finish)

    assert makespan == max(job_finish_times)

    print("✓ Makespan consistency test passed\n")


if __name__ == "__main__":

    print("\n===== Running JSSP Tests =====\n")

    test_instance_generation()
    test_random_solution()
    test_decode_and_feasibility()
    test_makespan_consistency()

    print("All tests passed successfully ✓")