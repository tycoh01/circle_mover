mport 'dart:html';
import 'dart:math';

class Circle {
  final CanvasElement canvas;
  final CanvasRenderingContext2D context;
  final num centerX;
  final num centerY;
  final num radius;
  bool isTouched = false;

  Circle(this.canvas, this.centerX, this.centerY, this.radius)
      : context = canvas.context2D {
    _addGestureListener(); // Initialize gesture detection
    draw();                // Initial drawing of the circle
  }

  // Draw the circle based on the current state
  void draw() {
    _clearCanvas();
    context.beginPath();              // Begin new path
    context.arc(centerX, centerY, radius, 0, 2 * pi); // Draw the circle
    context.closePath();              // Close path to finish the circle
    context.fillStyle = _getColor();  // Set the fill color based on state
    context.fill();                   // Fill the circle with the chosen color
  }

  // Toggle color and redraw
  void toggleColor() {
    isTouched = !isTouched;
    draw(); // Redraw with updated color
  }

  // Add gesture detection to canvas
  void _addGestureListener() {
    canvas.onClick.listen((event) {
      final dx = event.client.x - canvas.getBoundingClientRect().left - centerX;
      final dy = event.client.y - canvas.getBoundingClientRect().top - centerY;
      final distance = sqrt(dx * dx + dy * dy);

      // Check if click is within circle bounds
      if (distance <= radius) {
        toggleColor();
      }
    });
  }

  // Helper method to clear the canvas
  void _clearCanvas() {
    context.clearRect(0, 0, canvas.width, canvas.height);
  }

  // Helper method to get the current color
  String _getColor() {
    return isTouched ? 'red' : 'blue';
  }
}

void main() {
  final canvas = querySelector('#canvas') as CanvasElement;
  Circle(canvas, canvas.width / 2, canvas.height / 2, 50);
}

