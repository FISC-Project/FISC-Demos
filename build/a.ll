; ModuleID = 'llvm-link'
target datalayout = "E-p:64:64:64-i1:8:64-i8:8:64-i16:16:64-i32:32:64-f64:64-a:0:64-n64"
target triple = "fisc-unknown-unknown"

%struct.IO = type { %struct.anon, %struct.anon.0, %struct.anon.1 }
%struct.anon = type { i8, i8, i8, i8, i8, i8, i8, i8 }
%struct.anon.0 = type <{ i8, i8, i32, i8 }>
%struct.anon.1 = type <{ i8, i8, i16, i16, i8, i8, i8, [50 x i64] }>
%struct.rgbpack_t = type { %struct.rgb_t, %struct.rgb_t }
%struct.rgb_t = type { i8, i8, i8, i8 }

@alloc_head = global i32 131072, section ".data", align 4
@io = internal global %struct.IO* inttoptr (i64 20480 to %struct.IO*), section ".data", align 4
@video_render_counter = internal global i32 0, section ".data", align 4
@.str = private unnamed_addr global [58 x i8] c"\0A________________________________________________________\00", align 1
@.str.1 = private unnamed_addr global [45 x i8] c"\0A\0A            W E L C O M E    T O    T H E \00", align 1
@.str.2 = private unnamed_addr global [52 x i8] c"\0A      F I S C    V I R T U A L      M A C H I N E\0A\00", align 1
@.str.3 = private unnamed_addr global [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr global [3 x i8] c"\0A\0A\00", align 1
@.str.5 = private unnamed_addr global [39 x i8] c"\0A\0A> Closing the FISC CPU ...\0A> Goodbye\00", align 1
@.str.6 = private unnamed_addr global [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr global [7 x i8] c"(null)\00", align 1
@video_colorinfo = internal global i64 0, section ".data", align 8
@video_y = internal global i16 0, section ".data", align 2
@video_x = internal global i16 0, section ".data", align 2
@.str.8 = private unnamed_addr global [30 x i8] c"\0AAvailable Options:\0Aq- Quit\0A\0A\00", align 1

; Function Attrs: nounwind
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 4
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 4
  call void @start() #2
  call void asm sideeffect "bl 0", ""() #1, !srcloc !1
  ret i32 0
}

; Function Attrs: nounwind
define i32 @strlen(i8* %str) #0 {
  %1 = alloca i8*, align 4
  %size = alloca i32, align 4
  store i8* %str, i8** %1, align 4
  store i32 0, i32* %size, align 4
  br label %2

; <label>:2                                       ; preds = %9, %0
  %3 = load i32, i32* %size, align 4
  %4 = load i8*, i8** %1, align 4
  %5 = getelementptr inbounds i8, i8* %4, i32 %3
  %6 = load i8, i8* %5, align 1
  %7 = sext i8 %6 to i32
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %12

; <label>:9                                       ; preds = %2
  %10 = load i32, i32* %size, align 4
  %11 = add i32 %10, 1
  store i32 %11, i32* %size, align 4
  br label %2

; <label>:12                                      ; preds = %2
  %13 = load i32, i32* %size, align 4
  ret i32 %13
}

; Function Attrs: nounwind
define void @wait_stdout_flush() #0 {
  br label %1

; <label>:1                                       ; preds = %8, %0
  %2 = load %struct.IO*, %struct.IO** @io, align 4
  %3 = getelementptr inbounds %struct.IO, %struct.IO* %2, i32 0, i32 0
  %4 = getelementptr inbounds %struct.anon, %struct.anon* %3, i32 0, i32 5
  %5 = load i8, i8* %4, align 1
  %6 = icmp ne i8 %5, 0
  %7 = xor i1 %6, true
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %1
  br label %1

; <label>:9                                       ; preds = %1
  ret void
}

; Function Attrs: nounwind
define void @putc(i8 signext %ch) #0 {
  %1 = alloca i8, align 1
  store i8 %ch, i8* %1, align 1
  %2 = load i8, i8* %1, align 1
  %3 = load %struct.IO*, %struct.IO** @io, align 4
  %4 = getelementptr inbounds %struct.IO, %struct.IO* %3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 4
  store i8 %2, i8* %5, align 1
  ret void
}

; Function Attrs: nounwind
define void @puts(i8* %str) #0 {
  %1 = alloca i8*, align 4
  %i = alloca i32, align 4
  store i8* %str, i8** %1, align 4
  store i32 0, i32* %i, align 4
  br label %2

