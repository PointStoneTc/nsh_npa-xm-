  function callBack() {
    var win = frameElement.api.opener;
    win.reloadTable();
    frameElement.api.close();
  }