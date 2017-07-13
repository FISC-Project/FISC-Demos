@CD "%~dp0"\..\..\
@ECHO OFF
@CLS


@rm bin/*.o

@toolchain\Windows\Tools\flasm testbench\assembly\%~nx1 -o bin\a.o
@toolchain\Windows\Tools\fvm -t FISC -d --dump reg.10 --dump mem.0..8.32 -c -b bin\a.o