; <label>:2                                       ; preds = %12, %0
  %3 = load i32, i32* %i, align 4
  %4 = load i8*, i8** %1, align 4
  %5 = call i32 @strlen(i8* %4) #2
  %6 = icmp ult i32 %3, %5
  br i1 %6, label %7, label %15

; <label>:7                                       ; preds = %2
  %8 = load i32, i32* %i, align 4
  %9 = load i8*, i8** %1, align 4
  %10 = getelementptr inbounds i8, i8* %9, i32 %8
  %11 = load i8, i8* %10, align 1
  call void @putc(i8 signext %11) #2
  br label %12

; <label>:12                                      ; preds = %7
  %13 = load i32, i32* %i, align 4
  %14 = add i32 %13, 1
  store i32 %14, i32* %i, align 4
  br label %2

; <label>:15                                      ; preds = %2
  ret void
}

; Function Attrs: nounwind
define signext i8 @kbhit() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 0
  %3 = getelementptr inbounds %struct.anon, %struct.anon* %2, i32 0, i32 7
  %4 = load i8, i8* %3, align 1
  ret i8 %4
}

; Function Attrs: nounwind
define signext i8 @getch() #0 {
  br label %1

; <label>:1                                       ; preds = %5, %0
  %2 = call signext i8 @kbhit() #2
  %3 = icmp ne i8 %2, 0
  %4 = xor i1 %3, true
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %1
  br label %1

; <label>:6                                       ; preds = %1
  %7 = load %struct.IO*, %struct.IO** @io, align 4
  %8 = getelementptr inbounds %struct.IO, %struct.IO* %7, i32 0, i32 0
  %9 = getelementptr inbounds %struct.anon, %struct.anon* %8, i32 0, i32 6
  %10 = load i8, i8* %9, align 1
  ret i8 %10
}

; Function Attrs: nounwind
define signext i8 @getch_async() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 0
  %3 = getelementptr inbounds %struct.anon, %struct.anon* %2, i32 0, i32 6
  %4 = load i8, i8* %3, align 1
  ret i8 %4
}

; Function Attrs: nounwind
define i8* @malloc(i32 %size) #0 {
  %1 = alloca i32, align 4
  %thisloc = alloca i32, align 4
  store i32 %size, i32* %1, align 4
  %2 = load i32, i32* @alloc_head, align 4
  store i32 %2, i32* %thisloc, align 4
  %3 = load i32, i32* %1, align 4
  %4 = load i32, i32* @alloc_head, align 4
  %5 = add i32 %4, %3
  store i32 %5, i32* @alloc_head, align 4
  %6 = load i32, i32* %thisloc, align 4
  %7 = inttoptr i32 %6 to i8*
  ret i8* %7
}

; Function Attrs: nounwind
define i8* @memcpy(i8* %dst, i8* %src, i32 %len) #0 {
  %1 = alloca i8*, align 4
  %2 = alloca i8*, align 4
  %3 = alloca i32, align 4
  %dst_ = alloca i8*, align 4
  %src_ = alloca i8*, align 4
  %i = alloca i32, align 4
  store i8* %dst, i8** %1, align 4
  store i8* %src, i8** %2, align 4
  store i32 %len, i32* %3, align 4
  %4 = load i8*, i8** %1, align 4
  store i8* %4, i8** %dst_, align 4
  %5 = load i8*, i8** %2, align 4
  store i8* %5, i8** %src_, align 4
  store i32 0, i32* %i, align 4
  br label %6

; <label>:6                                       ; preds = %18, %0
  %7 = load i32, i32* %i, align 4
  %8 = load i32, i32* %3, align 4
  %9 = icmp ult i32 %7, %8
  br i1 %9, label %10, label %21

; <label>:10                                      ; preds = %6
  %11 = load i32, i32* %i, align 4
  %12 = load i8*, i8** %src_, align 4
  %13 = getelementptr inbounds i8, i8* %12, i32 %11
  %14 = load i8, i8* %13, align 1
  %15 = load i32, i32* %i, align 4
  %16 = load i8*, i8** %dst_, align 4
  %17 = getelementptr inbounds i8, i8* %16, i32 %15
  store i8 %14, i8* %17, align 1
  br label %18

; <label>:18                                      ; preds = %10
  %19 = load i32, i32* %i, align 4
  %20 = add i32 %19, 1
  store i32 %20, i32* %i, align 4
  br label %6

; <label>:21                                      ; preds = %6
  %22 = load i8*, i8** %1, align 4
  ret i8* %22
}

