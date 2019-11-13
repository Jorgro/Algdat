using DataStructures: PriorityQueue, enqueue!, dequeue!

mutable struct Node
    name::String # used to distinguish nodes when debugging
    d::Union{Float64, Nothing} # d for distance
    p::Union{Node, Nothing} # p for predecessor
end
Node(name) = Node(name, nothing, nothing) # constructor used for naming nodes

mutable struct Graph
    V::Array{Node} # V for Vertices
    Adj::Dict{Node, Node} # Adj for Adjacency
end

function floyd_warshall(adjacency_matrix, nodes, f, g)
    # din kode her
	n = size(adjacency_matrix,1)
	D = adjacency_matrix
	for k in 1:n
    	for i in 1:n
        	for j in 1:n
            	D[i, j] = f(D[i, j], g(D[i, k], D[k, j]))
        	end
        end
    end
	return D
end

function f(a, b)
    if a < typemax(Float64) || b != 0
        return 1
    end
    return 0
end

function g(a, b)
    if a != typemax(Float64) && b != typemax(Float64)
        return 1
    end
    return 0
end


function transitive_closure(adjacency_matrix, nodes)
    # din kode her
    D = zeros(Float64, nodes, nodes)
    n = nodes
    for i in 1:n
        for j in 1:n
            if adjacency_matrix[i, j] < typemax(Float64)
                D[i, j] = 1
            end
        end
    end

    for k in 1:n
    	for i in 1:n
            for j in 1:n
                if (D[i, j] == 1 || (D[i, k]  == 1 && D[k, j] == 1 ))
                    D[i, j] = 1
                end
        	end
        end
    end
    println(D)
	return D
end

transitive_closure([0.0 3.0 8.0; Inf 0.0 Inf; Inf 4.0 0.0], 3)
#[1.0 1.0 1.0 0.0 1.0; 0.0 1.0 0.0 1.0 1.0; 0.0 1.0 1.0 0.0 0.0; 1.0 0.0 1.0 1.0 0.0; 0.0 0.0 0.0 1.0 1.0]
#[1.0 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0 1.0]
#[0.0 3.0 8.0 Inf -4.0; Inf 0.0 Inf 1.0 7.0; Inf 4.0 0.0 Inf Inf; 2.0 Inf -5.0 0.0 Inf; Inf Inf Inf 6.0 0.0], 5.