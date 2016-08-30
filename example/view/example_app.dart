@HtmlImport('example_app.html')
library polymer_ajax_backed_model.example.view.example_app;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/iron_flex_layout_classes.dart';
import 'package:polymer_elements/paper_styles/classes/typography.dart';
import 'package:polymer_elements/paper_tabs.dart';
import 'package:polymer_elements/paper_toast.dart';
import 'package:polymer_interop/polymer_interop.dart';

import 'country_chart.dart';

@PolymerRegister('example-app')
class ExampleApp extends PolymerElement with PolymerMixin {
  @property
  int currentUrlIndex = 0;

  @Property(computed: 'getAjaxUrl(currentUrlIndex)')
  String currentAjaxUrl;

  @Property(computed: 'getLastElapsedTime(currentAjaxUrl)')
  int lastElapsedTime;

  @property
  String errorMessage = null;

  Stopwatch _swatch = new Stopwatch();

  static List<String> _ajaxUrls = ['data/sample_xy_0.json',
                                   'data/sample_xy_1.json',
                                   'data/sample_xy_2.json',
                                   'data/sample_xy_3.json',
  ];


  ExampleApp.created() : super.created();

  @reflectable
  void updateChart(evt, detail) {
    _swatch.stop();
    set("errorMessage", null);
    (this.$$("#loading_toast") as PaperToast).open();
  }

  @reflectable
  void showError(evt, detail) {
    _swatch.stop();
    String errMsg = "Example error: ${detail['status']} ${detail['statusText']}";
    print(errMsg);
    set("errorMessage", errMsg);
    (this.$$("#error_toast") as PaperToast).open();
  }

  @reflectable
  void startRequest(evt, detail) {
    _swatch.reset();
    _swatch.start();
  }

  @reflectable skipChart(evt, detail) {
    var inc = 1;
    try {
      inc = int.parse((Polymer.dom(evt).localTarget).dataset['increment']);
    } catch (e) {
      print("WARNING: Invalid chart increment"); //leave as 1
    }
    set("currentUrlIndex", (currentUrlIndex + inc) % _ajaxUrls.length);
  }

  @reflectable
  String getAjaxUrl(idx) => idx != null ? _ajaxUrls[idx] : null;


  @reflectable
  int getLastElapsedTime([_]) => _swatch.elapsedMilliseconds;

}
