@window_name = linkonce_odr dso_local unnamed_addr constant [12 x i8] c"3 Body LLVM\00"

declare void @llvm.memset.p0i8.i64(i8*, i8, i64, i1)

%struct.Camera2D = type { %struct.Vector2, %struct.Vector2, float, float }
%struct.Vector2 = type { float, float }

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  ; Initialize camera
  %Cam = alloca %struct.Camera2D, align 4
  
  ; Get a pointer to the first byte of the Camera2D structure
  %CamBytePtr = bitcast %struct.Camera2D* %Cam to i8*

  ; Zero out the memory for the Camera2D structure
  %CamEndPtr = getelementptr %struct.Camera2D, %struct.Camera2D* %Cam, i32 1
  %CamSizeBytes = ptrtoint %struct.Camera2D* %CamEndPtr to i64
  %CamStart = ptrtoint %struct.Camera2D* %Cam to i64
  %Size = sub i64 %CamSizeBytes, %CamStart
  call void @llvm.memset.p0i8.i64(i8* %CamBytePtr, i8 0, i64 %Size, i1 false)

  ; Set the zoom to 1.0f
  %zoomPtr = getelementptr inbounds %struct.Camera2D, %struct.Camera2D* %Cam, i32 0, i32 3
  store float 1.0, float* %zoomPtr, align 4
  
  ; Get a pointer to the offset field
  %offsetPtr = getelementptr inbounds %struct.Camera2D, %struct.Camera2D* %Cam, i32 0, i32 0
  

  ;cordinates
  %XoffsetPtr = getelementptr inbounds %struct.Vector2, %struct.Vector2* %offsetPtr, i32 0, i32 0
  store float 400.0, float* %XoffsetPtr, align 4
  %YoffsetPtr = getelementptr inbounds %struct.Vector2, %struct.Vector2* %offsetPtr, i32 0, i32 1
  store float 225.0, float* %YoffsetPtr, align 4


  ; Initialize window
  tail call void @SetConfigFlags(i32 4) #2
  tail call void @InitWindow(i32 800, i32 450, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @window_name, i64 0, i64 0)) #2
  tail call void @SetTargetFPS(i32 60) #2
  br label %main_loop

main_loop:                                                ; preds = %0, %2
  ; manage camera

  %screen_width = tail call i32 @GetScreenWidth() #2
  %screen_height = tail call i32 @GetScreenHeight() #2

  %screen_width_float = sitofp i32 %screen_width to float
  %screen_height_float = sitofp i32 %screen_height to float

  %KeyRight = call zeroext i1 @IsKeyDown(i32 262) #3
  %KeyLeft = call zeroext i1 @IsKeyDown(i32 263) #3
  %KeyDown = call zeroext i1 @IsKeyDown(i32 264) #3
  %KeyUp = call zeroext i1 @IsKeyDown(i32 265) #3

  ;handle change
        %delta = fadd float 10.0, 0.0

        ; Convert the key inputs to -1.0, 0.0, or 1.0 for calculation
        %UpVal = select i1 %KeyUp, float 1.0, float 0.0
        %DownVal = select i1 %KeyDown, float 1.0, float 0.0
        %LeftVal = select i1 %KeyLeft, float 1.0, float 0.0
        %RightVal = select i1 %KeyRight, float 1.0, float 0.0

        ; Calculate (up - down) * delta
        %VerticalDelta = fsub float %UpVal, %DownVal
        %VerticalMove = fmul float %VerticalDelta, %delta

        ; Calculate (right - left) * delta
        %HorizontalDelta = fsub float %RightVal, %LeftVal
        %HorizontalMove = fmul float %HorizontalDelta, %delta

        ; Update 
        %currentX = load float, float* %XoffsetPtr, align 4
        %currentY = load float, float* %YoffsetPtr, align 4

        %NewX = fsub float %currentX, %HorizontalMove
        %NewY = fadd float %currentY, %VerticalMove

        store float %NewX, float* %XoffsetPtr, align 4
        store float %NewY, float* %YoffsetPtr, align 4



  ; Calculate circle properties based on screen dimensions
  %circle_x = sdiv i32 %screen_width, 5
  %circle_y = sdiv i32 %screen_height, 5
  %circle_radius = fdiv float %screen_width_float, 20.0

  tail call void @BeginDrawing() #2
  tail call void @ClearBackground(i32 -657931) #2

  call void @BeginMode2D(%struct.Camera2D* nonnull %Cam) #3


  ; Draw circle with computed position and size
  tail call void @DrawCircle(i32 %circle_x, i32 %circle_y, float %circle_radius, i32 -5484032) #2

  call void @EndMode2D() #3
  tail call void @EndDrawing() #2
  %should_close = tail call zeroext i1 @WindowShouldClose() #2
  br i1 %should_close, label %exit, label %main_loop, !llvm.loop !3

exit:                                                ; preds = %2, %0
  tail call void @CloseWindow() #2
  ret i32 0
}

declare dllimport i32 @GetScreenWidth() local_unnamed_addr #1
declare dllimport i32 @GetScreenHeight() local_unnamed_addr #1

declare dllimport zeroext i1 @IsKeyDown(i32) local_unnamed_addr #2
declare dllimport void @SetConfigFlags(i32) local_unnamed_addr #1

declare dllimport void @BeginMode2D(%struct.Camera2D*) local_unnamed_addr #2
declare dllimport void @EndMode2D() local_unnamed_addr #2


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
