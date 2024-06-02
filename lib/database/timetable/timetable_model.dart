class Timetable {
  final int? id;
  final String className;
  final String classroomId;
  final String teacher;
  final String date;
  final int lessonNumber;

  Timetable({
    this.id,
    required this.className,
    required this.classroomId,
    required this.teacher,
    required this.date,
    required this.lessonNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'class_name': className,
      'classroom_id': classroomId,
      'teacher': teacher,
      'date': date,
      'lesson_number': lessonNumber,
    };
  }

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      id: map['id'],
      className: map['class_name'],
      classroomId: map['classroom_id'],
      teacher: map['teacher'],
      date: map['date'],
      lessonNumber: map['lesson_number'],
    );
  }
}
