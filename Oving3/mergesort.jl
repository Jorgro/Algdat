

function MergeArray(A, p, q, r)
    println(A)

    n_1 = q-p+1
    n_2 = r - q

    L = []
    R = []

    sizehint!(L, n_1 + 1)
    sizehint!(R, n_2 + 1)

    for i in 1:n_1
        push!(L, A[p+i-1])
    end

    for j in 1:n_2
        push!(R, A[q+j])
    end

    push!(L, 20000)
    push!(R, 20000)

    i = 1
    j = 1
    for k in p:r

        if L[i] <= R[j]
            A[k] = L[i]
            i += 1
        else
            A[k] = R[j]
            j += 1
        end

    end
end

function MergeSort!(A, p, r)
    if p < r
        q = div(p+r, 2)
        MergeSort!(A, p, q)
        MergeSort!(A, q+1, r)
        MergeArray(A, p, q, r)
    end
    
    return A
end




A = [4, 1, 1, 2, 9, 7, 3]
MergeSort!(A, 1, length(A))
println(A)
B = [1 2; 4 6; 2 1]
#= 
println(B[1, 3])
7. problemsolving
8. Disciplin 
11. Not really 
 =#