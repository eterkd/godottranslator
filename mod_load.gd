extends Node

func _load_game_folder_mod_pck() -> bool:
	var game_base_dir: String = OS.get_executable_path().get_base_dir()
	var mod_dir = game_base_dir.path_join("Translation")
	var pck_target_path: String = game_base_dir.path_join("mod_translation.pck")
	
	if not FileAccess.file_exists(pck_target_path):
		return false

	return ProjectSettings.load_resource_pack(pck_target_path)

func _ready() -> void:
	if _load_game_folder_mod_pck():
		print("[Mod Success] mod_translation.pck 로드 완료!")
		
		var target_script_path = "res://mod_translation.gd"

		if ResourceLoader.exists(target_script_path):
			var script_res = load(target_script_path)
			
			if script_res:
				var new_mod_node = Node.new()
				new_mod_node.name = "ModTranslationNode"
				new_mod_node.set_script(script_res)
				
				get_tree().root.call_deferred("add_child", new_mod_node)
				
				print("[Mod Link] mod_translation.gd 지연 구동 시작 완료!")