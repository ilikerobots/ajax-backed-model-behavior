library polymer_ajax_backed_model.example.model.country_list;

import 'package:polymer/polymer.dart';
import 'package:polymer_ajax_backed_model_behavior/ajax_backed_model.dart';
import 'dart:convert';

import 'country.dart';

class CountryList extends Object with AjaxBackedModel, JsProxy {

  @reflectable List<Country> list = new List<Country>();

  CountryList();

  setFromJsonString(String json) {
    List<Country> outList = [];
    List jList = JSON.decode(json);

    for (Map m in jList) {
      outList.add(new Country()..setFromMap(m));
    }
    list = outList;
  }


}