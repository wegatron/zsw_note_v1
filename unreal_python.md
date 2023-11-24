```python
import unreal

import sys

  
  

def importAssets():

    obj_files = []

    for i in range(100):

        obj_files.append(f'E:/data/FLAME/shapes/flame_shape_{i}.obj')

    #obj_files.append('E:/data/FLAME/shapes/flame_shape_2.obj')

  

    # Get the AssetTools object

    asset_tools = unreal.AssetToolsHelpers.get_asset_tools()

  

    # create asset import data object        

    assetImportData = unreal.AutomatedAssetImportData()

    # set assetImportData attributes

    assetImportData.destination_path = "/Game/MetaHumans/flame"

    assetImportData.filenames = obj_files

    #assetImportData.filenames = ['/home/wegatron/win-data/data/FLAME/shapes/flame_shape_0.obj']

    assetImportData.replace_existing = True

  

    asset_tools.import_assets_automated(assetImportData)    

  

def exportSelectedAssets():

    """

    Export selected assets.

    """

    # get selected assets from content browser        

    selectedAsset = unreal.EditorAssetLibrary.find_asset_data('/Game/MetaHumans/mh_id/SK_FL0.SK_FL0').get_asset()

    # iterate over selection and export

    #create asset export task

    exportTask = unreal.AssetExportTask()

    exportTask.automated = True

    # object is the asset to be exported

    exportTask.object = selectedAsset

    exportTask.prompt = False

    # Export Skeletal Mesh assets

    if isinstance(selectedAsset, unreal.SkeletalMesh):        

        # Create class-specific exporter

        exportTask.filename = f'E:/data/FLAME/mh_shapes/flame_{sys.argv[1]}.fbx'

        # Necessary to include options or options dialog will appear

        exportTask.options = unreal.FbxExportOption()

        exportTask.options.level_of_detail  = False

        fbx_exporter = unreal.SkeletalMeshExporterFBX()        

        exportTask.exporter = fbx_exporter

        fbx_exporter.run_asset_export_task(exportTask)

  

#importAssets()

exportSelectedAssets()
```