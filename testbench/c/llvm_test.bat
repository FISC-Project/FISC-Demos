@CD "%~dp0"\..\..\
@ECHO OFF
@CLS

SET WINTOOLS=toolchain\Windows\Tools
SET PRINTF=%WINTOOLS%\printf
SET CC=%WINTOOLS%\clang
SET BCC=%WINTOOLS%\llc
SET MCC=%WINTOOLS%\llvm-mc
SET ODUMP=%WINTOOLS%\llvm-objdump
SET USEASM=1
SET USEDEBUG=0
SET DEBUGTYPE=view-sched-dags
SET DEBUGPASS=Executions

@rm build/*.ll>nul 2>&1

@rm build/*.s>nul 2>&1
@rm bin/*.o>nul 2>&1

@%PRINTF% "1> Compiling C -> LLVM IR (.ll)"
@%CC% -Werror=implicit-function-declaration -fwritable-strings -nostdlib -nostdinc -ffreestanding -fno-builtin -target fisc-unknown-unknown -Ilib\c -S testbench\c\%~nx1 -emit-llvm -o build\%~nx1.ll

if NOT %USEASM%==0 (
	@GOTO:DO_ASM
)

if NOT %USEDEBUG%==0 (
	@GOTO:DO_C_DEBUG
)

@%PRINTF% "\n2> Compiling LLVM IR (.ll) -> ELF Object file (.o)\n"
@%BCC% -march=fisc -filetype=obj -o bin\%~nx1.o build\%~nx1.ll
@GOTO:CONTINUE

:DO_C_DEBUG
@%PRINTF% "\n2> Compiling LLVM IR (.ll) -> ELF Object file (.o) [DEBUG MODE]\n"
@%BCC% -%DEBUGTYPE% -debug -debug-pass=%DEBUGPASS% -march=fisc -filetype=obj -o bin\%~nx1.o build\%~nx1.ll
@move %appdata%\..\Local\Temp\dag.*dot.pdf results\dag-graphs\
@GOTO:CONTINUE

:DO_ASM

if NOT %USEDEBUG%==0 (
	@GOTO:DO_ASM_DEBUG
)

@%PRINTF% "\n2> Compiling LLVM IR (.ll) -> Assembly GAS-format (.s)\n"
@%BCC% -march=fisc -filetype=asm -o build\%~nx1.s build\%~nx1.ll
@GOTO:DO_ASM_CONTINUE

:DO_ASM_DEBUG
@%BCC% -%DEBUGTYPE% -debug -debug-pass=%DEBUGPASS% -march=fisc -filetype=asm -o bin\%~nx1.s build\%~nx1.ll
@move %appdata%\..\Local\Temp\dag.*dot.pdf results\dag-graphs\

:DO_ASM_CONTINUE
@%PRINTF% "3> Assembling (GAS-Format .s) -> ELF Object File (.o)\n"
@%MCC% -arch=fisc -filetype=obj -o bin\%~nx1.o build\%~nx1.s

:CONTINUE

@%PRINTF% "====================================\nC File Contents\n====================================\n"
@cat testbench\c\%~nx1
@%PRINTF% "====================================\nLLVM IR (.ll) Contents\n====================================\n"
@cat build\%~nx1.ll
@%PRINTF% "====================================\nAssembly GAS-Format (.s) Contents\n====================================\n"
@cat build\%~nx1.s
@%PRINTF% "====================================\nELF Object File Information\n====================================\n"
@readelf -a -W bin\%~nx1.o
@%ODUMP% -s bin\%~nx1.o
@%PRINTF% "====================================\nDisassembling ELF Object File\n====================================\n"
@%ODUMP% -d bin\%~nx1.o
@%PRINTF% "====================================\n\n> Done!\n"

@CD "%~dp0"