const Map<String, String> labelToSpoonacular = {
  'capsicum': 'bell pepper',
  'paprika': 'bell pepper',      // near-synonym
  'beetroot': 'beet',
  'jalepeno': 'jalapeno',        // dataset misspelling
  'raddish': 'radish',           // dataset misspelling
};

String toSpoonacularName(String label) => labelToSpoonacular[label] ?? label;