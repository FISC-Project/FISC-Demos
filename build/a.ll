; ModuleID = 'llvm-link'
target datalayout = "E-p:32:32-i1:8:64-i8:8:64-i16:16:64-i32:32:64-f64:64-a:0:64-n64"
target triple = "fisc-unknown-unknown"

%struct.IO = type { %struct.anon, %struct.anon.0 }
%struct.anon = type { i8, i8, i8, i8, i8, i8, i8, i8 }
%struct.anon.0 = type { i8, i8, i8, i32 }

@alloc_head = global i32 131072, section ".data", align 4
@io = internal global %struct.IO* inttoptr (i64 20480 to %struct.IO*), section ".data", align 4
@.str = private unnamed_addr global [58 x i8] c"\0A________________________________________________________\00", align 1
@.str.1 = private unnamed_addr global [45 x i8] c"\0A\0A            W E L C O M E    T O    T H E \00", align 1
@.str.2 = private unnamed_addr global [52 x i8] c"\0A      F I S C    V I R T U A L      M A C H I N E\0A\00", align 1
@.str.3 = private unnamed_addr global [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr global [3 x i8] c"\0A\0A\00", align 1
@.str.5 = private unnamed_addr global [39 x i8] c"\0A\0A> Closing the FISC CPU ...\0A> Goodbye\00", align 1
@.str.6 = private unnamed_addr global [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr global [7 x i8] c"(null)\00", align 1
@.str.8 = private unnamed_addr global [28 x i8] c"\0APress the 'q' key to quit\0A\00", align 1
@start.buff = internal global [10 x i8] zeroinitializer, section ".data", align 1
@.str.9 = private unnamed_addr global [9 x i8] c"Text: %s\00", align 1
@.str.10 = private unnamed_addr global [10 x i8] c"formatted\00", align 1

; Function Attrs: nounwind
define i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 4
  call void @start() #2
  call void asm sideeffect "bl 0", ""() #1, !srcloc !1
  ret i32 0
}

; Function Attrs: nounwind
define i32 @strlen(i8* %str) #0 {
entry:
  %str.addr = alloca i8*, align 4
  %size = alloca i32, align 4
  store i8* %str, i8** %str.addr, align 4
  store i32 0, i32* %size, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32, i32* %size, align 4
  %1 = load i8*, i8** %str.addr, align 4
  %arrayidx = getelementptr inbounds i8, i8* %1, i32 %0
  %2 = load i8, i8* %arrayidx, align 1
  %conv = sext i8 %2 to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %3 = load i32, i32* %size, align 4
  %inc = add i32 %3, 1
  store i32 %inc, i32* %size, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %4 = load i32, i32* %size, align 4
  ret i32 %4
}

; Function Attrs: nounwind
define void @wait_stdout_flush() #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole = getelementptr inbounds %struct.IO, %struct.IO* %0, i32 0, i32 0
  %wrRdy = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole, i32 0, i32 5
  %1 = load i8, i8* %wrRdy, align 1
  %tobool = icmp ne i8 %1, 0
  %lnot = xor i1 %tobool, true
  br i1 %lnot, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret void
}

; Function Attrs: nounwind
define void @putc(i8 signext %ch) #0 {
entry:
  %ch.addr = alloca i8, align 1
  store i8 %ch, i8* %ch.addr, align 1
  %0 = load i8, i8* %ch.addr, align 1
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 0
  %wr = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole, i32 0, i32 4
  store i8 %0, i8* %wr, align 4
  ret void
}

; Function Attrs: nounwind
define void @puts(i8* %str) #0 {
entry:
  %str.addr = alloca i8*, align 4
  %i = alloca i32, align 4
  store i8* %str, i8** %str.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i8*, i8** %str.addr, align 4
  %call = call i32 @strlen(i8* %1) #2
  %cmp = icmp ult i32 %0, %call
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %3 = load i8*, i8** %str.addr, align 4
  %arrayidx = getelementptr inbounds i8, i8* %3, i32 %2
  %4 = load i8, i8* %arrayidx, align 1
  call void @putc(i8 signext %4) #2
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4
  %inc = add i32 %5, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind
define signext i8 @kbhit() #0 {
entry:
  %0 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole = getelementptr inbounds %struct.IO, %struct.IO* %0, i32 0, i32 0
  %rdRdy = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole, i32 0, i32 7
  %1 = load i8, i8* %rdRdy, align 1
  ret i8 %1
}

; Function Attrs: nounwind
define signext i8 @getch() #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %call = call signext i8 @kbhit() #2
  %tobool = icmp ne i8 %call, 0
  %lnot = xor i1 %tobool, true
  br i1 %lnot, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %0 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole = getelementptr inbounds %struct.IO, %struct.IO* %0, i32 0, i32 0
  %rd = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole, i32 0, i32 6
  %1 = load i8, i8* %rd, align 2
  ret i8 %1
}

; Function Attrs: nounwind
define signext i8 @getch_async() #0 {
entry:
  %0 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole = getelementptr inbounds %struct.IO, %struct.IO* %0, i32 0, i32 0
  %rd = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole, i32 0, i32 6
  %1 = load i8, i8* %rd, align 2
  ret i8 %1
}

; Function Attrs: nounwind
define i8* @malloc(i32 %size) #0 {
entry:
  %size.addr = alloca i32, align 4
  %thisloc = alloca i32, align 4
  store i32 %size, i32* %size.addr, align 4
  %0 = load i32, i32* @alloc_head, align 4
  store i32 %0, i32* %thisloc, align 4
  %1 = load i32, i32* %size.addr, align 4
  %2 = load i32, i32* @alloc_head, align 4
  %add = add i32 %2, %1
  store i32 %add, i32* @alloc_head, align 4
  %3 = load i32, i32* %thisloc, align 4
  %4 = inttoptr i32 %3 to i8*
  ret i8* %4
}

; Function Attrs: nounwind
define i8* @memcpy(i8* %dst, i8* %src, i32 %len) #0 {
entry:
  %dst.addr = alloca i8*, align 4
  %src.addr = alloca i8*, align 4
  %len.addr = alloca i32, align 4
  %dst_ = alloca i8*, align 4
  %src_ = alloca i8*, align 4
  %i = alloca i32, align 4
  store i8* %dst, i8** %dst.addr, align 4
  store i8* %src, i8** %src.addr, align 4
  store i32 %len, i32* %len.addr, align 4
  %0 = load i8*, i8** %dst.addr, align 4
  store i8* %0, i8** %dst_, align 4
  %1 = load i8*, i8** %src.addr, align 4
  store i8* %1, i8** %src_, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4
  %3 = load i32, i32* %len.addr, align 4
  %cmp = icmp ult i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32, i32* %i, align 4
  %5 = load i8*, i8** %src_, align 4
  %arrayidx = getelementptr inbounds i8, i8* %5, i32 %4
  %6 = load i8, i8* %arrayidx, align 1
  %7 = load i32, i32* %i, align 4
  %8 = load i8*, i8** %dst_, align 4
  %arrayidx1 = getelementptr inbounds i8, i8* %8, i32 %7
  store i8 %6, i8* %arrayidx1, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %9 = load i32, i32* %i, align 4
  %inc = add i32 %9, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %10 = load i8*, i8** %dst.addr, align 4
  ret i8* %10
}

; Function Attrs: nounwind
define i8* @memset(i8* %dst, i32 %val, i32 %len) #0 {
entry:
  %dst.addr = alloca i8*, align 4
  %val.addr = alloca i32, align 4
  %len.addr = alloca i32, align 4
  %dst_ = alloca i8*, align 4
  %i = alloca i32, align 4
  store i8* %dst, i8** %dst.addr, align 4
  store i32 %val, i32* %val.addr, align 4
  store i32 %len, i32* %len.addr, align 4
  %0 = load i8*, i8** %dst.addr, align 4
  store i8* %0, i8** %dst_, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4
  %2 = load i32, i32* %len.addr, align 4
  %cmp = icmp ult i32 %1, %2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %val.addr, align 4
  %conv = trunc i32 %3 to i8
  %4 = load i32, i32* %i, align 4
  %5 = load i8*, i8** %dst_, align 4
  %arrayidx = getelementptr inbounds i8, i8* %5, i32 %4
  store i8 %conv, i8* %arrayidx, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4
  %inc = add i32 %6, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %7 = load i8*, i8** %dst.addr, align 4
  ret i8* %7
}