; Function Attrs: nounwind
define i8* @memset(i8* %dst, i32 %val, i32 %len) #0 {
  %1 = alloca i8*, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %dst_ = alloca i8*, align 4
  %i = alloca i32, align 4
  store i8* %dst, i8** %1, align 4
  store i32 %val, i32* %2, align 4
  store i32 %len, i32* %3, align 4
  %4 = load i8*, i8** %1, align 4
  store i8* %4, i8** %dst_, align 4
  store i32 0, i32* %i, align 4
  br label %5

; <label>:5                                       ; preds = %15, %0
  %6 = load i32, i32* %i, align 4
  %7 = load i32, i32* %3, align 4
  %8 = icmp ult i32 %6, %7
  br i1 %8, label %9, label %18

; <label>:9                                       ; preds = %5
  %10 = load i32, i32* %2, align 4
  %11 = trunc i32 %10 to i8
  %12 = load i32, i32* %i, align 4
  %13 = load i8*, i8** %dst_, align 4
  %14 = getelementptr inbounds i8, i8* %13, i32 %12
  store i8 %11, i8* %14, align 1
  br label %15

; <label>:15                                      ; preds = %9
  %16 = load i32, i32* %i, align 4
  %17 = add i32 %16, 1
  store i32 %17, i32* %i, align 4
  br label %5

; <label>:18                                      ; preds = %5
  %19 = load i8*, i8** %1, align 4
  ret i8* %19
}

; Function Attrs: nounwind
define signext i8 @video_is_enabled() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 2
  %3 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %2, i32 0, i32 1
  %4 = load i8, i8* %3, align 1
  %5 = sext i8 %4 to i32
  %6 = and i32 %5, 2
  %7 = trunc i32 %6 to i8
  ret i8 %7
}

; Function Attrs: nounwind
define signext i8 @video_is_init() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 2
  %3 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %2, i32 0, i32 1
  %4 = load i8, i8* %3, align 1
  %5 = sext i8 %4 to i32
  %6 = and i32 %5, 4
  %7 = trunc i32 %6 to i8
  ret i8 %7
}

; Function Attrs: nounwind
define void @initialize_video() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 2
  %3 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %2, i32 0, i32 0
  store i8 1, i8* %3, align 1
  %4 = load %struct.IO*, %struct.IO** @io, align 4
  %5 = getelementptr inbounds %struct.IO, %struct.IO* %4, i32 0, i32 2
  %6 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %5, i32 0, i32 2
  store i16 0, i16* %6, align 1
  %7 = load %struct.IO*, %struct.IO** @io, align 4
  %8 = getelementptr inbounds %struct.IO, %struct.IO* %7, i32 0, i32 2
  %9 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %8, i32 0, i32 3
  store i16 0, i16* %9, align 1
  %10 = load %struct.IO*, %struct.IO** @io, align 4
  %11 = getelementptr inbounds %struct.IO, %struct.IO* %10, i32 0, i32 2
  %12 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %11, i32 0, i32 4
  store i8 0, i8* %12, align 1
  %13 = load %struct.IO*, %struct.IO** @io, align 4
  %14 = getelementptr inbounds %struct.IO, %struct.IO* %13, i32 0, i32 2
  %15 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %14, i32 0, i32 5
  store i8 0, i8* %15, align 1
  br label %16

; <label>:16                                      ; preds = %20, %0
  %17 = call signext i8 @video_is_init() #2
  %18 = icmp ne i8 %17, 0
  %19 = xor i1 %18, true
  br i1 %19, label %20, label %21

; <label>:20                                      ; preds = %16
  br label %16

; <label>:21                                      ; preds = %16
  ret void
}

; Function Attrs: nounwind
define void @video_backend_setaddress(i16 zeroext %x, i16 zeroext %y) #0 {
  %1 = alloca i16, align 2
  %2 = alloca i16, align 2
  %ptr = alloca i16*, align 4
  store i16 %x, i16* %1, align 2
  store i16 %y, i16* %2, align 2
  %3 = load %struct.IO*, %struct.IO** @io, align 4
  %4 = getelementptr inbounds %struct.IO, %struct.IO* %3, i32 0, i32 2
  %5 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %4, i32 0, i32 2
  store i16* %5, i16** %ptr, align 4
  %6 = load i16, i16* %1, align 2
  %7 = load i16*, i16** %ptr, align 4
  store i16 %6, i16* %7, align 2
  %8 = load %struct.IO*, %struct.IO** @io, align 4
  %9 = getelementptr inbounds %struct.IO, %struct.IO* %8, i32 0, i32 2
  %10 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %9, i32 0, i32 3
  store i16* %10, i16** %ptr, align 4
  %11 = load i16, i16* %2, align 2
  %12 = load i16*, i16** %ptr, align 4
  store i16 %11, i16* %12, align 2
  ret void
}

