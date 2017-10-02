if test -d ~/esp/xtensa-esp32-elf/bin
   set -g -x PATH $PATH ~/esp/xtensa-esp32-elf/bin
end

if test -d ~/esp/esp-idf
   set -g -x IDF_PATH ~/esp/esp-idf
end
