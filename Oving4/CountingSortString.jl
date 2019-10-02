

function countingsortletters(A, position)

    B = similar(A)
    C = zeros(Int8, 26)

    for j in 1:length(A)
        if position > length(A[j])
            C[1] += 1
        else
            C[chartodigit(A[j][position])] += 1
        end
    end
    for i in 2:26
        C[i] += C[i-1]
    end
    #print(C)

    for j in length(A):-1:1
        if position > length(A[j])
            B[C[1]] = A[j]
            C[1] -= 1
        else
            B[C[chartodigit(A[j][position])]]  = A[j]
            C[chartodigit(A[j][position])] -= 1
        end
    end
    return B
end

function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.

    return character - '`'
end

function countingsortlength(A, maxlength)
	B = similar(A)
    C = zeros(Int8, maxlength+1)

    for j in 1:length(A)
        C[length(A[j])+1] += 1
    end
    for i in 2:maxlength+1
        C[i] += C[i-1]
    end
    #print(C)

    for j in length(A):-1:1
        B[C[length(A[j])+1]]  = A[j]
        C[length(A[j])+1] -= 1
    end
    return B
end

function flexradix(A::Array{String, 1}, maxlength::Int64)
    #B = []
    B = countingsortlength(A, maxlength)
    #println(B)
	for i in maxlength:-1:1
        B = countingsortletters(B, i)
        #println(B, i)
    end
    return B
end
println(flexradix(["kobra", "aggie", "agg", "kort", "hyblen",  "aaaa", "", "bccc"], 6))
println(sort!(["kobra", "aggie", "agg", "kort", "hyblen",  "aaaa", "", "bccc"]))
for i in 1:10
    @time flexradix(["kobra", "aggie", "agg", "kort", "hyblen",  "aaaa", "", "bccc"], 6)
    @time sort!(["kobra", "aggie", "agg", "kort", "hyblen",  "aaaa", "", "bccc"])
end

[0, 0, 0, 0, 0, 0]