; Function Attrs: nounwind
define void @video_pixels_pack(i32 %loc, %struct.rgbpack_t* %rgbpack) #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.rgbpack_t*, align 4
  %rgbpack_64cast = alloca i64*, align 4
  %pxdata_ptr = alloca i64*, align 4
  store i32 %loc, i32* %1, align 4
  store %struct.rgbpack_t* %rgbpack, %struct.rgbpack_t** %2, align 4
  %3 = load %struct.rgbpack_t*, %struct.rgbpack_t** %2, align 4
  %4 = bitcast %struct.rgbpack_t* %3 to i64*
  store i64* %4, i64** %rgbpack_64cast, align 4
  %5 = load %struct.IO*, %struct.IO** @io, align 4
  %6 = getelementptr inbounds %struct.IO, %struct.IO* %5, i32 0, i32 2
  %7 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %6, i32 0, i32 7
  %8 = getelementptr inbounds [50 x i64], [50 x i64]* %7, i32 0, i32 0
  store i64* %8, i64** %pxdata_ptr, align 4
  %9 = load i64*, i64** %rgbpack_64cast, align 4
  %10 = load i64, i64* %9, align 8
  %11 = load i32, i32* %1, align 4
  %12 = load i64*, i64** %pxdata_ptr, align 4
  %13 = getelementptr inbounds i64, i64* %12, i32 %11
  store i64 %10, i64* %13, align 8
  ret void
}

; Function Attrs: nounwind
define void @video_backend_render() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 2
  %3 = getelementptr inbounds %struct.anon.1, %struct.anon.1* %2, i32 0, i32 5
  store i8 1, i8* %3, align 1
  ret void
}

; Function Attrs: nounwind
define void @video_backend_render_block(i32 %blocksize) #0 {
  %1 = alloca i32, align 4
  store i32 %blocksize, i32* %1, align 4
  %2 = load i32, i32* @video_render_counter, align 4
  %3 = add i32 %2, 1
  store i32 %3, i32* @video_render_counter, align 4
  %4 = load i32, i32* %1, align 4
  %5 = icmp uge i32 %2, %4
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  store i32 0, i32* @video_render_counter, align 4
  call void @video_backend_render() #2
  br label %7

; <label>:7                                       ; preds = %6, %0
  ret void
}

; Function Attrs: nounwind
define void @initialize_stdout() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 0
  %3 = getelementptr inbounds %struct.anon, %struct.anon* %2, i32 0, i32 0
  store i8 1, i8* %3, align 1
  %4 = load %struct.IO*, %struct.IO** @io, align 4
  %5 = getelementptr inbounds %struct.IO, %struct.IO* %4, i32 0, i32 0
  %6 = getelementptr inbounds %struct.anon, %struct.anon* %5, i32 0, i32 1
  store i8 1, i8* %6, align 1
  ret void
}

; Function Attrs: nounwind
define void @initialize_stdin() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 0
  %3 = getelementptr inbounds %struct.anon, %struct.anon* %2, i32 0, i32 0
  store i8 1, i8* %3, align 1
  %4 = load %struct.IO*, %struct.IO** @io, align 4
  %5 = getelementptr inbounds %struct.IO, %struct.IO* %4, i32 0, i32 0
  %6 = getelementptr inbounds %struct.anon, %struct.anon* %5, i32 0, i32 2
  store i8 1, i8* %6, align 1
  ret void
}

; Function Attrs: nounwind
define void @enable_timer() #0 {
  %1 = load %struct.IO*, %struct.IO** @io, align 4
  %2 = getelementptr inbounds %struct.IO, %struct.IO* %1, i32 0, i32 1
  %3 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %2, i32 0, i32 0
  store i8 1, i8* %3, align 1
  %4 = load %struct.IO*, %struct.IO** @io, align 4
  %5 = getelementptr inbounds %struct.IO, %struct.IO* %4, i32 0, i32 1
  %6 = getelementptr inbounds %struct.anon.0, %struct.anon.0* %5, i32 0, i32 1
  store i8 1, i8* %6, align 1
  ret void
}

