mutable struct NodeDoublyLinked
    prev::Union{NodeDoublyLinked, Nothing} # Er enten forrige node eller nothing
    next::Union{NodeDoublyLinked, Nothing} # Er enten neste node eller nothing
    value::Int # Verdien til noden
end

function createLinkedListDoublyLinked(length)
    # Create the list from the last element in the chain
    # This is so the returned element will be the first in the chain
    current = nothing
    beforeCurrent = nothing

    for i in 1:length
        # only fill out the next field because prev will be filled out later
        current = NodeDoublyLinked(nothing, beforeCurrent, rand(-100:100))
        # link up the node before this node to this node
        if beforeCurrent != nothing
            beforeCurrent.prev = current
        end
        beforeCurrent = current
    end
    return current
end

function maxofdoublelinkedlist(linkedlist)

#=     nodePrev = linkedlist.prev
    nodeNext = linkedlist.next

    currentMax = linkedlist.value

    while nodePrev != nothing
        if nodePrev.value > currentMax
            currentMax = nodePrev.value
        end
        nodePrev = nodePrev.prev
    end

    while nodeNext != nothing
        if nodeNext.value > currentMax
            currentMax = nodeNext.value
        end
        nodeNext = nodeNext.next
    end

    return currentMax
end =#

    node = linkedlist
    while node.prev != nothing
        node = node.prev
    end

    #println(node)
    currentMax = node.value
    while node != nothing
        if node.value > currentMax
            currentMax = node.value
        end
        node = node.next
    end
    return currentMax
    
end


function t(linkedlist)
    node = linkedlist
    while node.prev != nothing
        node = node.prev
    end
    return node
end

l = createLinkedListDoublyLinked(3)
#println(l)
l = l.next.next
println(l)
println(maxofdoublelinkedlist(l))
#print(l)
