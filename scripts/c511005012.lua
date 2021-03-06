--Negative Energy Generator
--  By Shad3

local self=c511005012

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  e1:SetProperty(EVENT_FLAG_CARD_TARGET)
  e1:SetCategory(CATEGORY_ATKCHANGE)
  e1:SetTarget(self.act_tg)
  e1:SetOperation(self.act_op)
  c:RegisterEffect(e1)
end

function self.act_fil(c)
  return c:IsFaceup() and c:IsAttribute(32)
end

function self.act_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return c:IsOnField() and self.act_fil(c) end
  if chk==0 then return Duel.IsExistingTarget(self.act_fil,tp,LOCATION_MZONE,0,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,Duel.SelectTarget(tp,self.act_fil,tp,LOCATION_MZONE,0,1,1,nil),1,0,0)
end

function self.act_op(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and tc:IsFaceup() then
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_BASE_ATTACK)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetValue(tc:GetBaseAttack()*3)
    tc:RegisterEffect(e1)
  end
end