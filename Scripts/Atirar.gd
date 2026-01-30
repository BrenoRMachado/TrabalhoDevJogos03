class_name Atacar
extends BehaviourTreeNode

func process() -> bool:
	if inimigo.player_perto():
		inimigo.atacar()
		return true
	return false
