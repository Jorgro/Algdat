
function insertionsort!(A)
	println("Hello")
    i = 1
    while i <= length(A)
        key = A[i]
        j = i - 1
        while j > 0 && A[j] > key
            A[j+1] = A[j]
            j = j-1
        end
        A[j+1] = key
		i+=1 
    end
end


a = [1, 25, 2, 4, 5]
insertionsort!(a)
println(a)
