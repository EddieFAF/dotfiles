-- -- show symbolic links in statusline
-- function Status:name()
--   local h = cx.active.current.hovered
--   if not h then
--     return ui.Span("")
--   end
--
--   --	return ui.Span(" " .. h.name)
--   local linked = ""
--   if h.link_to ~= nil then
--     linked = " -> " .. tostring(h.link_to)
--   end
--   return ui.Span(" " .. h.name .. linked)
-- end

-- -- Show Username/Hostname in Header
-- function Header:host()
--   if ya.target_family() ~= "unix" then
--     return ui.Line {}
--   end
--   return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
-- end
--
-- function Header:render(area)
--   self.area = area
--
--   local right = ui.Line { self:count(), self:tabs() }
--   --	local left = ui.Line { self:cwd(math.max(0, area.w - right:width())) }
--   local left = ui.Line { self:host(), self:cwd(math.max(0, area.w - right:width())) }
--   return {
--     ui.Paragraph(area, { left }),
--     ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
--   }
-- end

Status:children_add(function()
  local h = cx.active.current.hovered
  if not h or not ya.user_name then
    return ui.Line {}
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ui.Span(":"),
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    ui.Span(" "),
  }
end, 500, Status.RIGHT)

function Linemode:custom()
  local year = os.date("%Y")
  local time = (self._file.cha.modified or 0) // 1

  if time > 0 and os.date("%Y", time) == year then
    time = os.date("%b %d %H:%M", time)
  else
    time = time and os.date("%b %d  %Y", time) or ""
  end

  local size = self._file:size()
  return ui.Line(string.format(" %s %s ", size and ya.readable_size(size):gsub(" ", "") or "-", time))
end

require("full-border"):setup()
