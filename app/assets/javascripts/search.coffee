do -> (
  document.getElementById("search_sort_order").addEventListener("change", ((e) ->
    raw_url = decodeURI location.href
    order_param = /search\[sort_order\]=[a-z_]+/
    console.log raw_url
    console.log e
    if raw_url.match order_param
      location.href = encodeURI(raw_url.replace(order_param, "search[sort_order]=" + this.value))
    else
      location.href = encodeURI(raw_url + "&search[sort_order]=" + this.value)
  ))
)
