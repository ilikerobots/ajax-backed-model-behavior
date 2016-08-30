library ajax_backed_model.ajax_backed_model;


/// A model that is formed from an ajax string
abstract class AjaxBackedModel {
  void setFromJsonString(String json);
}

