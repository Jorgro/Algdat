using Base
A = [1.0 1.0; 2.0 1.0; 3.0 5.0; 5.0 6.0]
#println(A[1])
#A = A'
#println(A)
#b = reshape(A, 2, 4);
#= yS = similar(A)
for i in eachindex(A)
    #println(A[i])
    #println(A[i+1])
    yS[i, :] = [A[i] A[i + ceil(Int, size(A)[1])]]
    if i == size(A)[1]
        break
    end
end
#println(b)
println(yS)
#A = [1.0 1.0; 2.0 2.0]
#println(A[:, A[1].>1.5])

yS = Array{Float64, 2}(undef, 2, 3)
 =#

a = A'
println(a)

inds = size(A)[1]
println(inds)

function test1(A)
    B = similar(A)
    for i in 1:size(A)[1]
        B[:, i] = A[:, i]
    end
    return B
end

function test2(A)
    B = similar(A)
    for i in 1:size(A)[2]
        B[i, :] = A[i, :]
    end
    return B
end

A = 10*rand(1000, 2)
B = A'
@time test1(B)
@time test2(A)

