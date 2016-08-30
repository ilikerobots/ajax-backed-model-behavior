@HtmlImport('test_view.html')
library polymer_ajax_backed_model.example.src.test_view;

import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_ajax_backed_model_behavior/polymer_ajax_backed_model_behavior.dart';

import 'test_model.dart';

@PolymerRegister('test-view')
//@CustomElementProxy('test-view')
class TestView extends PolymerElement with PolymerMixin, PolymerBase, JsProxy, AjaxBackedModelBehavior {
//class TestView extends HtmlElement with CustomElementProxyMixin, PolymerBase, AjaxBackedModelBehavior {

  TestView.created() : super.created();

  AjaxBackedModel get modelInstance => new TestModel();

//String get modelName => "detailModel";
}
