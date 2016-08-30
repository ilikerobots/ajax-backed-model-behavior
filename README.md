# ajax-backed-model-behavior 

[![Pub](https://img.shields.io/pub/v/polymer_ajax_backed_model_behavior.svg?maxAge=2592000?style=flat-square)](https://pub.dartlang.org/packages/polymer_ajax_backed_model_behavior)
[![Travis](https://img.shields.io/travis/ilikerobots/ajax-backed-model-behavior.svg?maxAge=2592000?style=flat-square)](https://travis-ci.org/ilikerobots/ajax-backed-model-behavior)

A Dart Polymer behavior that provides a Polymer element with a model derived from an ajax request.


## Usage

First, make your model class implement AjaxBackedModel and its abstract
method ```setFromJsonString```. This method handles deserialization of
JSON into an existing instance of the model.  

Next, create a Polymer element that will utilize the model, by 
implementing AjaxBackedModelBehavior.  The element must implement 
```get modelInstance``` which returns an instance of the model class
above.  

With the above wiring, the polymer element gains additional attributes
which simplify its use.  For example:

```html
<my-element auto-load ajax-url="http://mydomain/api/data.json"></my-element>
```

With the usage above, the json returned from ```data.json``` will be
converted to the model object and assigned to the "ajaxModel" attribute
when the element is readied.  The element's html can 
reference model data as ```[[ajaxModel.myField]]```.

## Attributes

 * ```ajax-url```: The url to the data source, e.g. a rest endpoint or data
file 
 *  ```auto-load```: if true, then any changes to ```ajax-url``` will 
result in the model being updated with the result of a new ajax 
request.
 *  ```ajax-model```: may be used to set the model directly for situations 
 where it is not necessary to look up the model via ajax

## Events

AjaxBackedModelBehavior may fire the following three events

 * ajax-model-request, detail: String containing url
 * ajax-model-response, detail: AjaxBackedModel 
 * ajax-model-error, detail: Map containing 'status' and  'statusText'

## Changing the model attribute name

If desired, the model attribute name can be changed from the default 
("ajaxModel").  Override the method ```get modelName```.   See [example](https://github.com/ilikerobots/ajax-backed-model-behavior/blob/master/example/view/country_detail.dart).


## Future improvements

I would like to provide a @AjaxModel annotation, and create a 
transformer automatically provide the wiring described above.


## Example


The following code illustrates a simple example of a model and a custom
Polymer element using it an ajax backed model.

```dart
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


```dart
@HtmlImport('country_detail.html')

@PolymerRegister('country-detail')
class CountryDetail extends PolymerElement with AjaxBackedModelBehavior {

  CountryDetail.created() : super.created();

  AjaxBackedModel get modelInstance => new Country();

}
```


An full example can be found in the [example directory](https://github.com/ilikerobots/ajax-backed-model-behavior/tree/master/example) and run 
via ``pub serve example`` or [viewed online](https://ilikerobots.github.io/ajax-backed-model-behavior/example/)


## Testing

To run on dartium (default): ```pub run test```  As usual, tests can be run on other platforms with ```-p<platform>```

To run tests as javascript, the pub serve and test execution must be performed separately. Run ```pub serve test --port=8080``` from one terminal and ```pub run test -pchrome --pub-serve=8080``` from a second.

Note that tests are specifically blocked from running on Firefox currently in order to utilize [Travis CI](https://pub.dartlang.org/packages/polymer_ajax_backed_model_behavior).