; Function Attrs: nounwind
define void @initialize_fisc_machine() #0 {
  call void @initialize_stdout() #2
  call void @initialize_stdin() #2
  call void @initialize_video() #2
  ret void
}

; Function Attrs: nounwind
define void @showHeaderFooterLine() #0 {
  call void @puts(i8* getelementptr inbounds ([58 x i8], [58 x i8]* @.str, i32 0, i32 0)) #2
  ret void
}

; Function Attrs: nounwind
define void @welcome() #0 {
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
  call void @puts(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0)) #2
  call void @showHeaderFooterLine() #2
  call void @puts(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.5, i32 0, i32 0)) #2
  call void @showHeaderFooterLine() #2
  call void @puts(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i32 0, i32 0)) #2
  ret void
}

; Function Attrs: nounwind
define i32 @vasprintf(i8* %buf, i8* %fmt, i8* %args) #0 {
  %1 = alloca i8*, align 4
  %2 = alloca i8*, align 4
  %3 = alloca i8*, align 4
  %i = alloca i32, align 4
  %s = alloca i8*, align 4
  %b = alloca i8*, align 4
  %f = alloca i8*, align 4
  %arg_width = alloca i32, align 4
  %4 = alloca i8*, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i8* %buf, i8** %1, align 4
  store i8* %fmt, i8** %2, align 4
  store i8* %args, i8** %3, align 4
  store i32 0, i32* %i, align 4
  %8 = load i8*, i8** %1, align 4
  store i8* %8, i8** %b, align 4
  %9 = load i8*, i8** %2, align 4
  store i8* %9, i8** %f, align 4
  br label %10

; <label>:10                                      ; preds = %113, %0
  %11 = load i8*, i8** %f, align 4
  %12 = load i8, i8* %11, align 1
  %13 = icmp ne i8 %12, 0
  br i1 %13, label %14, label %116

; <label>:14                                      ; preds = %10
  %15 = load i8*, i8** %f, align 4
  %16 = load i8, i8* %15, align 1
  %17 = sext i8 %16 to i32
  %18 = icmp ne i32 %17, 37
  br i1 %18, label %19, label %24

; <label>:19                                      ; preds = %14
  %20 = load i8*, i8** %f, align 4
  %21 = load i8, i8* %20, align 1
  %22 = load i8*, i8** %b, align 4
  %23 = getelementptr inbounds i8, i8* %22, i32 1
  store i8* %23, i8** %b, align 4
  store i8 %21, i8* %22, align 1
  br label %113

; <label>:24                                      ; preds = %14
  %25 = load i8*, i8** %f, align 4
  %26 = getelementptr inbounds i8, i8* %25, i32 1
  store i8* %26, i8** %f, align 4
  store i32 0, i32* %arg_width, align 4
  br label %27

; <label>:27                                      ; preds = %39, %24
  %28 = load i8*, i8** %f, align 4
  %29 = load i8, i8* %28, align 1
  %30 = sext i8 %29 to i32
  %31 = icmp sge i32 %30, 48
  br i1 %31, label %32, label %37

; <label>:32                                      ; preds = %27
  %33 = load i8*, i8** %f, align 4
  %34 = load i8, i8* %33, align 1
  %35 = sext i8 %34 to i32
  %36 = icmp sle i32 %35, 57
  br label %37

; <label>:37                                      ; preds = %32, %27
  %38 = phi i1 [ false, %27 ], [ %36, %32 ]
  br i1 %38, label %39, label %50

; <label>:39                                      ; preds = %37
  %40 = load i32, i32* %arg_width, align 4
  %41 = mul i32 %40, 10
  store i32 %41, i32* %arg_width, align 4
  %42 = load i8*, i8** %f, align 4
  %43 = load i8, i8* %42, align 1
  %44 = sext i8 %43 to i32
  %45 = sub nsw i32 %44, 48
  %46 = load i32, i32* %arg_width, align 4
  %47 = add i32 %46, %45
  store i32 %47, i32* %arg_width, align 4
  %48 = load i8*, i8** %f, align 4
  %49 = getelementptr inbounds i8, i8* %48, i32 1
  store i8* %49, i8** %f, align 4
  br label %27

; <label>:50                                      ; preds = %37
  %51 = load i8*, i8** %f, align 4
  %52 = load i8, i8* %51, align 1
  %53 = sext i8 %52 to i32
  switch i32 %53, label %107 [
    i32 115, label %54
    i32 99, label %72
    i32 120, label %78
    i32 100, label %91
    i32 37, label %104
  ]

