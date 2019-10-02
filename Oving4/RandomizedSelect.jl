
function RandomizedPartition(A, p=firstindex(A), r=lastindex(A))
    i = rand(p:r)
    #print(i)
    A[r], A[i] = A[i], A[r]

    x = A[r]
    i = p-1

    for j in p:r-1
        if A[j] <= x
            i += 1
            A[i], A[j] = A[j], A[i]
        end
    end
    A[i+1], A[r] = A[r], A[i+1]
    #println(A[i+1])
    return i+1
end
A = [2, 8, 7, 1, 3, 5, 6, 4]
#RandomizedPartition(A)
#println(A)

function RandomizedSelect(A, p, r, i)

    if p == r
        return A[p]
    end
    q = RandomizedPartition(A, p, r)
    k = q-p+1

    if i == k
        return A[q]
    elseif i < k
        return RandomizedSelect(A, p, q-1, i)
    else
        return RandomizedSelect(A, q+1, r, i-k)
    end
end