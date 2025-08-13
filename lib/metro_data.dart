import 'package:flutter/material.dart';

// Metro line model
class MetroLine {
  final String id;
  final String displayName;
  final Color color;
  final List<String> stations;

  const MetroLine({
    required this.id,
    required this.displayName,
    required this.color,
    required this.stations,
  });
}

// Stations per line
const List<String> line1Stations = [
  'Helwan', 'Ain Helwan', 'Helwan University', 'Wadi Hof', 'Hadayek Helwan',
  'El-Maasara', 'Tora El-Asmant', 'Kozzika', 'Tora El-Balad',
  'Sakanat El-Maadi', 'Maadi', 'Hadayek El-Maadi', 'Dar El-Salam',
  'El-Zahraa', 'Mar Girgis', 'El-Malek El-Saleh', 'Al-Sayeda Zeinab',
  'Saad Zaghloul', 'Sadat', 'Nasser', 'Orabi', 'Al Shohadaa', 'Ghamra',
  'El Demerdash', 'Manshiet El Sadr', 'Kobri El-Qobba', 'Hammamat El-Qobba',
  'Saray El-Qobba', 'Hadayeq El-Zaitoun', 'Helmeyet El-Zaitoun', 'El Matareyya',
  'Ain Shams', 'Ezbet El Nakhl', 'El Marg', 'New Marg',
];

const List<String> line2Stations = [
  'Shubra El Kheima', 'Koliet El-Zeraa', 'Mezallat', 'Khalafawy', 'St. Teresa',
  'Rod El-Farag', 'Masarra', 'Al Shohadaa', 'Attaba', 'Mohamed Naguib',
  'Sadat', 'Opera', 'Dokki', 'El Bohoth', 'Cairo University', 'Faisal',
  'Giza', 'Omm El-Masryeen', 'Sakiat Mekky', 'El Monib',
];

const List<String> line3StationsEast = [
  'Adly Mansour', 'Haykestep', 'Omar Ibn El Khattab', 'Qobaa', 'Hisham Barakat',
  'El Nozha', 'El Shams Club', 'Alf Maskan', 'Helmeyet El-Zaitoun (L3)',
  'El Ahram', 'Koleyet El-Banat', 'Stadium', 'Fair Zone', 'Abbassiya',
  'Al Geish', 'Bab El Shariya', 'Abdou Pasha', 'El Demerdash (L3)',
  'Ghamra (L3)', 'Attaba', 'Nasser',
];

const List<String> line3StationsWest = [
  'Maspero', 'Zamalek', 'Kit Kat', 'Sudan', 'Imbaba', 'El-Bohy', 'El-Qawmia',
  'Ring Road', 'Rod El Farag Corridor',
];

// Lines
const MetroLine line1 = MetroLine(
  id: 'L1', displayName: 'Line 1', color: Colors.blue, stations: line1Stations,
);
const MetroLine line2 = MetroLine(
  id: 'L2', displayName: 'Line 2', color: Colors.green, stations: line2Stations,
);
const MetroLine line3 = MetroLine(
  id: 'L3', displayName: 'Line 3', color: Colors.red,
  stations: [...line3StationsEast, ...line3StationsWest],
);

const List<MetroLine> allLines = [line1, line2, line3];

// Get all unique stations
List<String> getAllStations() {
  return allLines.expand((line) => line.stations).toSet().toList()..sort();
}

// Interchange stations between lines
final Map<String, List<String>> _interchanges = {
  _pairKey('L1', 'L2'): ['Sadat', 'Al Shohadaa'],
  _pairKey('L1', 'L3'): ['Nasser'],
  _pairKey('L2', 'L3'): ['Attaba'],
};

// Key for two-line pair
String _pairKey(String a, String b) {
  final arr = [a, b]..sort();
  return arr.join('-');
}

// Get line by id
MetroLine _lineById(String id) => allLines.firstWhere((l) => l.id == id);

