@CLS



@rm build/*.ll



@rm build/*.s
@rm bin/*.o

@rustc --emit=llvm-ir -o a.ll prog.rs

@..\toolchain\Windows\Tools\llc -march=fisc -filetype=obj -o a.o a.ll

@readelf -a -W a.o


@..\toolchain\Windows\Tools\llvm-objdump -s -d a.o

@CD "%~dp0"