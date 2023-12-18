extends Control
#to do
# 1-10-100-max buying system
# scale price of upgrades
# hide upgrades


# JPS values
var chrisJPS = 1
var alluJPS = 4
var DDJPS = 50
var nasiJPS = 250
var activaJPS = 1000
# counters and JPS
var chris_count = 0
var allu_count = 0
var DD_count = 0
var nasi_count = 0
var activa_count = 0
@export var counter = 0
var JPS = 0


#price values
var chris_price = 30.0
var allu_price = 100.0
var dd_price = 1000.0
var nasi_price = 13000.0
var activa_price = 100000.0
#current value storage
var chris_current = chris_price
var allu_current = allu_price
var dd_current = dd_price
var nasi_current = nasi_price
var activa_current = activa_price 


#scene loading
var chris_entity_scene = load("res://scenes/chrispath.tscn")
var allu_arjun_entity_scene = load("res://scenes/allu_arjunpath.tscn")

var buy_tab = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$JIA_PARTICLES.emitting = false
	$clicked_counter.text = "click jia to start"
	hide_upgrades()
	
	
	#print(counter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter+=1*JPS*delta
	if JPS > 0:
		$JIA_PARTICLES.emitting = true
		$JIA_PARTICLES.amount_ratio = JPS
		jps_update()
	if counter>0:
		counter_update()
	tab_update_buy(buy_tab,false,-1)
	upgrade_check()


var player_clicking: bool  = false
var player_stopped_clicking: bool = true
func _on_texture_button_pressed():
	counter+=1
	$click.play()
	player_clicking = true
	player_stopped_clicking = false
	if(player_clicking==true):
		jia_emissions()
	else:
		jia_stop_emitting()
	player_stopped_clicking = true
	counter_update()



#emission system
func _on_texture_button_button_up():
	await get_tree().create_timer(1.0).timeout
	if (player_stopped_clicking==true):
		jia_stop_emitting()
func jia_emissions():
	$JIA_PARTICLES_CLICK.emitting = true
	$JIA_PARTICLES_CLICK.amount = 15
func jia_stop_emitting():
	$JIA_PARTICLES_CLICK.emitting = false


# updates
func counter_update():
	$clicked_counter.text = ("number of jias %d" % counter)
func jps_update():
	$JPS_meter.text = ("JPS (Jias Per Second): %d" % JPS)
func upgrade_check():
	if (counter>99):
		$UPGRADES/ALLUARJUN_UPGRADE.visible = true
	if (counter>999):
		$UPGRADES/FATHERDD_UPGRADE.visible = true
	if (counter>12999):
		$UPGRADES/NASI_UPGRADE.visible = true
	if (counter>99999):
		$UPGRADES/ACTIVA_UPGRADE.visible = true
func hide_upgrades():
	$UPGRADES/ALLUARJUN_UPGRADE.visible = false
	$UPGRADES/FATHERDD_UPGRADE.visible = false
	$UPGRADES/NASI_UPGRADE.visible = false
	$UPGRADES/ACTIVA_UPGRADE.visible = false

# buying system
func calculateMaxPrice(price,bought):
	return (price*(1+bought*0.2))

func determineMaxBuy(currency,price):
	var twenty
	while(currency>=price):
		price+=(price*0.2)
	twenty = (price*0.2)
	price = price - twenty
	round(price)
	return price

# the reason both these functions are literally the same thing is because idk how to return multiple values and im too lazy to figure it out as well
func determineMaxBuyAMT(currency,price):
	var bought = 0
	if(currency==price):
		return 1
	if(currency>price):
		while(currency>price):
			bought+=1
			price+=(price*0.2)
		return bought-1
	else:
		return 0

