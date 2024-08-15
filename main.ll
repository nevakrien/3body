@window_name = linkonce_odr dso_local unnamed_addr constant [12 x i8] c"3 Body LLVM\00"

declare void @llvm.memset.p0i8.i64(i8*, i8, i64, i1)

%struct.Camera2D = type { %struct.Vector2, %struct.Vector2, float, float }
%struct.Vector2 = type { float, float }

define internal void @DrawCirclesFromBuffer([6 x float]* %buffer, float %radius, float %screen_width_float, float %screen_height_float) alwaysinline {
entry:
  ; Initialize the loop
  br label %loop

loop:
  ; Loop index for accessing elements
  %index = phi i32 [ 0, %entry ], [ %next_index, %loop ]

  ; Get pointers to the current X and Y floats in the buffer
  %x_ptr = getelementptr inbounds [6 x float], [6 x float]* %buffer, i32 0, i32 %index
  %y_ptr = getelementptr inbounds [6 x float], [6 x float]* %buffer, i32 0, i32 %next_index

  ; Load the X and Y values
  %x_float = load float, float* %x_ptr, align 4
  %y_float = load float, float* %y_ptr, align 4

  ; Convert the floats to integers for drawing
  %x_int = fptosi float %x_float to i32
  %y_int = fptosi float %y_float to i32

  ; Draw the circle
  call void @DrawCircle(i32 %x_int, i32 %y_int, float %radius, i32 -13162010) #2 ;5484032

  ; Increment index by 2 to move to the next pair of floats
  %next_index = add i32 %index, 2
  ; Continue looping if more data remains
  %continue = icmp slt i32 %next_index, 6
  br i1 %continue, label %loop, label %exit

exit:
  ret void
}

define internal void @UpdateState([6 x float]* %in_buffer, [6 x float]* %out_buffer) alwaysinline {
entry:
  ; Initialize the loop
  br label %loop

loop:
  ; Loop index for accessing elements
  %index = phi i32 [ 0, %entry ], [ %next_index, %loop ]
  %y_index = add i32 %index, 1

  ; Get pointers to the current X and Y floats in the buffer
  %x_in_ptr = getelementptr inbounds [6 x float], [6 x float]* %in_buffer, i32 0, i32 %index
  %y_in_ptr = getelementptr inbounds [6 x float], [6 x float]* %in_buffer, i32 0, i32 %y_index

  ; Load the X and Y values
  %x_val = load float, float* %x_in_ptr, align 4
  %y_val = load float, float* %y_in_ptr, align 4

  ; Get pointers to the current X and Y floats in the buffer
  %x_out_ptr = getelementptr inbounds [6 x float], [6 x float]* %out_buffer, i32 0, i32 %index
  %y_out_ptr = getelementptr inbounds [6 x float], [6 x float]* %out_buffer, i32 0, i32 %y_index
  
  store float %x_val, float* %x_in_ptr, align 4
  store float %y_val, float* %y_in_ptr, align 4


  %next_index = add i32 %index, 2
  ; Continue looping if more data remains
  %continue = icmp slt i32 %next_index, 6
  br i1 %continue, label %loop, label %exit

exit:
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  ;initilize base data
  %work_buffer = alloca [6 x float] ,align 4
  %bodies_data  = alloca [6 x float] ,align 4
  
  %ptr0 = getelementptr [6 x float], [6 x float]* %bodies_data, i32 0, i32 0
  %ptr1 = getelementptr [6 x float], [6 x float]* %bodies_data, i32 0, i32 1
  %ptr2 = getelementptr [6 x float], [6 x float]* %bodies_data, i32 0, i32 2
  %ptr3 = getelementptr [6 x float], [6 x float]* %bodies_data, i32 0, i32 3
  %ptr4 = getelementptr [6 x float], [6 x float]* %bodies_data, i32 0, i32 4
  %ptr5 = getelementptr [6 x float], [6 x float]* %bodies_data, i32 0, i32 5
  
  store float 160.0, float* %ptr0
  store float 160.0, float* %ptr1
  store float 10.0, float* %ptr2
  store float 4.0, float* %ptr3
  store float 0.0, float* %ptr4
  store float 0.0, float* %ptr5

  

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
  %YoffsetPtr = getelementptr inbounds %struct.Vector2, %struct.Vector2* %offsetPtr, i32 0, i32 1
  store float 400.0, float* %XoffsetPtr, align 4
  store float 225.0, float* %YoffsetPtr, align 4


  ; Initialize window
  tail call void @SetConfigFlags(i32 4) #2
  tail call void @InitWindow(i32 800, i32 450, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @window_name, i64 0, i64 0)) #2
  tail call void @SetTargetFPS(i32 10) #2
  br label %main_loop

main_loop:                                                ; preds = %0, %2
  ;set the buffers
  %current_data = phi [6 x float]* [ %bodies_data, %entry ], [ %next_buffer, %main_loop ]
  %next_buffer = phi [6 x float]* [ %work_buffer, %entry ], [ %current_data, %main_loop ]

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


  %circle_radius = fdiv float %screen_width_float, 20.0

  tail call void @BeginDrawing() #2
  tail call void @ClearBackground(i32 -657931) #2

  call void @BeginMode2D(%struct.Camera2D* nonnull %Cam) #3

  
  tail call void @DrawCirclesFromBuffer([6 x float]* %current_data, float %circle_radius, float %screen_width_float, float %screen_height_float)

  call void @EndMode2D() #3
  tail call void @EndDrawing() #2

  tail call void @UpdateState([6 x float]* %current_data,[6 x float]* %next_buffer)

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
