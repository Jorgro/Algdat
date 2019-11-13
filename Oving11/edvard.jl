#Tilgjengelige funksjoner
using DataStructures: PriorityQueue, enqueue!, dequeue!, Queue


function find_augmenting_path(source, sink, nodes, flows, capacities)

    function create_path(source, sink, parent)
      # creates a path from source to sink using parent list
      node = sink
      path = Vector{Int}([sink])
      while node ≠ source
        node = parent[node]
        push!(path, node)
      end
      return reverse(path)
    end

    discovered = zeros(Bool, nodes)
    parent = zeros(Int, nodes)
    queue = Queue{Int}()
    enqueue!(queue, source)

    # BFS to find augmenting path, while keeping track of parent nodes
    c = []
    while !isempty(queue)
      node = dequeue!(queue)
      push!(c, node)
      if node == sink
        return create_path(source, sink, parent), true
      end

      for neighbour ∈ 1:nodes
        if !discovered[neighbour] && flows[node, neighbour] < capacities[node, neighbour]
          enqueue!(queue, neighbour)
          discovered[neighbour] = true
          parent[neighbour] = node
        end
      end
    end

    return c, false # no augmenting path found
  end

  function max_path_flow(path, flows, capacities)
    # find max flow to send through a path
    n = length(path)
    flow = Inf
    for i in 2:n
      u, v = path[i-1], path[i]
      flow = min(flow, capacities[u, v] - flows[u, v])
    end
    return flow
  end

  function send_flow!(path, flow, flows)
    n = length(path)
    for i in 2:n
      u, v = path[i-1], path[i]
      flows[u, v] += flow
      flows[v, u] -= flow
    end
  end
  #Tilgjengelige funksjoner slutt

  function max_flow(source, sink, nodes, capacities)
    flows = zeros(size(capacities)[1], size(capacities)[2])
    path, bool = find_augmenting_path(source, sink, nodes, flows, capacities)
    while bool
        flow = max_path_flow(path, flows, capacities)
        send_flow!(path, flow, flows)
        path, bool = find_augmenting_path(source, sink, nodes, flows, capacities)
    end
    total_flow = -1
    for j = 1:size(capacities)[2]
        flow = 0
        for i = 1:size(capacities)[1]
            flow += flows[j, i]
        end
        #println(flow)
        if abs(flow) > total_flow
            total_flow = flow
        end
    end

    return flows, total_flow
end

function min_cut(source, sink, nodes, capacities)
    flows, total_flow = max_flow(source, sink, nodes, capacities)
    residual = capacities - flows
    println("residual:", residual)
    println("flows:", flows)
    println("cap:", capacities)


    S = [1]
    T = []

    visiting = [1]

    while length(visiting) > 0
        i = popfirst!(visiting)
        curr = []
        for j in 1:nodes
            if residual[i, j] > 0
                push!(curr, j)
            end
        end


        for c in curr
            if !(c in S)
                push!(S, c)
                push!(visiting, c)
            end
        end
    end


    for i = 2:nodes
        if !(i in S)
            push!(T, i)
        end
    end
    return S, T

end

function mincut(source, sink, nodes, capacities)
    flows = zeros(size(capacities)[1], size(capacities)[2])
    path, bool = find_augmenting_path(source, sink, nodes, flows, capacities)
    while bool
        flow = max_path_flow(path, flows, capacities)
        send_flow!(path, flow, flows)
        path, bool = find_augmenting_path(source, sink, nodes, flows, capacities)
    end
    println("Path:", path)
    T = path
    S = []

    for i = 1:nodes
        if !(i in T)
            push!(S, i)
        end
    end

    return unique(S), unique(T)
end
#= s, t = max_flow(1, 6, 6, [0.0 16.0 13.0 0.0 0.0 0.0; 0.0 0.0 0.0 12.0 0.0 0.0; 0.0 4.0 0.0 0.0 14.0 0.0; 0.0 0.0 9.0 0.0 0.0 20.0; 0.0 0.0 0.0 7.0 0.0 4.0; 0.0 0.0 0.0 0.0 0.0 0.0])
s, t = max_flow(2, 3, 3, [0.0 78.0 150.0; 119.0 0.0 88.0; 32.0 134.0 0.0])
s, t = max_flow(2, 3, 9, [0.0 174.0 56.0 95.0 30.0 122.0 76.0 148.0 199.0; 85.0 0.0 131.0 123.0 151.0 60.0 38.0 191.0 192.0; 33.0 173.0 0.0 69.0 50.0 194.0 9.0 57.0 106.0; 82.0 197.0 156.0 0.0 10.0 86.0 152.0 93.0 139.0; 85.0 58.0 111.0 178.0 0.0 77.0 54.0 89.0 175.0; 96.0 124.0 57.0 106.0 142.0 0.0 107.0 42.0 85.0; 137.0 177.0 36.0 121.0 191.0 17.0 0.0 157.0 166.0; 163.0 21.0 107.0 116.0 28.0 189.0 23.0 0.0 139.0; 55.0 194.0 141.0 186.0 107.0 3.0 173.0 87.0 0.0])
s, t = mincut(1, 6, 6, [0.0 16.0 13.0 0.0 0.0 0.0; 0.0 0.0 0.0 12.0 0.0 0.0; 0.0 4.0 0.0 0.0 14.0 0.0; 0.0 0.0 9.0 0.0 0.0 20.0; 0.0 0.0 0.0 7.0 0.0 4.0; 0.0 0.0 0.0 0.0 0.0 0.0])
println(s)
println(t) =#

path = [1,2,3,1]
maxweight = 0
neighbourmatrix = [-1 0 0; 0 -1 0; 0 0 -1]

function certifytsp(path, maxweight, neighbourmatrix)
    if (length(path) != size(neighbourmatrix)[1]+1)
        print("ok")
        return false
    end
    sum = 0
    for i = 1:length(path)-1
        sum += neighbourmatrix[path[i], path[i+1]]
    end
    print(sum)
    return sum <= maxweight
end

println(certifytsp([3, 4, 1, 3], 100, [-1 13 2 3; 1 -1 2 15; 1 1 -1 6; 1 1 2 -1]))