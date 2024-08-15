@window_name = linkonce_odr dso_local unnamed_addr constant [12 x i8] c"3 Body LLVM\00"

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  ; Initialize window
  tail call void @SetConfigFlags(i32 4) #2

  tail call void @InitWindow(i32 800, i32 450, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @window_name, i64 0, i64 0)) #2
  tail call void @SetTargetFPS(i32 60) #2
  br label %main_loop

main_loop:                                                ; preds = %0, %2
  ; Define screen dimensions using add 0 to quiet type requirements
  %screen_width = tail call i32 @GetScreenWidth() #2
  %screen_height = tail call i32 @GetScreenHeight() #2

  %screen_width_float = sitofp i32 %screen_width to float

  ; Calculate circle properties based on screen dimensions
  %circle_x = sdiv i32 %screen_width, 5
  %circle_y = sdiv i32 %screen_height, 5
  %circle_radius = fdiv float %screen_width_float, 20.0

  tail call void @BeginDrawing() #2
  tail call void @ClearBackground(i32 -657931) #2

  ; Draw circle with computed position and size
  tail call void @DrawCircle(i32 %circle_x, i32 %circle_y, float %circle_radius, i32 -5484032) #2

  tail call void @EndDrawing() #2
  %should_close = tail call zeroext i1 @WindowShouldClose() #2
  br i1 %should_close, label %exit, label %main_loop, !llvm.loop !3

exit:                                                ; preds = %2, %0
  tail call void @CloseWindow() #2
  ret i32 0
}

declare dllimport i32 @GetScreenWidth() local_unnamed_addr #1
declare dllimport i32 @GetScreenHeight() local_unnamed_addr #1

declare dllimport void @SetConfigFlags(i32) local_unnamed_addr #1


declare dllimport void @InitWindow(i32, i32, i8*) local_unnamed_addr #1
declare dllimport void @SetTargetFPS(i32) local_unnamed_addr #1
declare dllimport zeroext i1 @WindowShouldClose() local_unnamed_addr #1
declare dllimport void @BeginDrawing() local_unnamed_addr #1
declare dllimport void @ClearBackground(i32) local_unnamed_addr #1
declare dllimport void @EndDrawing() local_unnamed_addr #1
declare dllimport void @CloseWindow() local_unnamed_addr #1
declare dllimport void @DrawCircle(i32, i32, float, i32) local_unnamed_addr #1

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
