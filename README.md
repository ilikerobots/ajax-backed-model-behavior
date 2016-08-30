# ajax-backed-model-behavior 

[![Pub](https://img.shields.io/pub/v/polymer_ajax_backed_model_behavior.svg?maxAge=2592000?style=flat-square)](https://pub.dartlang.org/packages/polymer_ajax_backed_model_behavior)
[![Travis](https://img.shields.io/travis/ilikerobots/ajax-backed-model-behavior.svg?maxAge=2592000?style=flat-square)](https://travis-ci.org/ilikerobots/ajax-backed-model-behavior)

A Dart Polymer behavior that provides a Polymer element with a model derived from an ajax request.


## Usage

First, create a model class implementing AjaxBackedModel.  The model must 
implement the method ```setFromJsonString```.  

Next, create a Polymer element that will utilize the model, by 
implementing AjaxBackedModelBehavior.  The element must implement 
```get modelInstance``` which returns an instance of the desired model 
above.  

The element is now ready to use.   For example:

```
<my-element auto-load ajax-url="http://mydomain/api/data.json"></my-element>
```

With the usage above, the json returned from ```data.json``` will be
converted to the model object and assigned to the "model" attribute
on element when the element is readied.  Thus the element's html can 
reference model data as ```[[model.attribute]]```.

If ```auto-load``` is true, then any changes to ```ajax-url``` will 
result in the model being updated with the result of a new ajax 
request.

In situations where it is not necessary to look up the model via ajax,
the model may set directly, e.g.
```
<my-element model="[[item]]"></my-element>
```

Ajax loading may be deferred by setting ```ajax url``` but
leaving ```auto-load``` false.  Later, ```loadModelFromAjax```  may be
called whenever desired.  If  ```auto-load``` is set later set to true,
then normal automatic loading will resume.


## Events

AjaxBackedModelBehavior may fire the following three events

 * ajax-model-request, detail: String containing url
 * ajax-model-response, detail: AjaxBackedModel 
 * ajax-model-error, detail: Map containing 'status' and  'statusText'



## Future improvements

I would like to provide a @AjaxModel annotation on the model class,
and let a transformer automatically provide the wiring c:w
ode.


## Example



```
import 'package:polymer/polymer.dart';
import 'package:polymer_ajax_backed_model_behavior/ajax_backed_model.dart';
import 'dart:convert';

class Country extends Object with AjaxBackedModel, JsProxy {

  @reflectable int id;
  @reflectable String name;

  Country();

  setFromJsonString(String json) {
    id = o['id'];
    name = o['country'];
  }
}
```


```
@HtmlImport('country_detail.html')
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_ajax_backed_model_behavior/polymer_ajax_backed_model_behavior.dart';
import '../model/country.dart';

@PolymerRegister('country-detail')
class CountryDetail extends PolymerElement with PolymerMixin, PolymerBase, JsProxy, AjaxBackedModelBehavior {

  CountryDetail.created() : super.created();

  AjaxBackedModel get modelInstance => new Country();

}
```



An example can be found in the example directory and run via ``pub serve example``.



## Testing

To run on dartium (default): ```pub run test```  As usual, tests can be run on other platforms with ```-p<platform>```

To run tests as javascript, the pub serve and test execution must be performed separately. Run ```pub serve test --port=8080``` from one terminal and ```pub run test -pchrome --pub-serve=8080``` from a second.

Note that tests are specifically blocked from running on Firefox currently in order to utilize [Travis CI](https://pub.dartlang.org/packages/polymer_ajax_backed_model_behavior).



