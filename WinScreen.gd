extends Control

func _on_next_level_pressed():
	LevelManager.next_level()

func _on_main_menu_pressed():
	LevelManager.go_to_main_menu()

func _on_exit_game_pressed():
	get_tree().quit()

