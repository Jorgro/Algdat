function partition(A, p, r)
    x = A[r]
    i = p - 1

    for j in p:r-1
        if A[j] <= x
            i += 1
            A[i], A[j] = A[j], A[i]
        end
    end
    A[i+1], A[r] = A[r], A[i+1]
    return i+1
end

function quicksort(A, p=1, r=length(A))
    if p < r
        q = partition(A, p, r)
        quicksort(A, p, q-1)
        quicksort(A, q+1, r)
    end
end

A = [8, 9, 2, 1]
quicksort(A)
println(A)