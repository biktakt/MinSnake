import 'package:snake/models/grid.dart';

class PointTile {
  final int x;
  final int y;

  const PointTile(this.x, this.y);

  @override
  bool operator ==(Object other) {
    return (other is PointTile && (other.x == x && other.y == y));
  }

  PointTile operator +(PointTile other) {
    return PointTile((other.x + x) % Grid.width, (other.y + y) % Grid.height);
  }

  PointTile operator *(int other) {
    return PointTile((other * x) % Grid.width, (other * y) % Grid.height);
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