; <label>:54                                      ; preds = %50
  %55 = va_arg i8** %3, i8*
  store i8* %55, i8** %4, align 4
  %56 = load i8*, i8** %4, align 4
  store i8* %56, i8** %s, align 4
  %57 = load i8*, i8** %s, align 4
  %58 = icmp eq i8* %57, null
  br i1 %58, label %59, label %60

; <label>:59                                      ; preds = %54
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i32 0, i32 0), i8** %s, align 4
  br label %60

; <label>:60                                      ; preds = %59, %54
  br label %61

; <label>:61                                      ; preds = %65, %60
  %62 = load i8*, i8** %s, align 4
  %63 = load i8, i8* %62, align 1
  %64 = icmp ne i8 %63, 0
  br i1 %64, label %65, label %71

; <label>:65                                      ; preds = %61
  %66 = load i8*, i8** %s, align 4
  %67 = getelementptr inbounds i8, i8* %66, i32 1
  store i8* %67, i8** %s, align 4
  %68 = load i8, i8* %66, align 1
  %69 = load i8*, i8** %b, align 4
  %70 = getelementptr inbounds i8, i8* %69, i32 1
  store i8* %70, i8** %b, align 4
  store i8 %68, i8* %69, align 1
  br label %61

; <label>:71                                      ; preds = %61
  br label %112

; <label>:72                                      ; preds = %50
  %73 = va_arg i8** %3, i32
  store i32 %73, i32* %5, align 4
  %74 = load i32, i32* %5, align 4
  %75 = trunc i32 %74 to i8
  %76 = load i8*, i8** %b, align 4
  %77 = getelementptr inbounds i8, i8* %76, i32 1
  store i8* %77, i8** %b, align 4
  store i8 %75, i8* %76, align 1
  br label %112

; <label>:78                                      ; preds = %50
  %79 = load i8*, i8** %b, align 4
  %80 = load i8*, i8** %1, align 4
  %81 = ptrtoint i8* %79 to i32
  %82 = ptrtoint i8* %80 to i32
  %83 = sub i32 %81, %82
  store i32 %83, i32* %i, align 4
  %84 = va_arg i8** %3, i32
  store i32 %84, i32* %6, align 4
  %85 = load i32, i32* %6, align 4
  %86 = load i32, i32* %arg_width, align 4
  %87 = load i8*, i8** %1, align 4
  call void @print_hex(i32 %85, i32 %86, i8* %87, i32* %i) #2
  %88 = load i8*, i8** %1, align 4
  %89 = load i32, i32* %i, align 4
  %90 = getelementptr inbounds i8, i8* %88, i32 %89
  store i8* %90, i8** %b, align 4
  br label %112

; <label>:91                                      ; preds = %50
  %92 = load i8*, i8** %b, align 4
  %93 = load i8*, i8** %1, align 4
  %94 = ptrtoint i8* %92 to i32
  %95 = ptrtoint i8* %93 to i32
  %96 = sub i32 %94, %95
  store i32 %96, i32* %i, align 4
  %97 = va_arg i8** %3, i32
  store i32 %97, i32* %7, align 4
  %98 = load i32, i32* %7, align 4
  %99 = load i32, i32* %arg_width, align 4
  %100 = load i8*, i8** %1, align 4
  call void @print_dec(i32 %98, i32 %99, i8* %100, i32* %i) #2
  %101 = load i8*, i8** %1, align 4
  %102 = load i32, i32* %i, align 4
  %103 = getelementptr inbounds i8, i8* %101, i32 %102
  store i8* %103, i8** %b, align 4
  br label %112

; <label>:104                                     ; preds = %50
  %105 = load i8*, i8** %b, align 4
  %106 = getelementptr inbounds i8, i8* %105, i32 1
  store i8* %106, i8** %b, align 4
  store i8 37, i8* %105, align 1
  br label %112

; <label>:107                                     ; preds = %50
  %108 = load i8*, i8** %f, align 4
  %109 = load i8, i8* %108, align 1
  %110 = load i8*, i8** %b, align 4
  %111 = getelementptr inbounds i8, i8* %110, i32 1
  store i8* %111, i8** %b, align 4
  store i8 %109, i8* %110, align 1
  br label %112

; <label>:112                                     ; preds = %107, %104, %91, %78, %72, %71
  br label %113

; <label>:113                                     ; preds = %112, %19
  %114 = load i8*, i8** %f, align 4
  %115 = getelementptr inbounds i8, i8* %114, i32 1
  store i8* %115, i8** %f, align 4
  br label %10