var temp_chris
var temp_allu
var temp_dd
var temp_nasi
var temp_activa
var max_chris
var max_allu
var max_dd
var max_nasi
var max_activa
func tab_update_buy(tab,clicked,choice):
	var price
	var bought
	var chrisButton = $UPGRADES/CHRIS_UPGRADE/VBoxContainer/chris_UP_button
	var alluButton = $UPGRADES/ALLUARJUN_UPGRADE/VBoxContainer/allu_UP_button
	var ddButton = $UPGRADES/FATHERDD_UPGRADE/VBoxContainer/DD_UP_button
	var nasiButton = $UPGRADES/NASI_UPGRADE/VBoxContainer/nasi_UP_button
	var activaButton = $UPGRADES/ACTIVA_UPGRADE/VBoxContainer/activa_UP_button
	match tab:
		0:
			bought = 1
			temp_chris  = update_1s_price(chris_current,chris_count)
			temp_allu = update_1s_price(allu_current,allu_count)
			temp_dd = update_1s_price(dd_current,DD_count)
			temp_nasi = update_1s_price(nasi_current,nasi_count)
			temp_activa = update_1s_price(activa_current,activa_count)
			price_label_update(temp_chris,chrisButton,chris_price)
			price_label_update(temp_allu,alluButton,allu_price)
			price_label_update(temp_dd,ddButton,dd_price)
			price_label_update(temp_nasi,nasiButton,nasi_price)
			price_label_update(temp_activa,activaButton,activa_price)
		1:
			bought = 10
			temp_chris = update_10s_price(10,chris_current,false)
			temp_allu = update_10s_price(10,allu_current,false)
			temp_dd = update_10s_price(10,dd_current,false)
			temp_nasi = update_10s_price(10,nasi_current,false)
			temp_activa = update_10s_price(10,activa_current,false)
			price_label_update(temp_chris,chrisButton,chris_price)
			price_label_update(temp_allu,alluButton,allu_price)
			price_label_update(temp_dd,ddButton,dd_price)
			price_label_update(temp_nasi,nasiButton,nasi_price)
			price_label_update(temp_activa,activaButton,activa_price)
		2:
			bought = 100
			temp_chris = update_10s_price(100,chris_current,false)
			temp_allu = update_10s_price(100,allu_current,false)
			temp_dd = update_10s_price(100,dd_current,false)
			temp_nasi = update_10s_price(100,nasi_current,false)
			temp_activa = update_10s_price(100,activa_current,false)
			price_label_update(temp_chris,chrisButton,chris_price)
			price_label_update(temp_allu,alluButton,allu_price)
			price_label_update(temp_dd,ddButton,dd_price)
			price_label_update(temp_nasi,nasiButton,nasi_price)
			price_label_update(temp_activa,activaButton,activa_price)
		3:
			max_chris = (determineMaxBuyAMT(counter,chris_current))
			max_allu = (determineMaxBuyAMT(counter,allu_current))
			max_dd = (determineMaxBuyAMT(counter,dd_current))
			max_nasi = (determineMaxBuyAMT(counter,nasi_current))
			max_activa = (determineMaxBuyAMT(counter,activa_current))
			
			
			temp_chris = update_10s_price(max_chris,chris_current,true)
			temp_allu = update_10s_price(max_allu,allu_current,true)
			temp_dd = update_10s_price(max_dd,dd_current,true)
			temp_nasi = update_10s_price(max_nasi,nasi_current,true)
			temp_activa = update_10s_price(max_activa,activa_current,true)
			#print(determineMaxBuyAMT(counter,chris_current))
			price_label_update(temp_chris,chrisButton,chris_price)
			price_label_update(temp_allu,alluButton,allu_price)
			price_label_update(temp_dd,ddButton,dd_price)
			price_label_update(temp_nasi,nasiButton,nasi_price)
			price_label_update(temp_activa,activaButton,activa_price)
	if(clicked):
		match choice:
			0:
				if(buy_tab==3):
					bought = max_chris
				else:
					match buy_tab:
						0:
							bought = 1
						1:
							bought = 10
						2:
							bought = 100
				if(counter>chris_current-1):
					chris_current = buy_current_choice(chrisButton,temp_chris,chris_price)
					chris_count+=bought
					$UPGRADES/CHRIS_UPGRADE/chris_UP_counter.text = ("%d" % chris_count)
					for n in range(bought):
						var chris_entity = chris_entity_scene.instantiate()
						$on_screen_upgrades.add_child(chris_entity)
					JPS+= chrisJPS * bought
				clicked = false
			1:
				if(buy_tab==3):
					bought = max_allu
				else:
					match buy_tab:
						0:
							bought = 1
						1:
							bought = 10
						2:
							bought = 100
				if(counter>allu_current-1):
					allu_current = buy_current_choice(alluButton,temp_allu,allu_price)
					allu_count+=bought
					$UPGRADES/ALLUARJUN_UPGRADE/allu_UP_counter.text = ("%d" % allu_count)
					for n in range(bought):
						var allu_entity = allu_arjun_entity_scene.instantiate()
						$on_screen_upgrades.add_child(allu_entity)
					clicked = false
					JPS+= alluJPS * bought
			2:
				if(buy_tab==3):
					bought = max_dd
				else:
					match buy_tab:
						0:
							bought = 1
						1:
							bought = 10
						2:
							bought = 100
				if(counter>dd_current-1):
					dd_current = buy_current_choice(ddButton,temp_dd,dd_price)
					DD_count+=bought
					$UPGRADES/FATHERDD_UPGRADE/DD_UP_counter.text = ("%d" % DD_count)
					clicked = false
					JPS+= DDJPS * bought
			3:
				if(buy_tab==3):
					bought = max_nasi
				else:
					match buy_tab:
						0:
							bought = 1
						1:
							bought = 10
						2:
							bought = 100
				if(counter>nasi_current-1):
					nasi_current = buy_current_choice(nasiButton,temp_nasi,nasi_price)
					nasi_count+=bought
					$UPGRADES/NASI_UPGRADE/nasi_UP_counter.text = ("%d" % nasi_count)
					clicked = false
					JPS+= nasiJPS * bought
			4:
				if(buy_tab==3):
					bought = max_activa
				else:
					match buy_tab:
						0:
							bought = 1
						1:
							bought = 10
						2:
							bought = 100
				if(counter>activa_current-1):
					activa_current = buy_current_choice(activaButton,temp_activa,activa_price)
					activa_count+=bought
					$UPGRADES/ACTIVA_UPGRADE/activa_UP_counter.text = ("%d" % activa_count)
					clicked = false
					JPS+= activaJPS * bought
