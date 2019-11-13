mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end

function union!(x, y)
	link(findset(x), findset(y))
end

function findset(x)
	if x != x.p
        x.p = findset(x.p)
    end
   	return x.p
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
    nodes = []
    for i in 1:n
        node = DisjointSetNode()
        node.rank = 0
        node.p = node
        push!(nodes, node)
    end
    #println(nodes)
    A = []
    sort!(E)
    c = n
    for edge in E

        if c == k
            break
        end

        if findset(nodes[edge[2]]) != findset(nodes[edge[3]])
            union!(nodes[edge[2]], nodes[edge[3]])
            push!(A, edge)
            c -= 1
        end
    end

    disjoints::Array{DisjointSetNode} = []
    final::Array{Array{Int64}} = []
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

#= n=3
k=2
E=Tuple{Int64,Int64,Int64}[(3, 1, 2), (3, 2, 1)]
push!(E, (1, 2, 3))
println(E)
c = findclusters(E, n, k)
println(length(c))
println(c) =#

function hammingdistance(s1, s2)
    c = 0
	for i in 1:length(s1)
        if s1[i] != s2[i]
            c += 1
        end
    end
    return c

end

function findanimalgroups(animals, k)
	E::Vector{Tuple{Int, Int, Int}} = []
    for i in 1:length(animals)-1
        for j in i+1:length(animals)
            d = hammingdistance(animals[i][2], animals[j][2])
            push!(E, (d, i, j))
			push!(E, (d, j, i))
        end
    end

    clusters = findclusters(E, length(animals), k)
    final = []
    for clust in clusters
        push!(final, [animals[w][1] for w in clust])
    end
    return final
end

function retardspag()
    f = Array{Array{String,1},2}(undef, 10, 10)
    print(f)
end
retardspag()
#input = [("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")]
#k = 2