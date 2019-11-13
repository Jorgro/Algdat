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

    
function mincoins(coins::Array{Int64}, value::Int64)
	
    @fastmath @inbounds if usegreed(coins::Array{Int64})
        return mincoinsgreedy(coins::Array{Int64}, value::Int64)
    end
	inf  = 8000
    r::Array{Int64} = zeros(value)
	r[1] = 1
    @fastmath @inbounds for j = 2:value
        @views r[j] = inf
        q = inf

        @fastmath @inbounds for i  = lastindex(coins):-1:1
			
			 if coins[i] < j
                @fastmath q = min(q, @views r[j-coins[i]]+1)
            elseif j == @views coins[i]
				@fastmath q = 1
            else
				break
            end
        end
        @views r[j] = q

    end
    return @views r[value]

end