library ajax_backed_model.ajax_backed_model;

import 'dart:html';
import 'ajax_backed_model.dart';
import 'package:polymer/polymer.dart';

export 'ajax_backed_model.dart';

@behavior
/// An element that is backed by a an ajax-generated model
abstract class AjaxBackedModelBehavior implements PolymerElement {
  static const DEFAULT_MODEL_NAME = "ajaxModel";

  @property ///The url from which to load this model
  String ajaxUrl;

  @property ///Load this model automatically whenever ajaxUrl is set
  bool autoLoad = false;

  //@property
  //AjaxBackedModel model = null;


  ///Provides an instance of the backed model
  AjaxBackedModel get modelInstance;

  AjaxBackedModel get ajaxModel => get(modelName);

  ///The name of the property serving as model.  Default "ajaxModel"
  String get modelName => DEFAULT_MODEL_NAME;

  @reflectable
  @Observe('ajaxUrl,autoLoad')
  valueChanged([_, __]) {
    if (autoLoad && ajaxUrl != null && ajaxUrl.isNotEmpty) {
      //dispatchEvent(new CustomEvent('modelrequest', detail: ajaxUrl));
      fire('ajax-model-request', detail: ajaxUrl, canBubble: false);
      loadModelFromAjax();
    }
  }

    /// load the model from its ajax source
  loadModelFromAjax() async {
    return HttpRequest.getString(ajaxUrl).then((resp) {
      try {
        AjaxBackedModel thisModel = modelInstance..setFromJsonString(resp);
        set(modelName, thisModel);
        fire('ajax-model-response', detail: thisModel, canBubble: false);
      } catch(error) {
        fire('ajax-model-error',
             detail: { 'status': error.runtimeType, 'statusText': error.toString()},
            canBubble: false);
      }
    }).catchError((error) {
      set(modelName, modelInstance); //set to default (empty?) model instance
      fire('ajax-model-error',
           detail: { 'status': error.target.status, 'statusText': error.target.statusText},
           canBubble: false);

    });
  }


  //static created(instance) { }
}
