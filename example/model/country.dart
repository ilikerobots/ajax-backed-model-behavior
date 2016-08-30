library polymer_ajax_backed_model.example.model.country;


import 'package:polymer/polymer.dart';
import 'package:polymer_ajax_backed_model_behavior/ajax_backed_model.dart';
import 'dart:convert';

class Country extends Object with AjaxBackedModel, JsProxy {

  @reflectable int id;
  @reflectable String name;
  @reflectable double x;
  @reflectable double y;


  Country();

  setFromJsonString(String json) {
    setFromMap(JSON.decode(json));
  }

  setFromMap(Map o) {
    id = o['id'];
    name = o['country'];
    x = o['x'];
    y = o['y'];
  }


}