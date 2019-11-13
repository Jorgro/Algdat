#using Pkg
#Pkg.add("DataStructures")
using DataStructures: Queue, enqueue!, dequeue!

mutable struct Node
    i::Int
    j::Int
    floor::Bool
    neighbors::Array{Node}
    color::Union{String,Nothing}
    distance::Union{Int,Nothing}
    predecessor::Union{Node,Nothing}
end
Node(i, j, floor=true) = Node(i, j, floor, [], nothing, nothing, nothing)



### Du skal implementere denne funksjonen ###
function mazetonodelist(maze)
    # Vi lager en matrise nodearray med størrelse tilsvarende maze,
    # men med Node-objekter isteden
    nodearray = Array{Node}(undef, size(maze, 1), size(maze, 2))

    for i in 1:size(maze, 1)
        for j in 1:size(maze, 2)
            if maze[i, j] == 1
                nodearray[i, j] = Node(i, j)
            else
                nodearray[i, j] = Node(i, j, false)
            end
        end
    end

    nodelist::Array{Node} = []
    for i in 1:size(maze, 1)
        for j in 1:size(maze, 2)
            if nodearray[i, j].floor
                    if i - 1 > 0 && nodearray[i-1, j].floor == true
                        push!(nodearray[i, j].neighbors, nodearray[i-1, j])
                    end
                    if i + 1 <= size(maze, 1) && nodearray[i+1, j].floor == true
                        push!(nodearray[i, j].neighbors, nodearray[i+1, j])
                    end
                	if j - 1 > 0  && nodearray[i, j-1].floor == true
                        push!(nodearray[i, j].neighbors, nodearray[i, j-1])
                    end
                    if j + 1 <= size(maze, 2) && nodearray[i, j+1].floor == true
                        push!(nodearray[i, j].neighbors, nodearray[i, j+1])
                    end
                nodearray[i, j].color = "white"
                push!(nodelist, nodearray[i, j])
            end
            # Fyll inn kode for å oppdatere neighbors til hver node
            # (Husk at naboene alltid er rett over, rett under,
            #  rett til venstre og/eller rett til høyre)
        end
    end
    return nodelist

    # Fyll inn kode for å returnere en nodeliste ut ifra nodearray
end

function isgoalnode(node)
    global goal
    node == goal

end

function setgoalnode(node)
    global goal
    goal = node
end

function bfs!(nodes, start)
    c = false
    @simd for node in nodes
        node.color = "white"
        if isgoalnode(node)
            c = true
        end
    end

    if !c
        return nothing
    end


    start.color = "gray"
    start.distance = 0

    Q = Queue{Node}()

    enqueue!(Q, start)

    while !isempty(Q)
        u = dequeue!(Q)

        if isgoalnode(u)
                return u
        end

        @fastmath @inbounds for node in u.neighbors
            if node.color == "white"
                node.color = "gray"
                #node.distance = u.distance + 1
                node.predecessor = u
                enqueue!(Q, node)
            end
        end
        u.color = "black"


    end

    return nothing



end

function bfs1!(nodes, start)
    i = 1
    start.color = "gray"
    start.distance = 0

    Q = Queue{Node}()

    enqueue!(Q, start)

    while !isempty(Q)
        #println(i)
        u = dequeue!(Q)

        if isgoalnode(u)
            return u
        end

        for node in u.neighbors
            if node.color == "white"
                node.color = "gray"
                node.distance = u.distance + 1
                node.predecessor = u
                enqueue!(Q, node)
            end
        end
        u.color = "black"
        println(u.i, u.j)
        i+= 1

    end

    return nothing



end


maze = [0 0 0 0 0 0 0 0 0 0 0
 0 1 0 1 0 1 0 1 0 1 0
 0 1 0 1 0 1 0 1 0 1 0
 0 1 0 1 1 1 1 1 1 1 0
 0 1 0 0 0 1 0 0 0 0 0
 0 1 1 1 1 1 1 1 1 1 0
 0 1 0 1 0 1 0 1 0 0 0
 0 1 0 1 0 1 0 1 0 1 0
 0 0 0 0 0 1 0 0 0 1 0
 0 1 1 1 1 1 1 1 1 1 0
 0 0 0 0 0 0 0 0 0 0 0]


node_list = mazetonodelist(maze)
setgoalnode(node_list[13])
#print(node_list[48])
bfs!(node_list, node_list[48])