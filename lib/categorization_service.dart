class CategorizationService {
  static final Map<String, List<String>> _categoryKeywords = {
    'Fruits': [
      'apple',
      'banana',
      'orange',
      'grapes',
      'strawberry',
      'blueberry',
      'mango',
      'pineapple',
    ],
    'Vegetables': [
      'carrot',
      'broccoli',
      'spinach',
      'potato',
      'tomato',
      'onion',
      'garlic',
      'lettuce',
    ],
    'Dairy': ['milk', 'cheese', 'yogurt', 'butter', 'cream'],
    'Meat': ['chicken', 'beef', 'pork', 'lamb', 'fish', 'salmon'],
    'Bakery': ['bread', 'bagel', 'croissant', 'muffin'],
    'Pantry': ['pasta', 'rice', 'flour', 'sugar', 'cereal', 'oil', 'sauce'],
    'Snacks': ['chips', 'cookies', 'crackers', 'pretzels', 'popcorn'],
    'Drinks': ['water', 'juice', 'soda', 'tea', 'coffee'],
  };

  static String categorize(String itemName) {
    final lowerCaseItemName = itemName.toLowerCase();
    for (var entry in _categoryKeywords.entries) {
      for (var keyword in entry.value) {
        if (lowerCaseItemName.contains(keyword)) {
          return entry.key;
        }
      }
    }
    return 'Uncategorized';
  }
}
