#include "raylib.h"

int main(void)
{
    // Initialization
    const int screenWidth = 800;
    const int screenHeight = 450;

    // Set the window to be resizable before initializing it
    SetConfigFlags(FLAG_WINDOW_RESIZABLE);
    InitWindow(screenWidth, screenHeight, "Raylib Test");

    // Initialize the camera
    Camera2D camera = { 0 };
    camera.target = (Vector2){ 0.0f, 0.0f };
    camera.offset = (Vector2){ screenWidth / 2.0f, screenHeight / 2.0f };
    camera.rotation = 0.0f;
    camera.zoom = 1.0f;

    SetTargetFPS(60);

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Get the updated screen width and height after resizing
        int currentScreenWidth = GetScreenWidth();
        int currentScreenHeight = GetScreenHeight();

        // Update the camera position based on arrow keys
        if (IsKeyDown(KEY_RIGHT)) camera.offset.x -= 10;
        if (IsKeyDown(KEY_LEFT)) camera.offset.x += 10;
        if (IsKeyDown(KEY_DOWN)) camera.offset.y -= 10;
        if (IsKeyDown(KEY_UP)) camera.offset.y += 10;

        // Start drawing
        BeginDrawing();
        ClearBackground(RAYWHITE);

        // Begin the 2D camera mode
        BeginMode2D(camera);

        // Draw objects using the camera's position
        DrawCircle(currentScreenWidth / 5, 120, 35, RED);
        DrawText("Congrats! You compiled and ran a Raylib program!", 190, 200, 20, LIGHTGRAY);

        // End the 2D camera mode
        EndMode2D();

        EndDrawing();
    }

    // De-Initialization
    CloseWindow();        // Close window and OpenGL context

    return 0;
}
