--Brohunder
--  I'll just copy Sishunder

local self=c511005003

function self.initial_effect(c)
  --remove
  local e1=Effect.CreateEffect(c)
  e1:SetDescription(aux.Stringid(511005003,0))
  e1:SetCategory(CATEGORY_REMOVE)
  e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
  e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e1:SetCode(EVENT_SUMMON_SUCCESS)
  e1:SetTarget(self.rmtg)
  e1:SetOperation(self.rmop)
  c:RegisterEffect(e1)
end
function self.filter(c)
  return c:IsRace(RACE_THUNDER) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:GetLevel()==4
    and c:GetCode()~=511005003 and c:IsAttackBelow(1600) and c:IsAbleToRemove()
end
function self.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and self.filter(chkc) end 
  if chk==0 then return Duel.IsExistingTarget(self.filter,tp,LOCATION_GRAVE,0,1,nil) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
  local g=Duel.SelectTarget(tp,self.filter,tp,LOCATION_GRAVE,0,1,1,nil)
  Duel.SetOperationInfo(0,HINTMSG_REMOVE,g,1,0,0)
end
function self.rmop(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetRange(LOCATION_REMOVED)
    e1:SetCountLimit(1)
    e1:SetOperation(self.thop)
    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e1)
  end
end
function self.thop(e,tp,eg,ep,ev,re,r,rp)
  Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
  Duel.ConfirmCards(1-tp,e:GetHandler())
end