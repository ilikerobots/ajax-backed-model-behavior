library polymer_ajax_backed_model.example.src.test_model;


import 'package:polymer/polymer.dart';
import 'package:polymer_ajax_backed_model_behavior/ajax_backed_model.dart';
import 'dart:convert';

class TestModel extends Object with AjaxBackedModel {

  @reflectable int id;
  @reflectable String name;
  @reflectable double x;
  @reflectable double y;


  TestModel();

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