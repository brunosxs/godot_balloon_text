extends Control

var p
func _ready():
	rect_size = Vector2(16,16)

func ex_update(p):
	self.p = p
	update()
	
func _draw():
	if not p or not is_inside_tree():
		return
	
	if p.vertices.size()==0:
		return
	
	var scale = Vector2(1,1)/get_global_transform().basis_xform_inv(Vector2(1,1))
	draw_set_transform(p._offset*scale, 0, scale)
		
	var y = p.globalY
	
	for l in p.lines:
		print("This is l contents: ", l)
		if p.typewriter_effect_time > 0:
			var i = 0
			var letter_offset = 0
			var letter = draw_char(p.font, Vector2(l[0],y)+p.of,l[1][i],"",p.text_color)
			print("Current char being drawn: ", l[1][i])
			print("letter offset ", letter_offset)
			yield(get_tree().create_timer(p.typewriter_effect_time), "timeout")
			letter_offset += letter
			i+=1
			while i < l[1].length():
				print("Current char being drawn: ", l[1][i])
				letter = draw_char(p.font,Vector2(l[0]+letter_offset,y)+p.of,l[1][i],"",p.text_color)
				print("letter offset ", letter_offset)
				yield(get_tree().create_timer(p.typewriter_effect_time), "timeout")
				letter_offset+= letter
				i+=1

		else:
			draw_string(p.font,Vector2(l[0],y)+p.of,l[1], p.text_color)
		y += l[2]
