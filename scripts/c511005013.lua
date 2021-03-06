--Otonari Thunder
--  By Shad3

local self=c511005013

function self.initial_effect(c)
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_FIELD)
  e1:SetCode(EVENT_SPSUMMON_PROC)
  e1:SetRange(LOCATION_DECK)
  e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
  e1:SetCondition(self.sum_cd)
  e1:SetOperation(self.sum_op)
  c:RegisterEffect(e1)
end

if not self.Set_hunder then
  self.Set_hunder={ --This should be replaced when there's 'hunder' archetype
    [21524779]=true, --Mahunder
    [84530620]=true, --Pahunder
    [57019473]=true, --Sishunder
    [48049769]=true, --Thunder Seahorse
    [84417082]=true, --Number 91
    [511002059]=true, --Number 91 (A)
    [511005003]=true, --Brohunder
    [511005013]=true --Otonari Thunder (this!)
    --Rolling Thunder, Thunder Mountain to be added
  }
end

function self.hunder_fil(c)
  return c:IsFaceup() and self.Set_hunder[c:GetCode()]
end

function self.sum_cd(e,c)
  if c==nil then return true end
  local tp=c:GetControler()
  return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsAnyMatchingCard(tp,self.hunder_fil,LOCATION_MZONE,0,4,nil)
end

function self.sum_op(e,tp,eg,ep,ev,re,r,rp,c)
  Duel.ShuffleDeck(tp)
end