/// Mobile/stub implementation of SEO utilities.
class SeoUtils {
  /// Sets HTML meta tags for SEO. This is a no-op on non-web platforms.
  static void setMetaTags({
    String? title,
    String? description,
    String? ogImage,
    String? canonical,
  }) {
    // No-op on non-web platforms
  }

  /// Injects JSON-LD structured data into the page. This is a no-op on non-web platforms.
  static void setJsonLd(Map<String, dynamic> data) {
    // No-op on non-web platforms
  }
}
