--coded by Lyris
--Comeback
function c511007016.initial_effect(c)
	--Target 1 face-up monster your opponent controls that you own; take control of it. This card's activation and effect cannot be negated. [Change of Heart & Amplifier]
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c511007016.target)
	e1:SetOperation(c511007016.activate)
	c:RegisterEffect(e1)
end
--monster your opponent controls that you own
function c511007016.filter(c,tp)
	return c:GetOwner()==tp and c:GetControler()~=c:GetOwner() and c:IsControlerCanBeChanged()
end
function c511007016.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511007016.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511007016.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511007016.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511007016.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetControl(tc,tp) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
