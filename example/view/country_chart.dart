@HtmlImport('country_chart.html')
library polymer_ajax_backed_model.example.view.country_chart;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_listbox.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/google_chart.dart';
import 'package:polymer_elements/iron_pages.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_ajax_backed_model_behavior/polymer_ajax_backed_model_behavior.dart';

import '../model/country.dart';
import '../model/country_list.dart';
import 'country_item.dart';
import 'country_detail.dart';


@PolymerRegister('country-chart')
class CountryChart extends PolymerElement with PolymerMixin, PolymerBase, JsProxy, AjaxBackedModelBehavior {

  static const HEADER_ROW = const ["x", "y", const {"role": "annotation"}, const {"role": "annotationText"}];
  static const ERROR_ROW = const [0, 0, "Error", "err"];

  @Property(computed: 'getChartData(ajaxModel)')
  List data;

  @property
  int selectedCountry = -1;

  @property Map options = {
    "title": "Meaningless Data",
    "hAxis": {"title": "X", "minValue": -90, "maxValue": 90},
    "vAxis": {"title": "Y", "minValue": -180, "maxValue": 180},
    "legend": "none",
    "pointSize": 22,
    "width" : 400,
    "height" : 400,
    "theme":"maximized",
    'animation':{ 'duration': 500, 'easing': 'out', 'startup':false },
    "colors" : ["#ad004c"]
  };

  CountryChart.created() : super.created();

  AjaxBackedModel get modelInstance => new CountryList();

  @reflectable getChartData(AjaxBackedModel m) {
    set("selectedCountry", -1);
    List outData = []..add(HEADER_ROW);
    CountryList cList = m as CountryList;
    if (cList.list.length > 0) {
      cList.list.forEach((Country c) => outData.add([ c.x, c.y, c.name, c.id]));
    } else {
       outData.add(ERROR_ROW);
    }
    return outData;
  }

  @reflectable selectCountry(evt, detail) {
    var cId = null;
    try {
      cId = ((Polymer.dom(evt).rootTarget as CountryItem).ajaxModel as Country).id;
    } catch (e) {
      print("Invalid country id"); //leave unset
    }
    set("selectedCountry", cId);
  }

   @reflectable chartSelect(evt, detail) {
     if ((evt.target as GoogleChart).selection.length  > 0) {
       int row = ((evt.target as GoogleChart).selection[0]['row']) + 1;
       int cId = (evt.target as GoogleChart).data[row][3];
       set("selectedCountry", cId);
       fire('country-select', detail: cId, canBubble: false);
     }
   }



}
