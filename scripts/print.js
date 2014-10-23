function print_intRo() {
  $('#codePrint').html(ace.edit('myEditor').getSession().getDocument().getAllLines().join('<br/>'))
  window.print()
}