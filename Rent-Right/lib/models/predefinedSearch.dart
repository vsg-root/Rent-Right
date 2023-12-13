class PredefinedSearch{
  String _searchName;
  String _searchDiscription;
  Map<String, double> _searchPropertyQuantities;
  Map<String, bool> _searchPermitions;


  PredefinedSearch({
    required searchName,
    required searchDiscription,
    required searchPropertyQuantities,
    required searchPermitions,
  }): 
  _searchName = searchName,
  _searchDiscription = searchDiscription,
  _searchPropertyQuantities = searchPropertyQuantities,
  _searchPermitions = searchPermitions;


  String getSearchName() => _searchName;
  String getSearchDiscription() => _searchDiscription;
  Map<String, double> getSearchPropertyQuantities() => _searchPropertyQuantities;
  Map<String, bool> getSearchPermitions() => _searchPermitions;





  }


