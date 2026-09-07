String stripHtml(String html) {
  return html.replaceAll(RegExp(r'<[^>]*>'), '');
}