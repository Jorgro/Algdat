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


s2 = [1, 2, 3, 4]
s2 = [2,1,4,3,6,5, 7, 8, 19, 9, 10, 20, 21, 44, 34, 36, 289, 391, 398, 297, 298]
k, s = lislength(s2)
println(s)
function lis(s, mls)
    ml = maximum(mls)
    lis = zeros(Int, ml)

    index = ml
    for i = length(mls):-1:2

        if mls[i] == ml
            lis[index] = s[i]
            index -= 1
            ml -= 1
        end
    end
    if lis[1] == 0
        lis[1] = 1
    end
    return lis
end

println(lis(s2, s))