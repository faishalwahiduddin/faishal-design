import 'dart:convert';
import 'package:web/web.dart' as web;

/// A utility class for setting SEO meta tags and JSON-LD structured data on web.
class SeoUtils {
  /// Sets HTML meta tags for SEO.
  static void setMetaTags({
    String? title,
    String? description,
    String? ogImage,
    String? canonical,
  }) {
    if (title != null) {
      web.document.title = title;
      _updateMetaTag('property', 'og:title', title);
    }

    if (description != null) {
      _updateMetaTag('name', 'description', description);
      _updateMetaTag('property', 'og:description', description);
    }

    if (ogImage != null) {
      _updateMetaTag('property', 'og:image', ogImage);
    }

    if (canonical != null) {
      _updateLinkTag('rel', 'canonical', canonical);
    }
  }

  /// Injects JSON-LD structured data into the page.
  static void setJsonLd(Map<String, dynamic> data) {
    // Find existing script tag with application/ld+json or create new
    final head = web.document.head;
    if (head == null) return;

    web.HTMLScriptElement? scriptEl;
    final scripts = head.querySelectorAll('script[type="application/ld+json"]');
    if (scripts.length > 0) {
      scriptEl = scripts.item(0) as web.HTMLScriptElement;
    } else {
      scriptEl = web.document.createElement('script') as web.HTMLScriptElement;
      scriptEl.type = 'application/ld+json';
      head.append(scriptEl);
    }

    scriptEl.text = jsonEncode(data);
  }

  static void _updateMetaTag(
    String attributeName,
    String attributeValue,
    String content,
  ) {
    final head = web.document.head;
    if (head == null) return;

    web.HTMLMetaElement? metaEl;
    final tags = head.querySelectorAll(
      'meta[$attributeName="$attributeValue"]',
    );
    if (tags.length > 0) {
      metaEl = tags.item(0) as web.HTMLMetaElement;
    } else {
      metaEl = web.document.createElement('meta') as web.HTMLMetaElement;
      metaEl.setAttribute(attributeName, attributeValue);
      head.append(metaEl);
    }

    metaEl.content = content;
  }

  static void _updateLinkTag(
    String attributeName,
    String attributeValue,
    String href,
  ) {
    final head = web.document.head;
    if (head == null) return;

    web.HTMLLinkElement? linkEl;
    final tags = head.querySelectorAll(
      'link[$attributeName="$attributeValue"]',
    );
    if (tags.length > 0) {
      linkEl = tags.item(0) as web.HTMLLinkElement;
    } else {
      linkEl = web.document.createElement('link') as web.HTMLLinkElement;
      linkEl.setAttribute(attributeName, attributeValue);
      head.append(linkEl);
    }

    linkEl.href = href;
  }
}
