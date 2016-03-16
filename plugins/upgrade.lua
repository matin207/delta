local function run(msg, matches)
   if msg.to.type == 'chat' and is_momod then
chat_upgrade('chat#id'..msg.to.id, ok_cb, false)
     return "گروه آپگرید شد"
   end
end
 
 return {
   patterns = {
"^[!/](upgradechat)$",
  }, 
   run = run 
 }
-- مدیر : @mohammadarak
-- ربات : @avirabot
-- هر گونه کپی برداری بدون ذکر منبع حرام است 
