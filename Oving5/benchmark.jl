try
	mutable struct Node
    	children::Dict{Char,Node}
    	count::Int
	end
catch
	println("Node() allerede definert")
end


function brokendnasearch(root, dna, i=1)

    @fastmath if i > length(dna)
        return root.count
    end

    @fastmath sum = 0
    @fastmath @inbounds if dna[i] != '?'
        @fastmath @inbounds if haskey(root.children, dna[i])
            sum += brokendnasearch(root.children[dna[i]], dna, i += 1)
        end
    else
        channel = Channel{Int64}(4)
        i += 1
        task = @async foreach(j -> put!(channel, brokendnasearch(j, dna, i)), values(root.children))
        bind(channel, task)
        for j in channel
            sum += j
        end
        close(channel)
    end

    return sum


end


function brokendnasearch1(root, dna, i=1)
    @fastmath if i > length(dna)
        return root.count
    end

    @fastmath sum = 0
    @fastmath @inbounds if dna[i] != '?'
        if haskey(root.children, dna[i])
            sum += brokendnasearch(root.children[dna[i]], dna, i += 1)
        end
    else
        i += 1
        for j in values(root.children)
            sum += brokendnasearch(j, dna, i)
        end
    end

    return sum
end

root = Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict{Char,Node}(), 1)), 2)), 3)), 4)), 5)), 6)), 0)
dna = "????"

println("Parallell computing:")
for i in 1:10
    @time brokendnasearch(root, dna)
end
println("Original:")
for j in 1:10
    @time brokendnasearch1(root, dna)
end
