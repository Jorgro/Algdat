include("./binaryintervalsearch.jl")
include("./bruteforce.jl")
include("./mergesort2.jl")
include("./splitintwo.jl")

using .BinarySearch
using .Bruteforce
using .Mergesort
using .Splitintwo
#Anta at closestpair får inn to arrays, hvor x er sortert på x-akse
#og y er sortert med hensyn på y-aksen.

function closestpair(x,y)
    #println(x)
    #println(y)
    if size(x)[1] < 4
        return bruteforce(x)
    end

    xm = x[ceil(Int, size(x)[1]/2), 1]

    # a[a .> 4]
    #x_left, x_right, y_left, y_right = splitintwo(x, y)
    x_left = x[1:ceil(Int, size(x)[1]/2), 1:2]
    x_right = x[ceil(Int, size(x)[1]/2)+1:size(x)[1], 1:2]
    #println(x_left)

    y_left = similar(x_left)
    y_right = similar(x_right)

    right = 0
    left = 0

#=     for i in eachindex(y)
        if y[i] <= xm
            left += 1 
            y_left[left, :] = [y[i] y[i + size(y)[1]]]
        else
            right += 1
            y_right[right, :] = [y[i] y[i + size(y)[1]]]
            #y_right[right, 1] = y[i]
            #y_right[right, 2] =y[i + ceil(Int, size(y)[1]/2)+2]
            #= y_right[right, 1] = y[i, 1]
            y_right[right, 2] = y[i, 2] =#
        end

        if i == size(y)[1]
            break
        end
    end =#

    for i in 1:size(y)[1]
        if y[i, 1] <= xm
            left += 1 
            y_left[left, :] = [y[i, 1], y[i, 2]]
        else
            right += 1
            y_right[right, :] = [y[i, 1] y[i, 2]]
            #y_right[right, 1] = y[i]
            #y_right[right, 2] =y[i + ceil(Int, size(y)[1]/2)+2]
            #= y_right[right, 1] = y[i, 1]
            y_right[right, 2] = y[i, 2] =#
        end
    end

    #println(x_left)
    #println(x_right)

    min_left = closestpair(x_left, y_left)
    min_right = closestpair(x_right, y_right)

    delta = min(min_left, min_right)

    #left, right = binaryintervalsearch(y, delta, 1)
    yS = []
    for i in 1:size(y)[1]
        if abs(xm - y[i, 1]) < delta
            push!(yS, y[i, :])
            #yS[i, :] = y[i, :]
        end
    end
    #println(yS)
#=     yS = []
    for row in Base.eachrow(y)
        if abs(xm - row[1]) < delta
            push!(yS, row)
        end
    end =#
#=     println(size(y))
    for i in eachindex(y)
        
        if abs(xm - y[i]) < delta
            println(i)
            println(i+ceil(Int, size(y)[1]/2)+2)
            push!(yS, [y[i], y[i + ceil(Int, size(y)[1]/2)+2]])
        end
        if i == ceil(Int, size(y)[1]/2)+2
            break
        end
    end =#

    #println(yS)
    nS = length(yS)
    println(nS)
    #nS = right-left+1


    closest = delta 

    for i in 1:nS-1

        k = i +1
        while k <= min(nS, i+7) && yS[k][2] - yS[i][2] < delta 
            temp = ((yS[k][2]-yS[i][2])^2 + (yS[k][1]-yS[i][1])^2)^(1/2)
            if temp < closest
                closest = temp
            end
            k += 1
        end
#=         println(k)
        println(i)
        println("Left = ", left)
        println("Rigth = ", right) =#
#=         while k <= min(nS, i+7) && y[k, 2] - y[i, 2] < delta 
            temp = ((y[k, 2]-y[i, 2])^2 + (y[k, 1]-y[i, 1])^2)^(1/2)
            if temp < closest
                closest = temp
            end
            k += 1
        end =#


    end 

    return closest

end

#Sørger for at closespair mottar sorterte arrays
#La stå, denne kalles for å teste koden
function callclosestpair(arr)
    #println(x)
    #println(y)
    #return closestpair(mergesort(copy(arr),1), mergesort(copy(arr),2))
    return closestpair(Base.sortslices(arr, dims=1, lt=(x,y)->isless(x[1],y[1])), Base.sortslices(arr, dims=1, lt=(x,y)->isless(x[2],y[2])))
end

#= a = [1.0 3.0; 3.0 5.0]
for i in CartesianIndices(a)
    println(i)
end =#
# i is now a CartesianIndex
# Code that does something with i and/or A[i]

#println(a[a .> 4])

#= for i in 1:100
    arr = 10*rand(100,2)
    println(bruteforce(arr) == callclosestpair(arr))
    #if (bruteforce(arr) != callclosestpair(arr))
        #println(arr)
    #end
end =#
arr = [1 0; 2 3; 5 6]

@time callclosestpair(arr)
#@time bruteforce(arr)

#= yS = []
    for i in 1:size(y)[1]
        if abs(xm - y[i, 1]) < delta
            push!(yS, y[i, :])
        end
    end
    
    nS = length(yS)
    closest = delta 
    for i in 1:nS-1

        k = i +1
        while k <= min(nS, i+7) && yS[k][2] - yS[i][2] < delta 
            temp = ((yS[k][2]-yS[i][2])^2 + (yS[k][1]-yS[i][1])^2)^(1/2)
            if temp < closest
                closest = temp
            end
            k += 1
        end
    end 

    return closest
 =#
