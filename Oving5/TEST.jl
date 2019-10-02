c = Channel(0);

task = @async foreach(i->put!(c, i), 1:11);

bind(c, task)
k = sum(c)
println(c)
if !isopen(c)
    println(k)
end

function brokendnasearch(root, dna, i=1, channel = Channel{Int64}(0))

    @fastmath if i > length(dna)
        put!(channel, root.count)
    end

    c = Channel{Int64}(0)

    @fastmath @inbounds if dna[i] != '?'
        @fastmath @inbounds if haskey(root.children, dna[i])
            i += 1
            task = @async brokendnasearch(root.children[dna[i]], dna, i, c)
            bind(c, task)
        end
    else
        i += 1
        for j in values(root.children)
            task = @async brokendnasearch(j, dna, i, c)
            bind(c, task)
        end
    end

    sum = sum(c)
    if !isopen(c)
        put!(channel, sum)
    end
end

function brokendnasearch(root, dna)

    main_channel = Channel{Int64}(0)

    task = @async search(root, dna, main_channel)
    bind(main_channel, task)

    sum = sum(main_channel)
    if !isopen(main_channel)
        return sum
    end


end

function search(root, dna, main_channel, i=1)

    @fastmath if i > length(dna)
        put!(main_channel, root.count)
    end

    channel = Channel{Int64}(0)

    @fastmath @inbounds if dna[i] != '?'
        @fastmath @inbounds if haskey(root.children, dna[i])
            i += 1
            task = @async search(root.children[dna[i]], dna, i, channel)
            bind(channel, task)
        end
    else
        i += 1
        for j in values(root.children)
            task = @async search(j, dna, i, channel)
            bind(channel, task)
        end
    end

    sum = sum(channel)
    if !isopen(channel)
        put!(main_channel, sum)
    end
end




