#x og y er to sorterte arrays, coordinate angir koordinat akse
function mergearrays(A, p, q, r, coordinate)
	n_1 = q-p+1
    n_2 = r - q

    L = []
    R = []

    #sizehint!(L, n_1 + 1)
    #sizehint!(R, n_2 + 1)

    for i in 1:n_1
        push!(L, A[p+i-1, :])
    end

    for j in 1:n_2
        push!(R, A[q+j, :])
    end

    push!(L, [20000, 20000])
    push!(R, [20000, 20000])

    i = 1
    j = 1
    for k in p:r
        if L[i][coordinate] <= R[j][coordinate]
            A[k, 1] = L[i][1]
            A[k, 2] = L[i][2]
            i += 1
        else
            A[k, 1] = R[j][1]
            A[k, 2] = R[j][2]
            j += 1
        end

    end
end

#x usortert array, coordinate angir koordinat akse vi skal sortere langs
function mergesort(A, coordinate, p=1, r=div(length(A), 2))
	if p < r
        q = div(p+r, 2)
        mergesort(A, coordinate, p, q)
        mergesort(A, coordinate, q+1, r)
        mergearrays(A, p, q, r, coordinate)
    end
    
    return A
end
A = [1 2; 4 5; 2 1]
b = A[1, :]
println(mergesort(A, 2))