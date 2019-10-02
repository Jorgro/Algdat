module Bruteforce export bruteforce

    function bruteforce(A)

        @inbounds length = size(A)[1]
        minimum = 20000

        @fastmath @inbounds for i in 1:length
            @fastmath @inbounds for j in i+1:length
                distance = euclidean_distance(A[i, :], A[j, :])
                if distance < minimum
                    minimum = distance
                end
            end
        end
        return minimum
    end

    function euclidean_distance(x, y)

        @fastmath return ((x[1]-y[1])^2 + (x[2]-y[2])^2)^(1/2)

    end
end
