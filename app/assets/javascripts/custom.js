jQuery(document).ready(function($) {
  $("tr[data-link]").click(function() {
    window.location = $(this).data("link")
  })

  $("#quantity").change(function(){
    if (parseInt(this.max) < parseInt(this.value) || parseInt(this.value) < 1) {
      alert("Should be less the remaining inventory or it should be proper positive integer");
      return false;
    }
  })
  $(".productRmv").click(function() {
    product_id = this.id.split('_')[0]
  })
});
