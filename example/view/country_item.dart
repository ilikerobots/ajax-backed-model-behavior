@HtmlImport('country_item.html')
library polymer_ajax_backed_model.example.view.country_item;

import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_item_behavior.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_ajax_backed_model_behavior/polymer_ajax_backed_model_behavior.dart';

import '../model/country.dart';

@PolymerRegister('country-item')
class CountryItem extends PolymerElement with PaperItemBehavior, AjaxBackedModelBehavior {

  CountryItem.created() : super.created();

  AjaxBackedModel get modelInstance => new Country();

  String get modelName => "countryDetailModel";
}
