function mincoinsgreedy(coins::Array{Int64}, value::Int64)
    @fastmath mincoins = 0
    @fastmath i = 1
    @fastmath @inbounds while value != 0
        while value >= coins[i]
        	@fastmath value = value - coins[i]
        	mincoins += 1   
        end
        i += 1
    end
    return mincoins
end


function mincoins(coins, value)
	
    @fastmath @inbounds if usegreed(coins::Array{Int64})
        return mincoinsgreedy(coins::Array{Int64}, value::Int64)
    end
    
    r::Array{Int64} = zeros(value+1)
	@views r[2] = 1
    @fastmath @inbounds for j = 2:value
        @views r[j+1] = 10000
        q = 10000
		
        for i  = length(coins):-1:1

            @views if coins[i] > j
                break
            else
				@views q = min(q, r[j-coins[i]+1]+1)
            end
        end
        @views r[j+1] = q

    end
    return @views r[value+1]

end