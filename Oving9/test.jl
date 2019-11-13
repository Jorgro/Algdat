mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end

function findset(x)
	if x != x.p
        x.p = findset(x.p)
    end
   	return x.p
end

function union!(x, y)
	link(findset(x), findset(y))
end

function link(x, y)
	if x.rank > y.rank
        y.p = x
    else
        x.p = y
        if x.rank == y.rank
            y.rank += 1
        end
    end
end

function findclusters(E, n, k)
    nodes::Array{DisjointSetNode} = Array{DisjointSetNode}(undef, n)
    @inbounds for i in 1:n
        node = DisjointSetNode()
        node.rank = 0
        node.p = node
        nodes[i] = node
    end

    sort!(E)
    c = n
    id = 1
   	while c != k
        @inbounds edge = E[id]

        @inbounds if findset(nodes[edge[2]]) != findset(nodes[edge[3]])
            @inbounds union!(nodes[edge[2]], nodes[edge[3]])
            @fastmath c -= 1
        end

        @fastmath id += 1
    end

    
    disjoints::Array{DisjointSetNode} = []
    final::Array{Array{Int64}} = [[] for idx in 1:k]
    for j in 1:k
        push!(final, [])
    end

    c = 1

    for (index, node) in enumerate(nodes)
        println(findset(node))

        truth = false
        for (index_j, val) in enumerate(disjoints)
            if findset(node) == val
                truth = true
                push!(final[index_j], index)
            end
        end

        if !truth
            push!(disjoints, findset(node))
            push!(final[c], index)
            c += 1
        end
    end

    return final

    #println(findset(nodes[1]) == findset(nodes[2]))
end

function hammingdistance(s1, s2)
    c = 0
	@simd for i in 1:length(s1)
        @inbounds if s1[i] != s2[i]
            @fastmath c += 1
        end
    end
    return c

end

function findanimalgroups(animals::Array{Tuple{String, String}}, k)
	E::Vector{Tuple{Int, Int, Int}} = []
    @inbounds for i in 1:length(animals)-1
        for j in i+1:length(animals)
            d = @fastmath hammingdistance(animals[i][2], animals[j][2])
            push!(E, (d, i, j))
        end
    end

    clusters::Array{Array{Int64}} = findclusters(E, length(animals), k)
    final = [Array{String,1}(undef, 1) for idx in 1:k]
    @inbounds for (ind, clust) in enumerate(clusters)
        final[ind] = [animals[w][1] for w in clust]
    end
    return @views final
end
n=3
k=2
E=Tuple{Int64,Int64,Int64}[(3, 1, 2), (3, 2, 1)]
findclusters(E, n, k)