; <label>:116                                     ; preds = %10
  %117 = load i8*, i8** %b, align 4
  store i8 0, i8* %117, align 1
  %118 = load i8*, i8** %b, align 4
  %119 = load i8*, i8** %1, align 4
  %120 = ptrtoint i8* %118 to i32
  %121 = ptrtoint i8* %119 to i32
  %122 = sub i32 %120, %121
  ret i32 %122
}

; Function Attrs: nounwind
define internal void @print_hex(i32 %value, i32 %width, i8* %buf, i32* %ptr) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 4
  %4 = alloca i32*, align 4
  store i32 %value, i32* %1, align 4
  store i32 %width, i32* %2, align 4
  store i8* %buf, i8** %3, align 4
  store i32* %ptr, i32** %4, align 4
  ret void
}

; Function Attrs: nounwind
define internal void @print_dec(i32 %value, i32 %width, i8* %buf, i32* %ptr) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 4
  %4 = alloca i32*, align 4
  store i32 %value, i32* %1, align 4
  store i32 %width, i32* %2, align 4
  store i8* %buf, i8** %3, align 4
  store i32* %ptr, i32** %4, align 4
  ret void
}

; Function Attrs: nounwind
define i32 @sprintf(i8* %buf, i8* %fmt, ...) #0 {
  %1 = alloca i8*, align 4
  %2 = alloca i8*, align 4
  %args = alloca i8*, align 4
  %out = alloca i32, align 4
  store i8* %buf, i8** %1, align 4
  store i8* %fmt, i8** %2, align 4
  %3 = bitcast i8** %args to i8*
  call void @llvm.va_start(i8* %3)
  %4 = load i8*, i8** %1, align 4
  %5 = load i8*, i8** %2, align 4
  %6 = load i8*, i8** %args, align 4
  %7 = call i32 @vasprintf(i8* %4, i8* %5, i8* %6) #2
  store i32 %7, i32* %out, align 4
  %8 = bitcast i8** %args to i8*
  call void @llvm.va_end(i8* %8)
  %9 = load i32, i32* %out, align 4
  ret i32 %9
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind
define void @video_test() #0 {
  %rgbs = alloca %struct.rgbpack_t*, align 4
  %i = alloca i32, align 4
  store %struct.rgbpack_t* bitcast (i64* @video_colorinfo to %struct.rgbpack_t*), %struct.rgbpack_t** %rgbs, align 4
  %1 = load i16, i16* @video_y, align 2
  %2 = zext i16 %1 to i32
  %3 = icmp slt i32 %2, 600
  br i1 %3, label %4, label %94

; <label>:4                                       ; preds = %0
  %5 = load i16, i16* @video_x, align 2
  %6 = load i16, i16* @video_y, align 2
  call void @video_backend_setaddress(i16 zeroext %5, i16 zeroext %6) #2
  store i32 0, i32* %i, align 4
  br label %7

; <label>:7                                       ; preds = %13, %4
  %8 = load i32, i32* %i, align 4
  %9 = icmp slt i32 %8, 50
  br i1 %9, label %10, label %16

; <label>:10                                      ; preds = %7
  %11 = load i32, i32* %i, align 4
  %12 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  call void @video_pixels_pack(i32 %11, %struct.rgbpack_t* %12) #2
  br label %13

; <label>:13                                      ; preds = %10
  %14 = load i32, i32* %i, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %i, align 4
  br label %7

; <label>:16                                      ; preds = %7
  %17 = load i16, i16* @video_x, align 2
  %18 = zext i16 %17 to i32
  %19 = add nsw i32 %18, 100
  %20 = trunc i32 %19 to i16
  store i16 %20, i16* @video_x, align 2
  %21 = load i16, i16* @video_x, align 2
  %22 = zext i16 %21 to i32
  %23 = icmp sgt i32 %22, 800
  br i1 %23, label %24, label %67

