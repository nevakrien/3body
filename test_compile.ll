; ModuleID = 'test_compile.c'
source_filename = "test_compile.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.30.30706"

%struct.Camera2D = type { %struct.Vector2, %struct.Vector2, float, float }
%struct.Vector2 = type { float, float }

$"??_C@_0M@HNJFIPLC@Raylib?5Test?$AA@" = comdat any

$"??_C@_0DB@OHGHMPDI@Congrats?$CB?5You?5compiled?5and?5ran?5a@" = comdat any

@"??_C@_0M@HNJFIPLC@Raylib?5Test?$AA@" = linkonce_odr dso_local unnamed_addr constant [12 x i8] c"Raylib Test\00", comdat, align 1
@"??_C@_0DB@OHGHMPDI@Congrats?$CB?5You?5compiled?5and?5ran?5a@" = linkonce_odr dso_local unnamed_addr constant [49 x i8] c"Congrats! You compiled and ran a Raylib program!\00", comdat, align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.Camera2D, align 4
  tail call void @SetConfigFlags(i32 4) #3
  tail call void @InitWindow(i32 800, i32 450, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @"??_C@_0M@HNJFIPLC@Raylib?5Test?$AA@", i64 0, i64 0)) #3
  tail call void @SetTargetFPS(i32 60) #3
  %2 = call zeroext i1 @WindowShouldClose() #3
  br i1 %2, label %28, label %3

3:                                                ; preds = %0
  %4 = bitcast %struct.Camera2D* %1 to i8*
  %5 = getelementptr inbounds %struct.Camera2D, %struct.Camera2D* %1, i64 0, i32 0, i32 0
  %6 = getelementptr inbounds %struct.Camera2D, %struct.Camera2D* %1, i64 0, i32 0, i32 1
  %7 = getelementptr inbounds %struct.Camera2D, %struct.Camera2D* %1, i64 0, i32 1, i32 0
  %8 = bitcast float* %7 to <4 x float>*
  br label %9

9:                                                ; preds = %3, %9
  %10 = phi float [ 4.000000e+02, %3 ], [ %19, %9 ]
  %11 = phi float [ 2.250000e+02, %3 ], [ %25, %9 ]
  %12 = call i32 @GetScreenWidth() #3
  %13 = call i32 @GetScreenHeight() #3
  %14 = call zeroext i1 @IsKeyDown(i32 262) #3
  %15 = fadd float %10, -1.000000e+01
  %16 = select i1 %14, float %15, float %10
  %17 = call zeroext i1 @IsKeyDown(i32 263) #3
  %18 = fadd float %16, 1.000000e+01
  %19 = select i1 %17, float %18, float %16
  %20 = call zeroext i1 @IsKeyDown(i32 264) #3
  %21 = fadd float %11, -1.000000e+01
  %22 = select i1 %20, float %21, float %11
  %23 = call zeroext i1 @IsKeyDown(i32 265) #3
  %24 = fadd float %22, 1.000000e+01
  %25 = select i1 %23, float %24, float %22
  call void @BeginDrawing() #3
  call void @ClearBackground(i32 -657931) #3
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %4) #3
  store float %19, float* %5, align 4, !tbaa.struct !3
  store float %25, float* %6, align 4, !tbaa.struct !8
  store <4 x float> <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00>, <4 x float>* %8, align 4
  call void @BeginMode2D(%struct.Camera2D* nonnull %1) #3
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %4) #3
  %26 = sdiv i32 %12, 5
  call void @DrawCircle(i32 %26, i32 120, float 3.500000e+01, i32 -13162010) #3
  call void @DrawText(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @"??_C@_0DB@OHGHMPDI@Congrats?$CB?5You?5compiled?5and?5ran?5a@", i64 0, i64 0), i32 190, i32 200, i32 20, i32 -3618616) #3
  call void @EndMode2D() #3
  call void @EndDrawing() #3
  %27 = call zeroext i1 @WindowShouldClose() #3
  br i1 %27, label %28, label %9, !llvm.loop !9

28:                                               ; preds = %9, %0
  call void @CloseWindow() #3
  ret i32 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dllimport void @SetConfigFlags(i32) local_unnamed_addr #2

declare dllimport void @InitWindow(i32, i32, i8*) local_unnamed_addr #2

declare dllimport void @SetTargetFPS(i32) local_unnamed_addr #2

declare dllimport zeroext i1 @WindowShouldClose() local_unnamed_addr #2

declare dllimport i32 @GetScreenWidth() local_unnamed_addr #2

declare dllimport i32 @GetScreenHeight() local_unnamed_addr #2

declare dllimport zeroext i1 @IsKeyDown(i32) local_unnamed_addr #2

declare dllimport void @BeginDrawing() local_unnamed_addr #2

declare dllimport void @ClearBackground(i32) local_unnamed_addr #2

declare dllimport void @BeginMode2D(%struct.Camera2D*) local_unnamed_addr #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

declare dllimport void @DrawCircle(i32, i32, float, i32) local_unnamed_addr #2

declare dllimport void @DrawText(i8*, i32, i32, i32, i32) local_unnamed_addr #2

declare dllimport void @EndMode2D() local_unnamed_addr #2

declare dllimport void @EndDrawing() local_unnamed_addr #2

declare dllimport void @CloseWindow() local_unnamed_addr #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 12.0.0"}
!3 = !{i64 0, i64 4, !4, i64 4, i64 4, !4, i64 8, i64 4, !4, i64 12, i64 4, !4, i64 16, i64 4, !4, i64 20, i64 4, !4}
!4 = !{!5, !5, i64 0}
!5 = !{!"float", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = !{i64 0, i64 4, !4, i64 4, i64 4, !4, i64 8, i64 4, !4, i64 12, i64 4, !4, i64 16, i64 4, !4}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
