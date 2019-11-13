weights = [3  6  8 6 3
          7  6  5 7 3
          4  10 4 1 6
          10 4  3 1 2
          6  1  7 3 9]

pathweigths = [3  6  8  6  3
10 9  11 10 6
13 19 13 7  12
23 17 10 8  9
23 11 15 11 17]

function cumulative(weights)
    rows, cols = size(weights)
    pathweights = similar(weights)
    for i = 1:rows
        for j = 1:cols

            if i == 1
                pathweights[1, j] = weights[1, j]
                continue
            end

            if j == 1
                minimum = min(pathweights[i-1, j], pathweights[i-1, j+1])
            elseif j == cols
                minimum = min(pathweights[i-1, j], pathweights[i-1, j-1])
            else
                minimum = min(pathweights[i-1, j], pathweights[i-1, j+1])
                minimum = min(minimum, pathweights[i-1, j-1])
            end

            pathweights[i, j] = weights[i, j] + minimum
        end
    end

    return pathweights

end

println(cumulative(weights))

function backtrack(pathweights)

    rows, cols = size(weights)

    path = []


    minimum = pathweights[rows, 1]
    index = 1
    for j = 2:cols
        if pathweights[rows, j] < minimum
            index = j
            minimum = pathweights[rows, j]
        end
    end

    push!(path, (rows, index))

    for i = rows-1:-1:1

        minimum = pathweights[i, index]
        current_index = index
        for j = current_index-1:current_index+1
            if j == 0 || j == cols + 1
                continue
            elseif pathweights[i, j] < minimum
                index = j
                minimum = pathweights[i, j]
            end
        end


        push!(path, (i, index))

    end
    return path
end

println(backtrack(pathweigths))
