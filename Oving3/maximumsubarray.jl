
function find_max_crossing_subarray(A, low, mid, high)

    left_sum = -200000
    sum = 0
    max_left = Nothing
    max_right = Nothing 

    for i in mid:-1:low
        sum += A[i]
        if sum > left_sum
            left_sum = sum
            max_left = i 
        end
    end

    right_sum = -200000
    sum = 0

    for j in mid+1:high
        sum += A[j]

        if sum > right_sum
            right_sum = sum
            max_right = j
        end
    end

    return (max_left, max_right, left_sum+right_sum)
        
    
end

function find_maximum_subarray(A, low, high)

    if low == high
        return (low, high, A[low])
    else
        mid = div(high + low, 2)
        (left_low, left_high, left_sum) = find_maximum_subarray(A, low, mid)
        (right_low, right_high, right_sum) = find_maximum_subarray(A, mid+1, high)
        (cross_low, cross_high, cross_sum) = find_max_crossing_subarray(A, low, mid, high)

        if left_sum > right_sum && left_sum > cross_sum
            return (left_low, left_high, left_sum)
        elseif right_sum > left_sum && right_sum > cross_sum
            return (right_low, right_high, right_sum)
        else
            return (cross_low, cross_high, cross_sum)
        end
    end

    
end
A = [-1, 2, 3, -20, 1, 8, -8, 99, 2, 200, 2000]
println(find_maximum_subarray(A, 1, length(A)))

function linear_maximum_subarray(A, low=1, high=length(A))

    max_element = -2000000 #Neg inf. 

    maxSoFar = 0
    maxEndingHere = 0

    left = 0
    right = 0
    left_o = 0

    for i in low:high
        maxEndingHere += A[i]

        if A[i] > max_element
            max_element = A[i]
        end

        if maxEndingHere < 0
            maxEndingHere = 0
            left = i + 1
        end

        
        if maxSoFar < maxEndingHere
            maxSoFar = maxEndingHere
            right = i
            left_o = left
            
        end

    end
    if left_o == 0
        return max_element
    end

    return (left_o, right, maxSoFar)
    
end

A = [-25, -583, -975, 1]
println(linear_maximum_subarray(A))