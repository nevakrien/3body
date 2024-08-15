; ModuleID = 'test_compile.c'
source_filename = "test_compile.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.30.30706"

$"??_C@_0M@HNJFIPLC@Raylib?5Test?$AA@" = comdat any

$"??_C@_0DB@OHGHMPDI@Congrats?$CB?5You?5compiled?5and?5ran?5a@" = comdat any

@"??_C@_0M@HNJFIPLC@Raylib?5Test?$AA@" = linkonce_odr dso_local unnamed_addr constant [12 x i8] c"Raylib Test\00", comdat, align 1
@"??_C@_0DB@OHGHMPDI@Congrats?$CB?5You?5compiled?5and?5ran?5a@" = linkonce_odr dso_local unnamed_addr constant [49 x i8] c"Congrats! You compiled and ran a Raylib program!\00", comdat, align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  tail call void @SetConfigFlags(i32 4) #2
  tail call void @InitWindow(i32 800, i32 450, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @"??_C@_0M@HNJFIPLC@Raylib?5Test?$AA@", i64 0, i64 0)) #2
  tail call void @SetTargetFPS(i32 60) #2
  %1 = tail call zeroext i1 @WindowShouldClose() #2
  br i1 %1, label %7, label %2

2:                                                ; preds = %0, %2
  %3 = tail call i32 @GetScreenWidth() #2
  %4 = tail call i32 @GetScreenHeight() #2
  tail call void @BeginDrawing() #2
  tail call void @ClearBackground(i32 -657931) #2
  %5 = sdiv i32 %3, 5
  tail call void @DrawCircle(i32 %5, i32 120, float 3.500000e+01, i32 -5484032) #2
  tail call void @DrawText(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @"??_C@_0DB@OHGHMPDI@Congrats?$CB?5You?5compiled?5and?5ran?5a@", i64 0, i64 0), i32 190, i32 200, i32 20, i32 -3618616) #2
  tail call void @EndDrawing() #2
  %6 = tail call zeroext i1 @WindowShouldClose() #2
  br i1 %6, label %7, label %2, !llvm.loop !3

7:                                                ; preds = %2, %0
  tail call void @CloseWindow() #2
  ret i32 0
}

declare dllimport void @SetConfigFlags(i32) local_unnamed_addr #1

declare dllimport void @InitWindow(i32, i32, i8*) local_unnamed_addr #1

declare dllimport void @SetTargetFPS(i32) local_unnamed_addr #1

declare dllimport zeroext i1 @WindowShouldClose() local_unnamed_addr #1

declare dllimport i32 @GetScreenWidth() local_unnamed_addr #1

declare dllimport i32 @GetScreenHeight() local_unnamed_addr #1

declare dllimport void @BeginDrawing() local_unnamed_addr #1

declare dllimport void @ClearBackground(i32) local_unnamed_addr #1

declare dllimport void @DrawCircle(i32, i32, float, i32) local_unnamed_addr #1

declare dllimport void @DrawText(i8*, i32, i32, i32, i32) local_unnamed_addr #1

declare dllimport void @EndDrawing() local_unnamed_addr #1

declare dllimport void @CloseWindow() local_unnamed_addr #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 12.0.0"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.mustprogress"}
