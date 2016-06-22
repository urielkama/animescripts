--Djinn Orchestra
function c511002152.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002152.target)
	e1:SetOperation(c511002152.activate)
	c:RegisterEffect(e1)
end
function c511002152.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x6d) and c:IsType(TYPE_XYZ)
end
function c511002152.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c511002152.cfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511002152.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local atkg=Duel.GetMatchingGroup(c511002152.cfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 or atkg:GetCount()==0 then return end
	local atk=atkg:GetSum(Card.GetAttack)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		e1:SetValue(-atk)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