; Function Attrs: nounwind
define void @initialize_stdout() #0 {
entry:
  %0 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole = getelementptr inbounds %struct.IO, %struct.IO* %0, i32 0, i32 0
  %enDev = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole, i32 0, i32 0
  store i8 1, i8* %enDev, align 4
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole1 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 0
  %enWr = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole1, i32 0, i32 1
  store i8 1, i8* %enWr, align 1
  ret void
}

; Function Attrs: nounwind
define void @initialize_stdin() #0 {
entry:
  %0 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole = getelementptr inbounds %struct.IO, %struct.IO* %0, i32 0, i32 0
  %enDev = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole, i32 0, i32 0
  store i8 1, i8* %enDev, align 4
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %VMConsole1 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 0
  %enRd = getelementptr inbounds %struct.anon, %struct.anon* %VMConsole1, i32 0, i32 2
  store i8 1, i8* %enRd, align 2
  ret void
}

; Function Attrs: nounwind
define void @enable_timer() #0 {
entry:
  %0 = load %struct.IO*, %struct.IO** @io, align 4
  %Timer = getelementptr inbounds %struct.IO, %struct.IO* %0, i32 0, i32 1
  %enDev = getelementptr inbounds %struct.anon.0, %struct.anon.0* %Timer, i32 0, i32 0
  store i8 1, i8* %enDev, align 4
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %Timer1 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 1
  %enTimer = getelementptr inbounds %struct.anon.0, %struct.anon.0* %Timer1, i32 0, i32 1
  store i8 1, i8* %enTimer, align 1
  ret void
}

; Function Attrs: nounwind
define void @initialize_fisc_machine() #0 {
entry:
  call void @initialize_stdout() #2
  call void @initialize_stdin() #2
  ret void
}

; Function Attrs: nounwind
define void @showHeaderFooterLine() #0 {
entry:
  call void @puts(i8* getelementptr inbounds ([58 x i8], [58 x i8]* @.str, i32 0, i32 0)) #2
  ret void
}

; Function Attrs: nounwind
define void @welcome() #0 {
entry:
  call void @initialize_fisc_machine() #2
  call void @showHeaderFooterLine() #2
  call void @puts(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.1, i32 0, i32 0)) #2
  call void @puts(i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.2, i32 0, i32 0)) #2
  call void @showHeaderFooterLine() #2
  call void @puts(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0)) #2
  ret void
}

; Function Attrs: nounwind
define void @goodbye() #0 {
entry:
  call void @puts(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0)) #2
  call void @showHeaderFooterLine() #2
  call void @puts(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0)) #2
  call void @showHeaderFooterLine() #2
  call void @puts(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i32 0, i32 0)) #2
  ret void
}

; Function Attrs: nounwind
define i32 @vasprintf(i8* %buf, i8* %fmt, i8* %args) #0 {
entry:
  %buf.addr = alloca i8*, align 4
  %fmt.addr = alloca i8*, align 4
  %args.addr = alloca i8*, align 4
  %i = alloca i32, align 4
  %s = alloca i8*, align 4
  %b = alloca i8*, align 4
  %f = alloca i8*, align 4
  %arg_width = alloca i32, align 4
  %varet = alloca i8*, align 4
  %varet23 = alloca i32, align 4
  %varet27 = alloca i32, align 4
  %varet32 = alloca i32, align 4
  store i8* %buf, i8** %buf.addr, align 4
  store i8* %fmt, i8** %fmt.addr, align 4
  store i8* %args, i8** %args.addr, align 4
  store i32 0, i32* %i, align 4
  %0 = load i8*, i8** %buf.addr, align 4
  store i8* %0, i8** %b, align 4
  %1 = load i8*, i8** %fmt.addr, align 4
  store i8* %1, i8** %f, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i8*, i8** %f, align 4
  %3 = load i8, i8* %2, align 1
  %tobool = icmp ne i8 %3, 0
  br i1 %tobool, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i8*, i8** %f, align 4
  %5 = load i8, i8* %4, align 1
  %conv = sext i8 %5 to i32
  %cmp = icmp ne i32 %conv, 37
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %6 = load i8*, i8** %f, align 4
  %7 = load i8, i8* %6, align 1
  %8 = load i8*, i8** %b, align 4
  %incdec.ptr = getelementptr inbounds i8, i8* %8, i32 1
  store i8* %incdec.ptr, i8** %b, align 4
  store i8 %7, i8* %8, align 1
  br label %for.inc

