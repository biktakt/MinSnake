import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake/models/grid.dart';
import '../models/point.dart';

class Snake {
  List<PointTile> body = [];
  Direction direction = Direction.down;
  int speed = 0;
  PointTile food = const PointTile(-1, -1);

  PointTile get head => body[0];
  set head(PointTile val) => body[0];

  Snake.randomSpawn() {
    final random = Random();
    direction = Direction.values[random.nextInt(4)];
    speed = 0;
    int x = random.nextInt(Grid.width);
    int y = random.nextInt(Grid.height);
    PointTile tail = PointTile(x, y);
    body = [tail + direction.point * 2, tail + direction.point, tail];
    food = spawnNewFood();
  }

  PointTile spawnNewFood() {
    final random = Random();
    PointTile food;
    do {
      food = PointTile(random.nextInt(Grid.width), random.nextInt(Grid.height));
    } while (body.contains(food));
    return food;
  }

  bool moveSnake() {
    final PointTile tail = body.last;
    body.removeLast();
    body.insert(0, head += direction.point);
    if (head == food) {
      body.add(tail);
      food = spawnNewFood();
      // if (score % 5 == 0) {
      //   speed += 5;
      // }
    }
    if (body.skip(1).contains(head)) {
      return false;
    } else {
      return true;
    }
  }

  void changeDirectionPress(LogicalKeyboardKey key) {
    final Direction oldDirection = direction;
    if ((key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) &&
        direction != Direction.down) {
      direction = Direction.up;
    } else if ((key == LogicalKeyboardKey.arrowDown ||
            key == LogicalKeyboardKey.keyS) &&
        direction != Direction.up) {
      direction = Direction.down;
    } else if ((key == LogicalKeyboardKey.arrowLeft ||
            key == LogicalKeyboardKey.keyA) &&
        direction != Direction.right) {
      direction = Direction.left;
    } else if ((key == LogicalKeyboardKey.arrowRight ||
            key == LogicalKeyboardKey.keyD) &&
        direction != Direction.left) {
      direction = Direction.right;
    }
    if (head + direction.point == body[1] ||
        head + direction.point == body[2]) {
      direction = oldDirection;
    }
  }

  void changeDirectionSwipe(DragUpdateDetails details) {
    final Direction oldDirection = direction;
    if (direction != Direction.up && details.delta.dy > 0) {
      direction = Direction.down;
    } else if (direction != Direction.down && details.delta.dy < 0) {
      direction = Direction.up;
    }
    if (direction != Direction.left && details.delta.dx > 0) {
      direction = Direction.right;
    } else if (direction != Direction.right && details.delta.dx < 0) {
      direction = Direction.left;
    }
    if (head + direction.point == body[1] ||
        head + direction.point == body[2]) {
      direction = oldDirection;
    }
  }

  @override
  String toString() {
    String snake = '';
    for (PointTile point in body) {
      snake += '[${point.x.toString()}][${point.y.toString()}] ';
    }
    return snake;
  }
}

enum Direction {
  up,
  right,
  down,
  left,
}

extension GetDirection on Direction {
  PointTile get point {
    switch (this) {
      case Direction.up:
        return const PointTile(0, -1);
      case Direction.down:
        return const PointTile(0, 1);
      case Direction.left:
        return const PointTile(-1, 0);
      case Direction.right:
        return const PointTile(1, 0);
      default:
        return const PointTile(0, 0);
    }
  }
}
