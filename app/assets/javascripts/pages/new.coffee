do -> (
  body = $("#form-pages-new-body")
  preview = $("#form-pages-new-body-preview")
  last_body = ""
  update_preview = () -> (
    $.post(
      "/api/v1/markdown_renderer/transform",
      { markdown: body.val() },
      (data) -> (
        preview.html(data.html)
        # make textbox and preview the same size
        body.height(preview.height()) if preview.height() > body.height()
      ),
      "json"
    )
  )
  # auto update
  window.setInterval(
    (->
      if (
        body.val() != last_body &&
        document.getElementById("form-pages-new-autoupdate").checked
      )
        last_body = body.val()
        update_preview()
    ),
    3000
  )
  # manual update
  document.getElementById("form-pages-new-manualupdate").addEventListener("click", update_preview)
  # handle <tab> in textarea
  body.keydown(((e) ->
    if e.keyCode == 9
      start = this.selectionStart
      end = this.selectionEnd

      target = e.target
      value = target.value

      target.value = value.substring(0, start) + "  " + value.substring(end)

      this.selectionStart = this.selectionEnd = start + 2

      e.preventDefault()
  ))
  # warn on unload
  window.onbeforeunload = (-> "Your edits were not saved!")
  document.getElementById("form-pages-new-submit").addEventListener("click", (-> window.onbeforeunload = null))
)