if.end:                                           ; preds = %for.body
  %9 = load i8*, i8** %f, align 4
  %incdec.ptr2 = getelementptr inbounds i8, i8* %9, i32 1
  store i8* %incdec.ptr2, i8** %f, align 4
  store i32 0, i32* %arg_width, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end
  %10 = load i8*, i8** %f, align 4
  %11 = load i8, i8* %10, align 1
  %conv3 = sext i8 %11 to i32
  %cmp4 = icmp sge i32 %conv3, 48
  br i1 %cmp4, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %12 = load i8*, i8** %f, align 4
  %13 = load i8, i8* %12, align 1
  %conv6 = sext i8 %13 to i32
  %cmp7 = icmp sle i32 %conv6, 57
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %14 = phi i1 [ false, %while.cond ], [ %cmp7, %land.rhs ]
  br i1 %14, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %15 = load i32, i32* %arg_width, align 4
  %mul = mul i32 %15, 10
  store i32 %mul, i32* %arg_width, align 4
  %16 = load i8*, i8** %f, align 4
  %17 = load i8, i8* %16, align 1
  %conv9 = sext i8 %17 to i32
  %sub = sub nsw i32 %conv9, 48
  %18 = load i32, i32* %arg_width, align 4
  %add = add i32 %18, %sub
  store i32 %add, i32* %arg_width, align 4
  %19 = load i8*, i8** %f, align 4
  %incdec.ptr10 = getelementptr inbounds i8, i8* %19, i32 1
  store i8* %incdec.ptr10, i8** %f, align 4
  br label %while.cond

while.end:                                        ; preds = %land.end
  %20 = load i8*, i8** %f, align 4
  %21 = load i8, i8* %20, align 1
  %conv11 = sext i8 %21 to i32
  switch i32 %conv11, label %sw.default [
    i32 115, label %sw.bb
    i32 99, label %sw.bb22
    i32 120, label %sw.bb26
    i32 100, label %sw.bb28
    i32 37, label %sw.bb34
  ]

sw.bb:                                            ; preds = %while.end
  %22 = va_arg i8** %args.addr, i8*
  store i8* %22, i8** %varet, align 4
  %23 = load i8*, i8** %varet, align 4
  store i8* %23, i8** %s, align 4
  %24 = load i8*, i8** %s, align 4
  %cmp12 = icmp eq i8* %24, null
  br i1 %cmp12, label %if.then14, label %if.end15

if.then14:                                        ; preds = %sw.bb
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i32 0, i32 0), i8** %s, align 4
  br label %if.end15

if.end15:                                         ; preds = %if.then14, %sw.bb
  br label %while.cond16

while.cond16:                                     ; preds = %while.body18, %if.end15
  %25 = load i8*, i8** %s, align 4
  %26 = load i8, i8* %25, align 1
  %tobool17 = icmp ne i8 %26, 0
  br i1 %tobool17, label %while.body18, label %while.end21

while.body18:                                     ; preds = %while.cond16
  %27 = load i8*, i8** %s, align 4
  %incdec.ptr19 = getelementptr inbounds i8, i8* %27, i32 1
  store i8* %incdec.ptr19, i8** %s, align 4
  %28 = load i8, i8* %27, align 1
  %29 = load i8*, i8** %b, align 4
  %incdec.ptr20 = getelementptr inbounds i8, i8* %29, i32 1
  store i8* %incdec.ptr20, i8** %b, align 4
  store i8 %28, i8* %29, align 1
  br label %while.cond16

while.end21:                                      ; preds = %while.cond16
  br label %sw.epilog

