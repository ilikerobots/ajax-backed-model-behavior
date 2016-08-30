@TestOn('browser && !firefox')
library polymer_ajax_backed_model_behavior.test.ajax_backed_model_behavior_test;

import 'dart:async';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_ajax_backed_model_behavior/polymer_ajax_backed_model_behavior.dart';
import 'src/test_view.dart';
import 'src/test_model.dart';
import 'common.dart';

main() async {

  await initPolymer();
  await initWebComponents();

  group('empty', () {
    TestView fix;

    setUp(() async {
      fix = fixture('testview_empty');
    });

    test('AjaxBackedModelBehavior empty default', () {
      expect(fix.autoLoad, isFalse);
      expect(fix.ajaxUrl, isNull);
      expect(fix.ajaxModel, isNull);
    });
  });

  group('auto-load', () {
    AjaxBackedModelBehavior fix;

    setUp(() async {
      fix = fixture('testview_autoload');
    });

    test('AjaxBackedModelBehavior autoload', () async {
      expect(fix.autoLoad, isTrue, reason: "auto-load is set");
      expect(fix.ajaxUrl, contains("json"), reason: "ajax-url is set");
      return new Future.delayed(const Duration(milliseconds: 500), () =>
          expect((fix.ajaxModel as TestModel).name, "Mauritania")
      );
    });
  });

  group('model-load', () {
    AjaxBackedModelBehavior fix;

    setUp(() async {
      fix = fixture('testview_noautoload');
    });

    test('AjaxBackedModelBehavior url change', () async {
      fix.set("ajaxUrl" , "data/country_1.json");
      return new Future.delayed(const Duration(milliseconds: 500), () =>
          expect(fix.ajaxModel, isNull)
      );

    });
  });

}