; <label>:24                                      ; preds = %16
  store i16 0, i16* @video_x, align 2
  %25 = load i16, i16* @video_y, align 2
  %26 = add i16 %25, 1
  store i16 %26, i16* @video_y, align 2
  %27 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %28 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %27, i32 0, i32 0
  %29 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %28, i32 0, i32 1
  %30 = load i8, i8* %29, align 1
  %31 = zext i8 %30 to i32
  %32 = sub nsw i32 %31, 2
  %33 = trunc i32 %32 to i8
  store i8 %33, i8* %29, align 1
  %34 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %35 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %34, i32 0, i32 0
  %36 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %35, i32 0, i32 2
  %37 = load i8, i8* %36, align 1
  %38 = zext i8 %37 to i32
  %39 = add nsw i32 %38, 1
  %40 = trunc i32 %39 to i8
  store i8 %40, i8* %36, align 1
  %41 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %42 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %41, i32 0, i32 0
  %43 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %42, i32 0, i32 2
  %44 = load i8, i8* %43, align 1
  %45 = zext i8 %44 to i32
  %46 = mul nsw i32 %45, 3
  %47 = trunc i32 %46 to i8
  store i8 %47, i8* %43, align 1
  %48 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %49 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %48, i32 0, i32 0
  %50 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %49, i32 0, i32 2
  %51 = load i8, i8* %50, align 1
  %52 = zext i8 %51 to i32
  %53 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %54 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %53, i32 0, i32 1
  %55 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 1
  %57 = zext i8 %56 to i32
  %58 = add nsw i32 %57, %52
  %59 = trunc i32 %58 to i8
  store i8 %59, i8* %55, align 1
  %60 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %61 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %60, i32 0, i32 1
  %62 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %61, i32 0, i32 1
  %63 = load i8, i8* %62, align 1
  %64 = zext i8 %63 to i32
  %65 = add nsw i32 %64, 1
  %66 = trunc i32 %65 to i8
  store i8 %66, i8* %62, align 1
  br label %67

; <label>:67                                      ; preds = %24, %16
  %68 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %69 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %68, i32 0, i32 0
  %70 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %69, i32 0, i32 0
  %71 = load i8, i8* %70, align 1
  %72 = zext i8 %71 to i32
  %73 = add nsw i32 %72, 10
  %74 = trunc i32 %73 to i8
  store i8 %74, i8* %70, align 1
  %75 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %76 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %75, i32 0, i32 0
  %77 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %76, i32 0, i32 2
  %78 = load i8, i8* %77, align 1
  %79 = zext i8 %78 to i32
  %80 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %81 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %80, i32 0, i32 0
  %82 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %81, i32 0, i32 1
  %83 = load i8, i8* %82, align 1
  %84 = zext i8 %83 to i32
  %85 = mul nsw i32 %84, 3
  %86 = add nsw i32 %79, %85
  %87 = load %struct.rgbpack_t*, %struct.rgbpack_t** %rgbs, align 4
  %88 = getelementptr inbounds %struct.rgbpack_t, %struct.rgbpack_t* %87, i32 0, i32 1
  %89 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %88, i32 0, i32 2
  %90 = load i8, i8* %89, align 1
  %91 = zext i8 %90 to i32
  %92 = add nsw i32 %91, %86
  %93 = trunc i32 %92 to i8
  store i8 %93, i8* %89, align 1
  call void @video_backend_render_block(i32 40) #2
  br label %95

; <label>:94                                      ; preds = %0
  call void @video_backend_render_block(i32 0) #2
  br label %95

; <label>:95                                      ; preds = %94, %67
  ret void
}

; Function Attrs: nounwind
define void @start() #0 {
  %ch = alloca i8, align 1
  call void @welcome() #2
  call void @puts(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.8, i32 0, i32 0)) #2
  br label %1

; <label>:1                                       ; preds = %16, %0
  %2 = call signext i8 @video_is_enabled() #2
  %3 = icmp ne i8 %2, 0
  br i1 %3, label %5, label %4

; <label>:4                                       ; preds = %1
  br label %17

; <label>:5                                       ; preds = %1
  call void @video_test() #2
  %6 = call signext i8 @kbhit() #2
  %7 = icmp ne i8 %6, 0
  br i1 %7, label %8, label %16

; <label>:8                                       ; preds = %5
  %9 = call signext i8 @getch_async() #2
  store i8 %9, i8* %ch, align 1
  %10 = load i8, i8* %ch, align 1
  %11 = sext i8 %10 to i32
  %12 = icmp eq i32 %11, 113
  br i1 %12, label %13, label %14

; <label>:13                                      ; preds = %8
  br label %17

; <label>:14                                      ; preds = %8
  %15 = load i8, i8* %ch, align 1
  call void @putc(i8 signext %15) #2
  br label %16

; <label>:16                                      ; preds = %14, %5
  br label %1

; <label>:17                                      ; preds = %13, %4
  call void @goodbye() #2
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nobuiltin }

!llvm.ident = !{!0, !0}

!0 = !{!"clang version 3.8.1 "}
!1 = !{i32 -2147473924}
