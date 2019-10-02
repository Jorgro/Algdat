
module Mergesort export mergesort
    #x og y er to sorterte arrays, coordinate angir koordinat akse
    function mergearrays(A, p, q, r, coordinate)
        n_1 = q-p+1
        n_2 = r - q

        L = []
        R = []

        #sizehint!(L, n_1 + 1)
        #sizehint!(R, n_2 + 1)

        for i in 1:n_1
            push!(L, A[p+i-1, :])
        end

        for j in 1:n_2
            push!(R, A[q+j, :])
        end

        push!(L, [20000, 20000])
        push!(R, [20000, 20000])

        i = 1
        j = 1
        for k in p:r
            if L[i][coordinate] <= R[j][coordinate]
                A[k, 1] = L[i][1]
                A[k, 2] = L[i][2]
                i += 1
            else
                A[k, 1] = R[j][1]
                A[k, 2] = R[j][2]
                j += 1
            end

        end
    end

    #x usortert array, coordinate angir koordinat akse vi skal sortere langs
    function mergesort(A, coordinate, p=1, r=div(length(A), 2))
        if p < r
            q = div(p+r, 2)
            mergesort(A, coordinate, p, q)
            mergesort(A, coordinate, q+1, r)
            mergearrays(A, p, q, r, coordinate)
            return A
        end
        return A

    end
    #println(mergesort([0.4374349455344362 0.7892555157575587; 7.107421679680486 1.3396739160155713; 5.532717374541731 1.4879734895477092; 9.654468309824795 2.2131993630852564; 4.751535099881917 4.485838648665263; 0.4700814715804347 5.3413694759208585; 1.3050430345518205 5.661525951189339; 4.482113848589366 5.8069318964839; 6.06412235051849 6.646714016454343; 4.897569907388 7.771524978067297], 1))
end
