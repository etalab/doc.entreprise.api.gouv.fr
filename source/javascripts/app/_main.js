//= require ../lib/_jquery

(function() {
  'use strict';

  function changeLanguageLabel(currentName, newName) {
    $('a[data-language-name="'+currentName+'"]').each(function() {
      this.text = newName;
    });
  }

  $(function() {
    changeLanguageLabel("yaml", "metadata")
    });
})();
