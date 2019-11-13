function mincoinsgreedy(coins, value::Int)
       ans = 0
       truth = true
        i = 1
       while truth && i < lastindex(coins)

           while value >= coins[i]
               @fastmath ans += 1
               @fastmath value = value - coins[i]
           end

           truth = (coins[i] % coins[i+1] == 0)

           i += 1
        end

       return @views ans+value, truth
   end

function mincoins(coins, value::Int64)

    ans, truth = mincoinsgreedy(coins, value::Int)
    if truth
        println("ok")
        return ans
    end

    a::Array{Int64} = zeros(Int64, value)
    a[1] = 1
    inf = 8000
    q = inf
    @inbounds for i = 2:value
     a[i] = inf
     q = inf
        j::Int64 = lastindex(coins)
        @inbounds while q != 1 && j >= 1
        if @views coins[j] < i
          @fastmath q = @views min(q, @views a[i-coins[j]]+1)
        elseif i == @views coins[j]
            q = 1
            else
            break
        end
        @fastmath j -= 1

        end
     @views a[i] = q
    end
    return @views a[value]

end

coins = [100, 50, 10, 5, 1]
value = 134
println(mincoins(coins, value))