sw.bb22:                                          ; preds = %while.end
  %30 = va_arg i8** %args.addr, i32
  store i32 %30, i32* %varet23, align 4
  %31 = load i32, i32* %varet23, align 4
  %conv24 = trunc i32 %31 to i8
  %32 = load i8*, i8** %b, align 4
  %incdec.ptr25 = getelementptr inbounds i8, i8* %32, i32 1
  store i8* %incdec.ptr25, i8** %b, align 4
  store i8 %conv24, i8* %32, align 1
  br label %sw.epilog

sw.bb26:                                          ; preds = %while.end
  %33 = load i8*, i8** %b, align 4
  %34 = load i8*, i8** %buf.addr, align 4
  %sub.ptr.lhs.cast = ptrtoint i8* %33 to i32
  %sub.ptr.rhs.cast = ptrtoint i8* %34 to i32
  %sub.ptr.sub = sub i32 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  store i32 %sub.ptr.sub, i32* %i, align 4
  %35 = va_arg i8** %args.addr, i32
  store i32 %35, i32* %varet27, align 4
  %36 = load i32, i32* %varet27, align 4
  %37 = load i32, i32* %arg_width, align 4
  %38 = load i8*, i8** %buf.addr, align 4
  call void @print_hex(i32 %36, i32 %37, i8* %38, i32* %i) #2
  %39 = load i8*, i8** %buf.addr, align 4
  %40 = load i32, i32* %i, align 4
  %add.ptr = getelementptr inbounds i8, i8* %39, i32 %40
  store i8* %add.ptr, i8** %b, align 4
  br label %sw.epilog

sw.bb28:                                          ; preds = %while.end
  %41 = load i8*, i8** %b, align 4
  %42 = load i8*, i8** %buf.addr, align 4
  %sub.ptr.lhs.cast29 = ptrtoint i8* %41 to i32
  %sub.ptr.rhs.cast30 = ptrtoint i8* %42 to i32
  %sub.ptr.sub31 = sub i32 %sub.ptr.lhs.cast29, %sub.ptr.rhs.cast30
  store i32 %sub.ptr.sub31, i32* %i, align 4
  %43 = va_arg i8** %args.addr, i32
  store i32 %43, i32* %varet32, align 4
  %44 = load i32, i32* %varet32, align 4
  %45 = load i32, i32* %arg_width, align 4
  %46 = load i8*, i8** %buf.addr, align 4
  call void @print_dec(i32 %44, i32 %45, i8* %46, i32* %i) #2
  %47 = load i8*, i8** %buf.addr, align 4
  %48 = load i32, i32* %i, align 4
  %add.ptr33 = getelementptr inbounds i8, i8* %47, i32 %48
  store i8* %add.ptr33, i8** %b, align 4
  br label %sw.epilog

sw.bb34:                                          ; preds = %while.end
  %49 = load i8*, i8** %b, align 4
  %incdec.ptr35 = getelementptr inbounds i8, i8* %49, i32 1
  store i8* %incdec.ptr35, i8** %b, align 4
  store i8 37, i8* %49, align 1
  br label %sw.epilog

sw.default:                                       ; preds = %while.end
  %50 = load i8*, i8** %f, align 4
  %51 = load i8, i8* %50, align 1
  %52 = load i8*, i8** %b, align 4
  %incdec.ptr36 = getelementptr inbounds i8, i8* %52, i32 1
  store i8* %incdec.ptr36, i8** %b, align 4
  store i8 %51, i8* %52, align 1
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb34, %sw.bb28, %sw.bb26, %sw.bb22, %while.end21
  br label %for.inc

for.inc:                                          ; preds = %sw.epilog, %if.then
  %53 = load i8*, i8** %f, align 4
  %incdec.ptr37 = getelementptr inbounds i8, i8* %53, i32 1
  store i8* %incdec.ptr37, i8** %f, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %54 = load i8*, i8** %b, align 4
  store i8 0, i8* %54, align 1
  %55 = load i8*, i8** %b, align 4
  %56 = load i8*, i8** %buf.addr, align 4
  %sub.ptr.lhs.cast38 = ptrtoint i8* %55 to i32
  %sub.ptr.rhs.cast39 = ptrtoint i8* %56 to i32
  %sub.ptr.sub40 = sub i32 %sub.ptr.lhs.cast38, %sub.ptr.rhs.cast39
  ret i32 %sub.ptr.sub40
}

