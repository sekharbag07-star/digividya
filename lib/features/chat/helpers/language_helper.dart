class LanguageHelper {
  static const Map<String, String> languages = {
    'en': 'English',
    'hi': 'हिन्दी',
    'bn': 'বাংলা',
    'ta': 'தமிழ்',
    'te': 'తెలుగు',
    'mr': 'मराठी',
    'gu': 'ગુજરાતી',
    'kn': 'ಕನ್ನಡ',
    'ml': 'മലയാളം',
    'pa': 'ਪੰਜਾਬੀ',
    'ur': 'اردو',
    'or': 'ଓଡ଼ିଆ',
  };

  static String getLanguageName(String code) {
    return languages[code] ?? 'English';
  }
}
