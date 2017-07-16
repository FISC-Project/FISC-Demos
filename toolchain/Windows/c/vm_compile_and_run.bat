@CD "%~dp0"\..\..\
@ECHO OFF
@CLS


@rm build/*.ll
@rm build/*.s
@rm bin/*.o

@toolchain\Windows\Tools\clang -Werror=implicit-function-declaration -fwritable-strings -nostdlib -nostdinc -ffreestanding -fno-builtin -target fisc-unknown-unknown -Ilib\c -S lib\c\entry.c -emit-llvm -o build\entry.ll


@toolchain\Windows\Tools\clang -Werror=implicit-function-declaration -fwritable-strings -nostdlib -nostdinc -ffreestanding -fno-builtin -target fisc-unknown-unknown -Ilib\c -S testbench\c\%~nx1 -emit-llvm -o build\%~nx1.ll
@toolchain\Windows\Tools\llvm-link -S -f build\entry.ll build\%~nx1.ll -o build\a.ll


@toolchain\Windows\Tools\llc -march=fisc -relocation-model=static -filetype=obj -o bin\a.o build\a.ll





@toolchain\Windows\Tools\fvm -t FISC -d --nodbgexec --dump reg -c -b bin\a.o

@CD "%~dp0"