// Lines that contain a specific station
List<MetroLine> linesOfStation(String station) =>
    allLines.where((line) => line.stations.contains(station)).toList();

// Segment between two stations on the same line
List<String> _segment(MetroLine line, String from, String to) {
  int i1 = line.stations.indexOf(from);
  int i2 = line.stations.indexOf(to);
  if (i1 == -1 || i2 == -1) return [];
  return (i1 <= i2)
      ? line.stations.sublist(i1, i2 + 1)
      : line.stations.sublist(i2, i1 + 1).reversed.toList();
}

// Route with a single interchange
List<String> _routeViaOne(String start, String end, MetroLine a, MetroLine b, String via) {
  var p1 = _segment(a, start, via);
  var p2 = _segment(b, via, end);
  return (p1.isEmpty || p2.isEmpty) ? [] : [...p1, ...p2.skip(1)];
}

// Route with two interchanges
List<String> _routeViaTwo(
    String start, String end, MetroLine a, MetroLine mid, MetroLine b, String via1, String via2) {
  var p1 = _segment(a, start, via1);
  var pMid = _segment(mid, via1, via2);
  var p2 = _segment(b, via2, end);
  return (p1.isEmpty || pMid.isEmpty || p2.isEmpty)
      ? []
      : [...p1, ...pMid.skip(1), ...p2.skip(1)];
}

// Compute simple route
List<String> computeRouteSimple(String start, String end) {
  if (start == end) return [start];
  var startLines = linesOfStation(start);
  var endLines = linesOfStation(end);
  if (startLines.isEmpty || endLines.isEmpty) return [];

  List<List<String>> candidates = [];

  for (var ls in startLines) {
    for (var le in endLines) {
      if (ls.id == le.id) {
        candidates.add(_segment(ls, start, end));
      }
      for (var via in _interchanges[_pairKey(ls.id, le.id)] ?? []) {
        candidates.add(_routeViaOne(start, end, ls, le, via));
      }
      for (var middleId in ['L1', 'L2', 'L3']) {
        if (middleId == ls.id || middleId == le.id) continue;
        for (var v1 in _interchanges[_pairKey(ls.id, middleId)] ?? []) {
          for (var v2 in _interchanges[_pairKey(middleId, le.id)] ?? []) {
            candidates.add(_routeViaTwo(start, end, ls, _lineById(middleId), le, v1, v2));
          }
        }
      }
    }
  }

  candidates.removeWhere((route) => route.isEmpty);
  candidates.sort((a, b) => a.length.compareTo(b.length));
  return candidates.isEmpty ? [] : candidates.first;
}

// Determine line between two consecutive stations
String? lineForEdge(String a, String b) {
  for (var line in allLines) {
    for (int i = 0; i < line.stations.length - 1; i++) {
      if ({line.stations[i], line.stations[i + 1]}.containsAll([a, b])) {
        return line.id;
      }
    }
  }
  return null;
}

// Display name helper
String lineDisplayName(String id) =>
    allLines.firstWhere((l) => l.id == id, orElse: () => line1).displayName;

// Line color helper
Color lineColor(String id) =>
    allLines.firstWhere((l) => l.id == id, orElse: () => line1).color;

// Transfer steps
List<String> buildTransferSteps(List<String> path) {
  if (path.length < 2) return [];
  List<String> steps = [];
  String? currentLine = lineForEdge(path[0], path[1]);

  for (int i = 1; i < path.length - 1; i++) {
    String? nextLine = lineForEdge(path[i], path[i + 1]);
    if (nextLine != null && nextLine != currentLine) {
      steps.add('Change at ${path[i]} to ${lineDisplayName(nextLine)}');
      currentLine = nextLine;
    }
  }
  return steps;
}

// ETA estimation
int estimateMinutes(int stopsCount) => stopsCount * 2;

// Price estimation
int estimatePrice(int stopsCount) {
  if (stopsCount <= 9) return 8;
  if (stopsCount <= 16) return 10;
  return 15;
}
