$(document).ready(function() {
$('.select2').each(function(i, e){
  var select = $(e)
  options = {}
  if (select.hasClass('ajax')) {
    options.ajax = {
      url: select.data('source'),
      dataType: 'json',
      data: function(term, page) { return { q: term, page: page, per: 10 } },
      results: function(data, page) { return { results: data } }
    }
    options.dropdownCssClass = "bigdrop"
  }
  select.select2(options)
})
})
