

function CountingSort(A, k)

    B = similar(A)
    C = zeros(Int8, k+1)

    for j in 1:length(A)
        C[A[j][1]+1] += 1
    end
    for i in 2:k+1
        C[i] += C[i-1]
    end
    #print(C)

    for j in length(A):-1:1
        B[C[A[j][1]+1]] = A[j]
        C[A[j][1]+1] -= 1
        println(C)
        #println(B)
    end
    println(C)
    return B
end

#B = ["ccc", "cba", "ca", "ab", "abc"]
#C = ["bbbb", "aa", "aaaa", "ccc"]
#D = ["kobra", "aggie", "agg", "kort", "hyblen"]

A = [[1, 2], [5, 6], [0, 3], [0, 1], [0, 9]]
#println(length(A))
println(CountingSort(A, 7))
