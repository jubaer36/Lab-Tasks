
from jssp_problem import JSSPProblem


def test_instance_generation():
    print("Testing instance generation")

    problem = JSSPProblem(N=5, M=4, seed=42)

    print("\nMatrix dimensions:")

    for i, row in enumerate(problem.processing_times):
        print(f"Row {i} length: Expected: 4, Actual: {len(row)}")

    print("\nProcessing times (should be between 3 and 15):")
    for j in range(problem.N):
        for m in range(problem.M):
            print(f"Job {j}, Machine {m}: {problem.processing_times[j][m]}")



def test_random_solution():
    print("Testing random solution generation")

    problem = JSSPProblem(N=5, M=4, seed=42)
    solution = problem.random_solution()

    print("\nNumber of machines:")
    print("Expected:", problem.M)
    print("Actual:", len(solution))

    for m in range(problem.M):
        seq = solution[m]
        print(f"\nMachine {m} sequence: {seq}")
        

    print("\nRandom solution test completed\n")


def test_decode_and_feasibility():
    print("Testing decode and feasibility...")

    problem = JSSPProblem(N=5, M=4, seed=42)
    solution = problem.random_solution()

    makespan, start_times = problem.decode(solution)

    print("\nMakespan:")
    print("Actual:", makespan)

    print("\nStart times for all operations:")
    for j in range(problem.N):
        for m in range(problem.M):
            print(f"Job {j}, Machine {m}: {start_times[(j, m)]}")

    print("\nFeasibility check:")
    print(problem.check_feasibility(solution, start_times))



def test_makespan_consistency():
    print("Testing makespan consistency...")

    problem = JSSPProblem(N=5, M=4, seed=42)
    solution = problem.random_solution()

    makespan, start_times = problem.decode(solution)

    job_finish_times = []
    for j in range(problem.N):
        last_machine = problem.M - 1
        finish = start_times[(j, last_machine)] + problem.processing_times[j][last_machine]
        job_finish_times.append(finish)

    computed_max = max(job_finish_times)

    print("\nMakespan consistency check:")
    print("Makespan from decode:", makespan)
    print("Manually computed max finish time:", computed_max)

    print("\nMakespan consistency test completed\n")


if __name__ == "__main__":
    print("\nRunning JSSP Tests")

    test_instance_generation()
    test_random_solution()
    test_decode_and_feasibility()
    test_makespan_consistency()

    print("tests completed")