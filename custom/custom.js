

if (Jupyter) {
  $(Jupyter.events).on("app_initialized.NotebookApp", function() {

    var utils = require("base/js/utils");
    IPython.Cell.options_default.cm_config.lineNumbers = true;

  });
} else {
  $([IPython.events]).on("app_initialized.NotebookApp", function() {
    IPython.Cell.options_default.cm_config.lineNumbers = true;
  });
}

IPython.Cell.options_default.cm_config.lineNumbers = true;
