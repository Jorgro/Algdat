function reverseandlimit(v::Array{Int64, 1}, maxnumber::Int64)
    k = @async one(v, maxnumber)
    b = @async two(v, maxnumber)
    k_b = istaskdone(k)
    b_b =  istaskdone(b)
    while !k_b || !b_b
        k_b = istaskdone(k)
        b_b =  istaskdone(b)
    end
    return v
end

function one(v, maxnumber, c)
	if modulo2(lastindex(v))
        	@inbounds v[div(lastindex(v), 2)+1] = min(v[div(lastindex(v),2)+1], 				maxnumber)
    end
    put!(c, 1)
end

function two(v, maxnumber, c)
    @inbounds for i in firstindex(v):div(lastindex(v), 2)
        v[i], v[lastindex(v)-i+1] = min(v[lastindex(v)-i+1], maxnumber), min(v[i], 			maxnumber)
    end
    put!(c, 1)

end

function modulo2(k)
    @fastmath return k%2 == 1
end

A = [24, 28, 10, -8, 38]
@time reverseandlimit(A, 0)
