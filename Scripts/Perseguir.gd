class_name Perseguir
extends BehaviourTreeNode

func process() -> bool:
	if !inimigo.player_perto():
		inimigo.caminhar()
		return true
	return false
