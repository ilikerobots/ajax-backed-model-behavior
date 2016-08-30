@HtmlImport('country_detail.html')
library polymer_ajax_backed_model.example.view.country_detail;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_ajax_backed_model_behavior/polymer_ajax_backed_model_behavior.dart';

import '../model/country.dart';

@PolymerRegister('country-detail')
class CountryDetail extends PolymerElement with PolymerMixin, PolymerBase, JsProxy, AjaxBackedModelBehavior {

  CountryDetail.created() : super.created();

  AjaxBackedModel get modelInstance => new Country();

}
