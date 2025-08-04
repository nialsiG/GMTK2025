extends Control

const DIMETRODON_INFO = preload("res://resources/info/dimetrodon_info.tres") as InfoResource
const GEROBATRACHUS_INFO = preload("res://resources/info/gerobatrachus_info.tres") as InfoResource
const DIPLOCAULUS_INFO = preload("res://resources/info/diplocaulus_info.tres") as InfoResource
const GNATHORHIZA_INFO = preload("res://resources/info/gnathorhiza_info.tres") as InfoResource
const MAMAYOCARIS_INFO = preload("res://resources/info/mamayocaris_info.tres") as InfoResource
const MEGANEURA_INFO = preload("res://resources/info/meganeura_info.tres") as InfoResource
const ORTHACANTHUS_INFO = preload("res://resources/info/orthacanthus_info.tres") as InfoResource

@onready var info_texture_rect: TextureRect = %InfoTextureRect
@onready var info_title_label: Label = %InfoTitleLabel
@onready var info_rich_text_label: RichTextLabel = %InfoRichTextLabel

func ReplaceInfo(info_resource: InfoResource):
	info_texture_rect.texture = info_resource.info_texture
	info_title_label.text = info_resource.info_name
	info_rich_text_label.clear()
	info_rich_text_label.append_text(info_resource.info_description)

func _on_gerobatrachus_button_pressed():
	ReplaceInfo(GEROBATRACHUS_INFO)

func _on_dimetrodon_button_pressed():
	ReplaceInfo(DIMETRODON_INFO)

func _on_orthacanthus_button_pressed():
	ReplaceInfo(ORTHACANTHUS_INFO)

func _on_diplocaulus_button_pressed():
	ReplaceInfo(DIPLOCAULUS_INFO)

func _on_mamayocaris_button_pressed():
	ReplaceInfo(MAMAYOCARIS_INFO)

func _on_meganeura_button_pressed():
	ReplaceInfo(MEGANEURA_INFO)

func _on_gnathorhiza_button_pressed():
	ReplaceInfo(GNATHORHIZA_INFO)
