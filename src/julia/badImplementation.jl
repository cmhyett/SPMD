
# both a and summ live inside shared memory of all the processes
N = 10000;
a = rand(N);
function performDumbSum(arr)
    summ = 0;
    # for i in 1:N
    Threads.@threads for i in 1:N
        summ += arr[i] # arr is referenced in thread-safe way, but summ is not!
    end
    return summ;
end

for i in 1:10
    println("sum = $(performDumbSum())");
end

println("sum actually = $(sum(a))");

# sum = 1001.3206202277756
# sum = 909.5999577599553
# sum = 843.6142288403219
# sum = 845.78559332991
# sum = 847.3213181575884
# sum = 832.1339487551263
# sum = 841.0003860921729
# sum = 833.2771066887144
# sum = 832.9822518979034
# sum = 831.2454683376488
# sum actually = 4983.574431143589
