
module BinarySearch export binaryintervalsearch
    function binaryintervalsearch(A, delta, coordinate)


        if (length(A)/2)%2 == 0
            q_1 = div(1+div(length(A), 2), 2)
            q_2 = q_1 +1 
            median = (A[q_1, coordinate] + A[q_2, coordinate])/2
            #println(median)
            return (binarySearchLeft(A, delta, coordinate, median, 1, q_1), 
            binarySearchRight(A, delta, coordinate, median, q_2, size(A)[1]))

        else
            q = div(1+div(length(A), 2), 2)
            median = A[q, coordinate]
            #println(median)
            return (binarySearchLeft(A, delta, coordinate, median, 1, q), 
            binarySearchRight(A, delta, coordinate, median, q, size(A)[1]))
        end
        
    end

    function binarySearchLeft(A, delta, coordinate, median, p, r)
        if p <= r

            q = div(p+r, 2)

            if A[q, coordinate] >= median - delta

                if q == 1
                    return q
                elseif A[q-1, coordinate] < median - delta 
                    return q 
                end 
            elseif A[q, coordinate] < median - delta
                return binarySearchLeft(A, delta, coordinate, median, q+1, r)
            end

            return binarySearchLeft(A, delta, coordinate, median, p, q-1)
        end
        
        return 0
    end

    #FUNGERER :D
    function binarySearchRight(A, delta, coordinate, median, p, r)

        if p <= r

            q = div(p+r, 2)
            #println(q)
            if A[q, coordinate] <= median+delta
                #println("Ok")
                if q === size(A)[1]
                    return q
                elseif A[q+1, coordinate] > median + delta
                    return q
                end

            elseif A[q, coordinate] > median+delta
                return binarySearchRight(A, delta, coordinate, median, p, q-1)
            end


            return binarySearchRight(A, delta, coordinate, median, q+1, r)

        end

        return 0

    end
end


