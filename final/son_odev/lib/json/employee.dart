class Employee {
  final int? id;
  final String name;
  final String tcNo;
  final String department;
  final double salary;
  final String address;
  final String imagePath;
  final double tecrube; // Tecrübe alanı eklendi

  Employee({
    this.id,
    required this.name,
    required this.tcNo,
    required this.department,
    required this.salary,
    required this.address,
    required this.imagePath,
    required this.tecrube, // Constructor'a eklendi
  });

  Map<String, dynamic> toMap() {
    // Map'e çevirirken, id null ise haritaya eklemeyin.
    return {
      if (id != null) 'id': id,
      'name': name,
      'tcNo': tcNo,
      'department': department,
      'salary': salary,
      'address': address,
      'imagePath': imagePath,
      'tecrube': tecrube, // Map'e eklendi
    };
  }

  // Veritabanından bir map alarak yeni bir Employee nesnesi oluşturmak için fabrika kurucusu.
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      tcNo: map['tcNo'],
      department: map['department'],
      salary: map['salary'],
      address: map['address'],
      imagePath: map['imagePath'],
      tecrube: map['tecrube'], // Map'ten alınıyor
    );
  }
}
