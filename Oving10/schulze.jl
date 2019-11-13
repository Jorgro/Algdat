preference_matrix = [0 1 2; 2 0 2; 1 1 0]

function update!(u, v, w)
    # din kode her
    if min(u.d, w[(u, v)]) > v.d
        v.d = min(u.d, w[(u, v)])
        v.p = u
    end
end

function f(a, b)
    if a >= b
        return a
    end
    return b
end

function g(a, b)
    if a <= b
        return a
    end
    return b
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

function schulze_ranking(preference_matrix, candidates)
    n = candidates
    # 1
	for i = 1:n
        for j = i+1:n
            if preference_matrix[i, j] < preference_matrix[j, i]
                preference_matrix[i, j] = 0
            else
                preference_matrix[j, i] = 0
            end
        end
    end

    println(preference_matrix)

    floyd = floyd_warshall(preference_matrix, n, f, g)
    println(floyd)

    for i = 1:n
        for j = i+1:n
            if floyd[i, j] < floyd[j, i]
                floyd[i, j] = 0
            else
                floyd[j, i] = 0
            end
        end
    end

    #count winners
    #sortere radene med hensyn til antall tall > 0. Den med flest tall > 0 er den første osv...
    winners = zeros(candidates)
    for i = 1:n
        sum = 0
        for j=1:n
            if floyd[i, j] > 0
                sum += 1
            end
        end
        winners[i] = sum
    end

    with_index = []

    for i in 1:n
        push!(with_index, (winners[i], i))
    end
    sort!(with_index)
    reverse!(with_index)

    ranking = ""
    streng = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for i in 1:n
        ranking = string(ranking, "", string(streng[with_index[i][2]]))
    end

    println(ranking)
    return ranking
    # 2
    # 3
end
#[0 20 20 17; 19 0 19 17; 19 21 0 17; 18 18 18 0]
#[0 11 20 14; 19 0 9 12; 10 21 0 17; 16 18 13 0], 4.
schulze_ranking([0 11 20 14; 19 0 9 12; 10 21 0 17; 16 18 13 0], 4)


