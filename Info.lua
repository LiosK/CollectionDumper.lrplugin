-- Collection Dumper Lightroom Plug-in
--
-- @copyright 2020 LiosK
-- @license: Apache-2.0
return {
  LrSdkVersion = 10.0,
  LrToolkitIdentifier = "net.liosk.lightroom.CollectionDumper",
  LrPluginName = "Collection Dumper",
  LrPluginInfoUrl = "https://github.com/LiosK/CollectionDumper.lrplugin",
  VERSION = {
    major = 0,
    minor = 1,
    revision = 1,
  },
  LrLibraryMenuItems = {
    title = "Dump Collections as JSON",
    file = "DumpCollections.lua",
  },
}