func buy_current_choice(button,price,base_price):
	if(counter>price-1):
		counter-=price
		price = price_label_update(price,button,base_price)
	return price
func update_10s_price(tab,price,max):
	for n in range(tab):
		price += (price*(20.0/100.0))
	round(price)
	return price
func price_label_update(price,button,base_price):
	#print(price)
	if(price==-1):
		button.text = "%d JIAS" % price
		return price
	else:
		round(price)
		button.text = "%d JIAS" % price
		return price
func update_1s_price(price,upgrade_counter):
	if(upgrade_counter>0):
		price += (price*(20.0/100.0))
	round(price)
	return price
func _on_buy_amount_tab_clicked(tab):
	match tab:
		0:
			buy_tab = 0
			print("tab 1 selected")
		1:
			buy_tab = 1
			print("tab 2 selected")
		2:
			buy_tab = 2
			print("tab 3 selected")
		3:
			buy_tab = 3
			print("tab 4 selected")






#upgrade button press

func _on_chris_up_button_pressed():
	var clicked = true
	tab_update_buy(buy_tab,clicked,0)
	print("the new price is %f" % chris_current)
	clicked = false
func _on_allu_up_button_pressed():
	var clicked = true
	tab_update_buy(buy_tab,clicked,1)
	clicked = false
func _on_dd_up_button_pressed():
	var clicked = true
	tab_update_buy(buy_tab,clicked,2)
	clicked = false
func _on_nasi_up_button_pressed():
	var clicked = true
	tab_update_buy(buy_tab,clicked,3)
	clicked = false
func _on_activa_up_button_pressed():
	var clicked = true
	tab_update_buy(buy_tab,clicked,4)
	clicked = false












 # Replace with function body.








