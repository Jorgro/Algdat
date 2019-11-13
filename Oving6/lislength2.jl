function CeilIndex(A, l, r, key)

    while (r - l > 1)

        m = l + div((r - l),2)
        if (A[m] >= key)
            r = m
        else
            l = m
        end
    end

    return r
end

function LongestIncreasingSubsequenceLength(A, size = length(A))

    # Add boundary case,
    # when array size is one

    tailTable = zeros(size+1)

    tailTable[1] = A[1]
    len = 1
    for i = 2:size

        if (A[i] < tailTable[1])
            # new smallest value
            tailTable[1] = A[i]

        elseif (A[i] > tailTable[len])

            # A[i] wants to extend
            # largest subsequence
            tailTable[len+1] = A[i]
            len += 1

        else
            # A[i] wants to be current
            # end candidate of an existing
            # subsequence. It will replace
            # ceil value in tailTable
            tailTable[CeilIndex(tailTable, 0, len, A[i])] = A[i]
        end
    end


    return len
end


# Driver program to
# test above function

A = [2,1,4,3,6,5, 7, 8, 19, 9, 10, 20, 21, 44, 34, 36, 289, 391, 398, 297, 298]

println("Length of Longest Increasing Subsequence is ",
       LongestIncreasingSubsequenceLength(A))


function lislength(s)
mls = zeros(Int, size(s))
mls[1] = 1
for i = 2:length(s)
    longest = 1
    for j = i:-1:1
        #println(j)
        if mls[j] >= longest
            if s[i] > s[j]
                longest = mls[j] + 1
            end
        end
    end
    mls[i] = longest

end
#println(mls)
return maximum(mls), mls # Returnerer det største tallet i listen
end
println(lislength(A))
