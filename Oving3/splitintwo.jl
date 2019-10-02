
module Splitintwo export splitintwo
    function splitintwo(x, y)

        x_size = size(x)[1]
        y_size = size(y)[1]
        if x_size % 2 == 0
            
            q_1 = div(1+div(length(x), 2), 2)
            q_2 = q_1 + 1
            median = (x[q_1, 1] + x[q_2, 1])/2
            
            #Kan effektiviseres ved å gjøre dict utregningen samtidig
            x_left = x[1:div(x_size, 2), 1:2]
            x_right = x[div(x_size, 2)+1:x_size, 1:2]

            y_right = zeros(Float64, div(x_size, 2), 2)
            y_left = zeros(Float64, div(x_size, 2), 2)

            right = 0
            left = 0

            dict_left = Dict()

            for i in 1:div(x_size, 2)
                count = get(dict_left, x_left[i, 1:2], 0)
                dict_left[x_left[i, 1:2]] = count + 1
                
            end
            #println(dict_left)
            #println(y)
            #println("median: ", median)
            #println(x)
            for i in 1:x_size 
               #println("Left", y_left)
                #println("Right", y_right)
                if y[i, 1] == median
                    if get(dict_left, y[i, 1:2], 0) != 0
                        left += 1
                        y_left[left, 1] = y[i, 1]
                        y_left[left, 2] = y[i, 2]
                        dict_left[y[i, 1:2]] -= 1
                    else
                        right += 1
                        y_right[right, 1] = y[i, 1]
                        y_right[right, 2] = y[i, 2]
                    end
                elseif y[i, 1] > median
                    right += 1
                    y_right[right, 1] = y[i, 1]
                    y_right[right, 2] = y[i, 2]
                    
                else
                    left += 1
                    y_left[left, 1] = y[i, 1]
                    y_left[left, 2] = y[i, 2]
                end
            end


        else
            q = div(x_size, 2) + 1
            median = x[q, 1]

            x_left = x[1:div(x_size, 2)+1, 1:2]
            x_right = x[div(x_size, 2)+2:x_size, 1:2]

            y_right = zeros(Float64, div(x_size, 2), 2)
            y_left = zeros(Float64, div(x_size, 2)+1, 2)
            right = 0
            left = 0


            dict_left = Dict()

            for i in 1:div(x_size, 2)+1
                count = get(dict_left, x_left[i, 1:2], 0)
                dict_left[x_left[i, 1:2]] = count + 1
                
            end

            #= println(dict_left)
            println(y)
            println("median: ", median)
            println(x) =#
            for i in 1:x_size 
#=                 println(i)
                println(y[i, :])
                println(y_left) =#
                if y[i, 1] == median

                    if get(dict_left, y[i, 1:2], 0) != 0
                        left += 1
                        y_left[left, 1] = y[i, 1]
                        y_left[left, 2] = y[i, 2]
                        dict_left[y[i, 1:2]] -= 1
                    else
                        right += 1
                        y_right[right, 1] = y[i, 1]
                        y_right[right, 2] = y[i, 2]
                    end

                elseif y[i, 1] > median
                    right += 1
                    y_right[right, 1] = y[i, 1]
                    y_right[right, 2] = y[i, 2]
                else
                    left += 1
                    y_left[left, 1] = y[i, 1]
                    y_left[left, 2] = y[i, 2]
                end
            end
        end



        return (x_left, x_right, y_left, y_right)



    end
    #println(splitintwo([2.521046359089245 0.309377613270303; 8.22064749295248 0.5496134729547264; 5.795585460963329 2.247535428035361; 0.5480041022352466 3.1905598610862285; 5.600834947195201 3.666885195759453], 
    #[2.521046359089245 0.309377613270303; 0.5480041022352466 3.1905598610862285; 0.5385326415347813 3.6908147152118964; 
    #0.113681076015133 5.863002857236765; 0.12092254659789914 8.523835121519387]))
end

