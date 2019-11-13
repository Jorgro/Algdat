function mincoinsgreedy(coins, value)
    mincoins = 0
    for coin in coins
        k = div(value, coin)
        if k > 0
            value = value%coin
            mincoins += k
        end
    end
    return mincoins
end

function usegreed(coins)
    # Din kode her
    for c = 1:length(coins)-1
		if coins[c]%coins[c+1] != 0
            return false
        end
    end
    return true
end


function mincoins(coins, value)

    if usegreed(coins)
        return mincoinsgreedy(coins, value)
    end
    r = zeros(value+1)

    max = typemax(Int)




    @fastmath @inbounds for j = 1:value
        r[j+1] = max
        q = max

        for i  = length(coins):-1:1
            #print(i)
            @views if coins[i] > j
                break
            else

                q = min(q, r[j-coins[i]]+1)

#=                 @views val = j-coins[i]
                if val == 0
                    q = min(q, 1)
                else
                    q = min(q, r[val+1]+1)
                end =#
            end
        end
        @views r[j+1] = q

    end
    println(r)
    return @views r[value+1]

end


println(mincoins([4, 3, 1],6))