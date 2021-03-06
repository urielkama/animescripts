--Clear Robe
function c511002105.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002105.condition)
	e1:SetTarget(c511002105.target)
	e1:SetOperation(c511002105.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511002105.condition2)
	c:RegisterEffect(e2)
end
function c511002105.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	if tc:IsControler(1-tp) then
		tc=Duel.GetAttackTarget()
		bc=Duel.GetAttacker()
	end
	if not tc or not bc or tc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then return false end
	e:SetLabelObject(tc)
	if bc==Duel.GetAttackTarget() and bc:IsDefencePos() then return false end
	if bc:IsPosition(POS_FACEUP_DEFENCE) and bc==Duel.GetAttacker() then
		if not bc:IsHasEffect(EFFECT_DEFENCE_ATTACK) then return false end
		if bc:IsHasEffect(EFFECT_DEFENCE_ATTACK) then
			if bc:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1 then
				if tc:IsAttackPos() then
					if bc:GetDefence()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return bc:GetDefence()~=0
					else
						return bc:GetDefence()>=tc:GetAttack()
					end
				else
					return bc:GetDefence()>tc:GetDefence()
				end
			elseif bc:IsHasEffect(EFFECT_DEFENCE_ATTACK) then
				if tc:IsAttackPos() then
					if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return bc:GetAttack()~=0
					else
						return bc:GetAttack()>=tc:GetAttack()
					end
				else
					return bc:GetAttack()>tc:GetDefence()
				end
			end
		end
	else
		if tc:IsAttackPos() then
			if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
				return bc:GetAttack()~=0
			else
				return bc:GetAttack()>=tc:GetAttack()
			end
		else
			return bc:GetAttack()>tc:GetDefence()
		end
	end
end
function c511002105.cfilter(c,tp)
	return c:IsOnField() and c:IsType(TYPE_MONSTER) and c:IsControler(tp)
end
function c511002105.condition2(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tc+tg:FilterCount(c511002105.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c511002105.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	if ex and tg~=nil and tc+tg:FilterCount(c511002105.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c511002105.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	if ex and tg~=nil and tc+tg:FilterCount(c511002105.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c511002105.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	if ex and tg~=nil and tc+tg:FilterCount(c511002105.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c511002105.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_RELEASE)
	if ex and tg~=nil and tc+tg:FilterCount(c511002105.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c511002105.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOGRAVE)
	if ex and tg~=nil and tc+tg:FilterCount(c511002105.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c511002105.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	return false
end
function c511002105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and (tc:GetAttack()>0 or tc:GetDefence()>0) end
	Duel.SetTargetCard(tc)
end
function c511002105.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_CHAIN)
		e2:SetValue(c511002105.efilter)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_ATTACK_FINAL)
		e3:SetValue(0)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_SET_DEFENCE_FINAL)
		tc:RegisterEffect(e4)
	end
end
function c511002105.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
