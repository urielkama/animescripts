--Decisive Power of Absolute Destiny
function c511002417.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002417.target)
	e1:SetOperation(c511002417.activate)
	c:RegisterEffect(e1)
end
function c511002417.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummon(1-tp) 
		and Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_DECK,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,564)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c511002417.filter(c,code,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002417.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummon(1-tp) then return end
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(1-tp,c511002417.filter,1-tp,LOCATION_DECK,0,1,1,nil,ac,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
	else
		local dg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
		Duel.ConfirmCards(tp,dg)
		Duel.ShuffleDeck(1-tp)
	end
end
