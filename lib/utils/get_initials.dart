String getInitials(String firstname, String lastname) {
  String initials = "";

  initials += firstname.isNotEmpty ? firstname[0] : '';
  initials += lastname.isNotEmpty ? lastname[0] : '';

  return initials.toUpperCase();
}
