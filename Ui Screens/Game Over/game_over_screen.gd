extends Control


func _ready() -> void:
	
	hide();
	
	Radio.open_menu_requested.connect( _on_radio_open_menu_requested, CONNECT_DEFERRED );


func _on_radio_open_menu_requested( menu: Consts.Menu ) -> void:
	if ( menu == Consts.Menu.GAME_OVER ):
		XVIControlAnimation.open_window( self );


func _on_main_menu_button_pressed() -> void:
	get_tree().quit();
