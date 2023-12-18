extends Node


#process constantly updates counters,
#currency counter
#jps counter
#all upgrade price counters



var upgrade_dict = {
	"chris":{"JPS":1,"Count":0,"basePrice":30.0,"currentPrice":30.0},
	"allu":{"JPS":4,"Count":0,"basePrice":100.0,"currentPrice":100.0},
	"DD":{"JPS":50,"Count":0,"basePrice":1000.0,"currentPrice":1000.0},
	"nasi":{"JPS":250,"Count":0,"basePrice":13000.0,"currentPrice":13000.0},
	"activa":{"JPS":1000,"Count":0,"basePrice":100000.0,"currentPrice":100000.0},
}

@export var player_dict = {
	"JPS":0,
	"Currency":0
}

func _process(delta):
	update_jps_currency_counter()
	update_upgrade_price()


func update_jps_currency_counter():
	print(player_dict.Currency)
	print(player_dict.JPS)
func update_upgrade_price():
	print(upgrade_dict.chris.currentPrice)



func buying_upgrade(currentPrice,upgradeCount,buyAmount,JPS):
	player_dict.JPS += buyAmount*JPS
	upgradeCount+= buyAmount
	for n in range(buyAmount):
		currentPrice = calculatePriceChange(currentPrice)
	player_dict.Currency-=currentPrice
	return {
		currentPriceR = currentPrice,
		upgradeCountR = upgradeCount
	}

func calculatePriceChange(currentPrice):
	currentPrice += (currentPrice*(20.0/100.0))
	return currentPrice

@export var buyAmt = 1
func onChrisClickExample():
	var result = buying_upgrade(upgrade_dict.chris.currentPrice,upgrade_dict.chris.Count,buyAmt,upgrade_dict.chris.JPS)
	upgrade_dict.chris.currentPrice = result.currentPriceR
	upgrade_dict.chris.Count = result.upgradeCountR

func _ready():
	onChrisClickExample()
	print("Currency:%d\nJPS:%d\nCurrent Price:%f\nCurrent Count:%d" % [player_dict.Currency,player_dict.JPS,upgrade_dict.chris.currentPrice,upgrade_dict.chris.Count])
	