; Function Attrs: nounwind
define internal void @print_hex(i32 %value, i32 %width, i8* %buf, i32* %ptr) #0 {
entry:
  %value.addr = alloca i32, align 4
  %width.addr = alloca i32, align 4
  %buf.addr = alloca i8*, align 4
  %ptr.addr = alloca i32*, align 4
  store i32 %value, i32* %value.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  store i8* %buf, i8** %buf.addr, align 4
  store i32* %ptr, i32** %ptr.addr, align 4
  ret void
}

; Function Attrs: nounwind
define internal void @print_dec(i32 %value, i32 %width, i8* %buf, i32* %ptr) #0 {
entry:
  %value.addr = alloca i32, align 4
  %width.addr = alloca i32, align 4
  %buf.addr = alloca i8*, align 4
  %ptr.addr = alloca i32*, align 4
  store i32 %value, i32* %value.addr, align 4
  store i32 %width, i32* %width.addr, align 4
  store i8* %buf, i8** %buf.addr, align 4
  store i32* %ptr, i32** %ptr.addr, align 4
  ret void
}

; Function Attrs: nounwind
define i32 @sprintf(i8* %buf, i8* %fmt, ...) #0 {
entry:
  %buf.addr = alloca i8*, align 4
  %fmt.addr = alloca i8*, align 4
  %args = alloca i8*, align 4
  %out = alloca i32, align 4
  store i8* %buf, i8** %buf.addr, align 4
  store i8* %fmt, i8** %fmt.addr, align 4
  %args1 = bitcast i8** %args to i8*
  call void @llvm.va_start(i8* %args1)
  %0 = load i8*, i8** %buf.addr, align 4
  %1 = load i8*, i8** %fmt.addr, align 4
  %2 = load i8*, i8** %args, align 4
  %call = call i32 @vasprintf(i8* %0, i8* %1, i8* %2) #2
  store i32 %call, i32* %out, align 4
  %args2 = bitcast i8** %args to i8*
  call void @llvm.va_end(i8* %args2)
  %3 = load i32, i32* %out, align 4
  ret i32 %3
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind
define void @start() #0 {
entry:
  %__st1__ = alloca i8, align 1
  %__st2__ = alloca i8, align 1
  %__st3__ = alloca i8, align 1
  %__st4__ = alloca i8, align 1
  %__st5__ = alloca i8, align 1
  %__st6__ = alloca i8, align 1
  %__st7__ = alloca i8, align 1
  %__st8__ = alloca i8, align 1
  %__st9__ = alloca i8, align 1
  %__st10__ = alloca i8, align 1
  %__st11__ = alloca i8, align 1
  %__st12__ = alloca i8, align 1
  %__st13__ = alloca i8, align 1
  %__st14__ = alloca i8, align 1
  %__st15__ = alloca i8, align 1
  %__st16__ = alloca i8, align 1
  %__st17__ = alloca i8, align 1
  %__st18__ = alloca i8, align 1
  %__st19__ = alloca i8, align 1
  %__st20__ = alloca i8, align 1
  %ch = alloca i8, align 1
  call void @welcome() #2
  call void @puts(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.8, i32 0, i32 0)) #2
  %call = call i32 (i8*, i8*, ...) @sprintf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @start.buff, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.9, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.10, i32 0, i32 0)) #2
  br label %while.body

while.body:                                       ; preds = %if.end, %entry
  %call1 = call signext i8 @getch() #2
  store i8 %call1, i8* %ch, align 1
  %0 = load i8, i8* %ch, align 1
  %conv = sext i8 %0 to i32
  %cmp = icmp eq i32 %conv, 113
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  %1 = load i8, i8* %ch, align 1
  call void @putc(i8 signext %1) #2
  br label %while.body

while.end:                                        ; preds = %if.then
  call void @goodbye() #2
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nobuiltin }

!llvm.ident = !{!0, !0}

!0 = !{!"clang version 3.8.1 "}
!1 = !{i32 -2147473924}
