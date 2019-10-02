

include("./bruteforce.jl")

using .Bruteforce

#Anta at closestpair får inn to arrays, hvor x er sortert på x-akse
#og y er sortert med hensyn på y-aksen.

function closestpair(x::Array,y::Array)
    @inbounds @fastmath if size(x)[1] < 4
        return bruteforce(x)
    end

    @inbounds xm = x[ceil(Int, size(x)[1]/2), 1]

    @inbounds @fastmath x_left = x[1:ceil(Int, size(x)[1]/2), 1:2]
    @inbounds @fastmath x_right = x[ceil(Int, size(x)[1]/2)+1:size(x)[1], 1:2]

    @inbounds @fastmath y_left = zeros(Float64, ceil(Int, size(x)[1]/2), 2)
    @inbounds @fastmath y_right = zeros(Float64, size(x)[1]-ceil(Int, size(x)[1]/2), 2)

    right = 0
    left = 0

    
    @fastmath for i in 1:size(y)[1]
        if y[i, 1] <= xm
            left += 1 
            @inbounds y_left[left, 1] = y[i, 1]
            @inbounds y_left[left, 2] = y[i, 2]
        else
            right += 1
            @inbounds y_right[right, 1] = y[i, 1]
            @inbounds y_right[right, 2] = y[i, 2]
        end
    end

    #min_left = closestpair(x_left, y_left)
    #min_right = closestpair(x_right, y_right)

    delta = min(closestpair(x_left, y_left), closestpair(x_right, y_right))

    yL = []
    yR = []

    
    @simd for i in 1:size(y)[1]
        @inbounds if xm - y[i, 1] < delta
            @inbounds push!(
        elseif
            
    end
    
    nS = length(yS)
    closest = delta 

    
    @simd for i in 1:nS-1

        k = i +1
        @inbounds while k <= min(nS, i+6) && yS[k][2] - yS[i][2] < delta 
            temp = ((yS[k][2]-yS[i][2])^2 + (yS[k][1]-yS[i][1])^2)^(1/2)
            if temp < closest
                closest = temp
            end
            k += 1
        end
    end 

    return closest

end

#Sørger for at closespair mottar sorterte arrays
#La stå, denne kalles for å teste koden
function callclosestpair(arr)
    #println(x)
    #println(y)
    return closestpair(Base.sortslices(arr, dims=1, lt=(x,y)->isless(x[1],y[1])), Base.sortslices(arr, dims=1, lt=(x,y)->isless(x[2],y[2])))
end

arr = 10*rand(100000, 2)
@time callclosestpair(arr)