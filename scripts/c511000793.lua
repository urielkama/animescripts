--Zero Gate of the Void
function c511000793.initial_effect(c)
	--Return
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511000793.rcon1)
	e1:SetTarget(c511000793.rtg)
	e1:SetOperation(c511000793.rop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e1:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c511000793.rcon2)
	c:RegisterEffect(e2)
end
function c511000793.rcon1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)>0 then return false end
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if not ex then
		ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
		if not ex or not Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER) then return false end
		if (cp==tp or cp==PLAYER_ALL) and cv>=Duel.GetLP(tp) then return true end
	else return (cp==tp or cp==PLAYER_ALL) and cv>=Duel.GetLP(tp)
	end
	return false
end
function c511000793.rcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)==0 and Duel.GetBattleDamage(tp)>=Duel.GetLP(tp)
end
function c511000793.filter(c,e,tp)
	return c:IsCode(81020646) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000793.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,81020646,0,0x2021,3000,3000,8,RACE_DRAGON,ATTRIBUTE_DARK) end
	e:SetType(EFFECT_TYPE_ACTIVATE)
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
end
function c511000793.rop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.CreateToken(tp,81020646)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetTargetRange(1,0)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DESTROY)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e2:SetLabel(1-tp)
		e2:SetOperation(c511000793.leaveop)
		e2:SetReset(RESET_EVENT+RESET_OVERLAY)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e3:SetCode(EFFECT_DRAW_COUNT)
		e3:SetTargetRange(1,0)
		e3:SetValue(0)
		e3:SetCondition(c511000793.drcon)
		Duel.RegisterEffect(e3,tp)
	end
end
function c511000793.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_ZERO_GATE=0x53
	Duel.Win(e:GetLabel(),WIN_REASON_ZERO_GATE)
end
function c511000793.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0
end
