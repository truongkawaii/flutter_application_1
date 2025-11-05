class BusinessProfile {
  final String name;
  final String jobTitle;
  final String avatarUrl;
  final String email;
  final String phone;
  final String location;

  const BusinessProfile({
    required this.name,
    required this.jobTitle,
    required this.avatarUrl,
    this.email = 'contact@example.com',
    this.phone = '+84 123 456 789',
    this.location = 'Ho Chi Minh City',
  });

  // Factory constructor
  factory BusinessProfile.sample() {
    return const BusinessProfile(
      name: 'Nguyen Van An',
      jobTitle: 'Senior Flutter Developer',
      avatarUrl: 'https://i.pravatar.cc/300',
      email: 'an.nguyen@flutter.dev',
      phone: '+84 901 234 567',
      location: 'Ha Noi, Viet Nam',
    );
  }
}
