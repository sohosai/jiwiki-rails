do -> (
  body = document.getElementById("form-pages-new-body")
  preview = document.getElementById("form-pages-new-body-preview")
  last_body = ""
  update_preview = () -> (
    $.post(
      "/api/v1/markdown_renderer/transform",
      { markdown: body.value },
      (data) -> (
        preview.innerHTML = data.html
      ),
      "json"
    )
  )
  # auto update
  window.setInterval(
    (->
      if (
        body.value != last_body &&
        document.getElementById("form-pages-new-autoupdate").checked
      )
        last_body = body.value
        update_preview()
    ),
    3000
  )
  # manual update
  document.getElementById("form-pages-new-manualupdate").addEventListener("click", update_preview)
  # handle <tab> in textarea
  body.addEventListener('keydown', ((e) ->
    if e.keyCode == 9
      start = this.selectionStart
      end = this.selectionEnd

      target = e.target
      value = target.value

      target.value = value.substring(0, start) + "  " + value.substring(end)

      this.selectionStart = this.selectionEnd = start + 2

      e.preventDefault()
  ),false)
  # warn on unload
  window.onbeforeunload = (-> "Your edits were not saved!")
)

