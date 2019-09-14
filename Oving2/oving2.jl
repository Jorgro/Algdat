function reverseandlimit(array, maxnumber)
	s = []
    for i in length(array):-1:1
        push!(s, array[i])
	end
    for i in 1:1:length(s)
            if s[i] > maxnumber
                s[i] = maxnumber
			end
	end
    return s  
end

println(reverseandlimit([10,5,16,0], 8))
