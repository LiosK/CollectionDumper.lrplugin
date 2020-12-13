local LrDialogs = import "LrDialogs"
local dumper = require "dumper"
local json = require "json"

local function asyncMain()
  local result = {}

  local catalog = import "LrApplication".activeCatalog()
  for i, val in ipairs(catalog:getChildCollectionSets()) do
    table.insert(result, dumper.dumpSet(val))
  end
  for i, val in ipairs(catalog:getChildCollections()) do
    table.insert(result, dumper.dumpCollection(val))
  end

  while true do
    local path = LrDialogs.runSavePanel({
      title = "Save collection dump",
      requiredFileType = "json",
    })
    if path == nil then break end

    local fh = io.open(path, "w")
    if fh == nil then
      LrDialogs.message("Failed to save dump", "Destination: " .. path)
    else
      fh:write(json.encode(result))
      fh:close()
      break
    end
  end
end

if "ok" == LrDialogs.confirm("Dump all the collections as JSON text?","This may take several minutes.") then
  import("LrTasks").startAsyncTask(asyncMain)
end
