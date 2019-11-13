


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