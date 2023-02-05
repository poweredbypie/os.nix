if test (count $argv) != "1"
    echo "Wrong number of arguments!"
    echo "Usage: cd.store [bin]"
    return
end

set bin "$argv[1]"
set path (which "$bin" 2> /dev/null)

if test "$path" = ""
    echo "Couldn't find $bin on path."
    return
end

cd (dirname (readlink "$path"))
