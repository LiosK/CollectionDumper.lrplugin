-- Recursive dumping functions
local dumper = {}

function dumper.dumpPhoto(photo)
  return {
    type = "photo",
    date_time = photo:getRawMetadata("dateTimeISO8601"),
    date_time_digitized = photo:getRawMetadata("dateTimeDigitizedISO8601"),
    date_time_original = photo:getRawMetadata("dateTimeOriginalISO8601"),
    file_name = photo:getFormattedMetadata("fileName"),
    file_type = photo:getFormattedMetadata("fileType"),
    is_virtual_copy = photo:getRawMetadata("isVirtualCopy"),
    path = photo:getRawMetadata("path"),
    uuid = photo:getRawMetadata("uuid"),
  }
end

function dumper.dumpCollection(collection)
  local result = {
    type = "collection",
    name = collection:getName(),
    photos = {},
  }

  for i, val in ipairs(collection:getPhotos()) do
    table.insert(result.photos, dumper.dumpPhoto(val))
  end

  return result
end

function dumper.dumpSet(set)
  local result = {
    type = "set",
    name = set:getName(),
    children = {},
  }

  for i, val in ipairs(set:getChildCollectionSets()) do
    table.insert(result.children, dumper.dumpSet(val))
  end

  for i, val in ipairs(set:getChildCollections()) do
    table.insert(result.children, dumper.dumpCollection(val))
  end

  return result
end

return dumper
