# Skriv koden din her!

mutable struct Node
    next::Union{Node, Nothing} # next kan peke på et Node-objekt eller ha verdien nothing.
    value::Int
end

function createlinkedlist(length)
    # Creates the list starting from the last element
    # This is done so the last element we generate is the head
    child = nothing
    node = nothing

    for i in 1:length
        node = Node(child, rand(1:800))
        child = node
    end
    return node
end


function findindexinlist(linkedlist, index)
    findIndex = 1
    node = linkedlist
    while node != nothing
       if findIndex == index
            return node.value
       end
       node = node.next
       findIndex += 1   
    end
    
    return -1
	
end
