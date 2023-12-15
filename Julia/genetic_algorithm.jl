using Random

# Quadratic function
function quadratic_function(x)
    return x^2 - 6x + 5
end

# Genetic Algorithm
function genetic_algorithm(objective_function, chromosome_length, population_size, generations)
    Random.seed!(123)  # For reproducibility, seeding random number generator

    # Initialization
    population = rand(0:1, population_size, chromosome_length)  # Initialize population with random binary strings
    best_solution = zeros(Int, chromosome_length)  # Initialize variable to store the best solution found
    best_fitness = Inf  # Initialize variable to store the fitness of the best solution

    for gen in 1:generations
        # Convert binary population to integers for evaluation
        decoded_population = [parse(Int, join(string.(chromosome), ""), base=2) for chromosome in eachrow(population)]

        # Evaluation: Calculate fitness of each individual in the population
        fitness = [objective_function(decoded) for decoded in decoded_population]

        # Selection - Tournament Selection
        parents = zeros(Int, population_size, chromosome_length)
        for i in 1:population_size
            tournament_size = 3
            tournament_indices = rand(1:population_size, tournament_size)  # Randomly select individuals for tournament
            tournament_fitness = fitness[tournament_indices]
            winner_index = tournament_indices[argmin(tournament_fitness)]  # Select the individual with the best fitness
            parents[i, :] = population[winner_index, :]  # Assign the winner as a parent
        end

        # Crossover - Single Point Crossover
        crossover_rate = 0.8
        for i in 1:2:population_size-1
            if rand() < crossover_rate
                crossover_point = rand(1:chromosome_length)  # Randomly select crossover point
                temp = copy(parents[i, crossover_point+1:end])  # Perform single-point crossover
                parents[i, crossover_point+1:end] .= parents[i+1, crossover_point+1:end]
                parents[i+1, crossover_point+1:end] .= temp
            end
        end

        # Mutation - Bit Flip Mutation
        mutation_rate = 0.01
        for i in 1:population_size
            for j in 1:chromosome_length
                if rand() < mutation_rate
                    parents[i, j] = 1 - parents[i, j]  # Flip bits with a low probability for mutation
                end
            end
        end

        population = parents  # Update the population with the new offspring

        # Update best solution found so far
        min_fitness = minimum(fitness)
        if min_fitness < best_fitness
            best_fitness = min_fitness
            best_solution = population[argmin(fitness), :]
        end
    end

    return best_solution, best_fitness
end

# Example usage
chromosome_length = 6  # Length of the binary chromosome representation
population_size = 100   # Number of individuals in the population
generations = 100       # Number of generations

# Run the genetic algorithm on the quadratic function
best_solution, best_fitness = genetic_algorithm(quadratic_function, chromosome_length, population_size, generations)

decoded_best_solution = parse(Int, join(string.(best_solution), ""), base=2)  # Decode the best solution from binary to integer
println("Best solution found: $decoded_best_solution")
println("Best fitness: $best_fitness")
