function usegreed(coins)
    @fastmath for i = @views 1:lastindex(coins)-1
        @fastmath @inbounds if coins[i] % coins[i+1] != 0
            return false
        end
    end
    return true
end
function mincoinsgreedy(coins, value::Int)
    @fastmath ans = 0
    @fastmath @inbounds for coin in coins
       @fastmath @inbounds while value >= coin
            @fastmath ans += 1
           @fastmath value = value - coin
        end
    end
    return @views ans
end
function mincoins(coins, value::Int64)
    @fastmath @inbounds if usegreed(coins)
        return @views mincoinsgreedy(coins, value)
    end
    a::Array{Int64} = zeros(Int64, value)
    a[1] = 1
   @fastmath  inf::Int64 = 8000
   q::Int64 = inf
   @inbounds for i = 2:value
      @fastmath a[i] = inf
      q = inf
      j::Int64 = lastindex(coins)
      @inbounds while q != 1 && j >= 1
         if @views coins[j] < i
            q = @views min(q, @views a[i-coins[j]]+1)
         elseif i == @views coins[j]
            q = 1
            else
             break
         end
         @fastmath j -= 1

      end
      @fastmath @views a[i] = q
   end
   return @views a[value]

end