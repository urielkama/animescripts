--The Phantom Knights Shade Brigandine
function c511001976.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001976.target)
	e1:SetOperation(c511001976.activate)
	c:RegisterEffect(e1)
	--Trap activate in set turn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCondition(c511001976.cond)
	c:RegisterEffect(e2)
end
function c511001976.cond(e)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_TRAP)
end
function c511001976.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001976,0,0x11,0,800,4,RACE_WARRIOR,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511001976.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001976,0,0x11,0,800,4,RACE_WARRIOR,ATTRIBUTE_DARK) then
		c:AddTrapMonsterAttribute(TYPE_NORMAL,ATTRIBUTE_DARK,RACE_WARRIOR,4,0,800)
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_DEFENCE)
		c:TrapMonsterBlock()
	end
end
