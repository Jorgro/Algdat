
function BinarySearch(A, val, p = 1, r = length(A))

    if p <= r
 
        q = div(p+r, 2)

        if val == A[q]
            return q
        elseif val > A[q]
            return BinarySearch(A, val, q+1, r)
        else
            return BinarySearch(A, val, p, q-1)
        end
    
    end

    return -1



    
end

A = [1, 2, 3, 4]
println(BinarySearch(A, 4))