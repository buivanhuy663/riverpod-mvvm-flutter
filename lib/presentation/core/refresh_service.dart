class RefreshService {
  RefreshService._();

  static final Set<String> _pageInitialized = {};
  static final Set<String> _pagesCache = {};

  static bool hadRefresh(String page) {
    if (_pageInitialized.contains(page)) {
      return _pagesCache.contains(page);
    } else {
      return false;
    }
  }

  static void addPageInitialized(String page) {
    _pageInitialized.add(page);
  }

  static void removePageInitialized(String page) {
    _pageInitialized.remove(page);
  }

  static void clearAllPageInitialized(String page) {
    _pageInitialized.clear();
  }

  static void addPage(Object pages) {
    if (pages is List<Type>) {
      _pagesCache.addAll(pages.map((e) => e.toString()));
    } else if (pages is Type) {
      _pagesCache.add(pages.toString());
    } else if (pages is List<String>) {
      _pagesCache.addAll(pages);
    } else if (pages is String) {
      _pagesCache.add(pages);
    } else {
      throw Exception('Add Page must be Type or String');
    }
  }

  static void removePage(Object pages) {
    if (pages is List<Type>) {
      _pagesCache.removeAll(pages.map((e) => e.toString()));
    } else if (pages is Type) {
      _pagesCache.remove(pages.toString());
    } else if (pages is List<String>) {
      _pagesCache.removeAll(pages);
    } else if (pages is String) {
      _pagesCache.remove(pages);
    } else {
      throw Exception('Remove Page must be Type or String');
    }
  }

  static void clear() {
    _pagesCache.clear();
  }
}
